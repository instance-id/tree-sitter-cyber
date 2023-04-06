#!cyber
import os 'os'

POST_HEADER = "
const Color LIGHTGRAY_ = LIGHTGRAY;
const Color GRAY_ = GRAY;
const Color DARKGRAY_ = DARKGRAY;
const Color YELLOW_ = YELLOW;
const Color GOLD_ = GOLD;
const Color ORANGE_ = ORANGE;
const Color PINK_ = PINK;
const Color RED_ = RED;
const Color MAROON_ = MAROON;
const Color GREEN_ = GREEN;
const Color LIME_ = LIME;
const Color DARKGREEN_ = DARKGREEN;
const Color SKYBLUE_ = SKYBLUE;
const Color BLUE_ = BLUE;
const Color DARKBLUE_ = DARKBLUE;
const Color PURPLE_ = PURPLE;
const Color VIOLET_ = VIOLET;
const Color DARKPURPLE_ = DARKPURPLE;
const Color BEIGE_ = BEIGE;
const Color BROWN_ = BROWN;
const Color DARKBROWN_ = DARKBROWN;
const Color WHITE_ = WHITE;
const Color BLACK_ = BLACK;
const Color BLANK_ = BLANK;
const Color MAGENTA_ = MAGENTA;
const Color RAYWHITE_ = RAYWHITE;
"

args = os.args()
headerPath = args[2]

headerSrc = readFile(headerPath).utf8()
writeFile('temp.h', headerSrc.concat(POST_HEADER))

res = execCmd(['/bin/bash', '-c', 'zig translate-c temp.h'])
zigSrc = res.out
writeFile('bindings.zig', zigSrc)

-- Build output string.
out = ''

-- State.
var structs: {}      -- structName -> list of fields (ctype syms)
var aliases: {}      -- aliasName -> structName or binding symbol (eg: #voidPtr)
var arrays: {}       -- [n]typeName -> true

state = #parseFirst
vars = {}            -- varName -> true
funcs = []

lines = zigSrc.split('\n')
for lines each line:
    if state == #parseFirst:
        if line.startsWith('pub const '):
            line = line['pub const '.len()..]
            if line.startsWith('__'):
                -- Skip internal defs.
                continue
            if line.startsWith('@'):
                -- Skip zig keywords idents.
                continue

            assignIdx = line.findRune(0u'i')  -- Valid
            assignIdx = line.findRune(0u'\'') -- Valid
            assignIdx = line.findRune(0x'}')  -- Valid

            -- assignIdx = line.findRune(0u''')  -- Error
            -- assignIdx = line.findRune(0x''')  -- Error
            -- assignIdx = line.findRune(u007'\')  -- Error

            beforeAssign = line[..assignIdx-1]
            idx = beforeAssign.findRune(0u':')
            if idx == none:
                name = beforeAssign
                init = line[assignIdx+2..]
                if init.startsWith('@'):
                    -- Skip `= @import`
                    continue
                if init.startsWith('struct_'):
                    -- Skip `Vector2 = struct_Vector2`
                    continue
                if init.startsWith('__'):
                    -- Skip `va_list = __builtin_va_list`
                    continue
                if init == '"";':
                    -- Skip empty defines `RAYLIB_H = "";`
                    continue

                if name.startsWith('struct_'):
                    structName = name['struct_'.len()..]
                    if init == 'opaque \{\};':
                        out = out.concat('type {structName} pointer\n')
                        aliases[structName] = #voidPtr
                    else:
                        state = #parseField
                        out = out.concat('type {structName} object:\n')
                        structFields = []
                        structs[structName] = structFields
                    continue

                if init == 'c_uint;':
                    out = out.concat('type {name} number\n')
                    aliases[name] = #uint
                    continue
                else init.startsWith('?*const'):
                    -- Function pointer type alias.
                    out = out.concat('type {name} pointer\n')
                    aliases[name] = #voidPtr
                    continue
                else init.startsWith('"'):
                    -- String constant.
                    right = init.trim(#right, ';')
                    out = out.concat('var {name}: {right}\n')
                    continue
                else:
                    -- Type alias.
                    right = init.trim(#right, ';')
                    if structs[right]:
                        -- Found existing type.
                        out = out.concat('type {name} {right}\n')
                        aliases[name] = right
                    else vars[right]:
                        -- Found existing var.
                        out = out.concat('var {name}: {right}\n')
                    else:
                        print 'TODO {line}'
            else:
                -- Has var specifier.
                name = beforeAssign[..idx]
                spec = beforeAssign[idx+2..]
                init = line[assignIdx+2..line.len()-1]
                if spec == 'c_int':
                    out = out.concat('var {name}: {init}\n')
                    vars[name] = true
        else line.startsWith('pub extern fn '):
            line = line['pub extern fn '.len()..]

            -- Parse func signature.

            -- Find start.
            idx = line.findRune(0u'(')
            name = line[..idx]
            line = line[idx+1..]

            -- Find end.
            idx = line.findRune(0u')')
            paramsStr = line[..idx]
            ret = line[idx+2..].trim(#right, ';')

            outFunc = 'func {name}('

            fn = {}
            fn['name'] = name

            -- Parse params.
            fnParamTypes = []
            params = paramsStr.split(', ')
            for params each param:
                if param.len() == 0:
                    continue
                if param == '...':
                    -- varargs unsupported
                    outFunc = none
                    break

                idx = param.findRune(0u':')
                paramName = param[..idx]
                if paramName.startsWith('@"'):
                    paramName = paramName[2..paramName.len()-1]
                paramSpec = param[idx+2..]

                paramType = getBindType(paramSpec)
                if paramType == none:
                    outFunc = none
                    break
                
                outFunc = outFunc.concat('{paramName} {getCyName(paramType)}, ')
                fnParamTypes.append(paramType)

            if outFunc != none:
                if fnParamTypes.len() > 0:
                    outFunc = outFunc[..outFunc.len()-2]

                outFunc = outFunc.concat(') ')

                retType = getBindType(ret)
                if retType != none:
                    outFunc = outFunc.concat('{getCyName(retType)} = lib.{name}')
                    out = out.concat('{outFunc}\n')

                    fn['params'] = fnParamTypes
                    fn['ret'] = retType
                    funcs.append(fn)
        else:
            -- print 'TODO {line}'
            pass
    else state == #parseField:
        if line == '};':
            state = #parseFirst
            out = out.concat('\n')
            continue

        line = line.trim(#ends, ' ,')
        idx = line.findRune(0u':')
        name = line[..idx]
        spec = line[idx+2..]

        fieldType = getBindType(spec)
        if fieldType != none:
            if fieldType == #voidPtr:
                out = out.concat('  {name} pointer -- {spec}\n')
            else typeof(fieldType) == ArrayType:
                out = out.concat('  {name} List -- {spec}\n')
            else:
                out = out.concat('  {name} {getCyName(fieldType)}\n')

-- Generate bindLib.

out = out.concat("\nimport os \'os\'\n")
out = out.concat("var lib: createLib()\n")
out = out.concat("func createLib():\n")
out = out.concat("  decls = []\n")
for funcs each fn:
    out = out.concat("  decls.append(os.CFunc\{ sym: '{fn.name}', args: [{fn.params.joinString(', ')}], ret: {fn.ret} \})\n")
for structs each name, fields:
    out = out.concat("  decls.append(os.CStruct\{ fields: [{fields.joinString(', ')}], type: {name} \})\n")
out = out.concat("  return os.bindLib('../ray-cyber/libraylib.4.5.0.dylib', decls, \{ genMap: true \})")

-- Final output.
writeFile('bindings.cy', out)

func getCyName(nameOrSym):
    if typesym(nameOrSym) == #symbol:
        sym = nameOrSym
        if sym == #voidPtr:
            return 'pointer'
        else sym == #bool:
            return 'boolean'
        else sym == #int:
            return 'number'
        else sym == #uint:
            return 'number'
        else sym == #uchar:
            return 'number'
        else sym == #long:
            return 'number'
        else sym == #float:
            return 'number'
        else sym == #double:
            return 'number'
        else sym == #voidPtr:
            return 'pointer'
        else:
            print 'TODO getCyName {nameOrSym}'
            return 'TODO'
    else:
        return nameOrSym

type ArrayType object:
    elem symbol
    n number

func getBindType(spec):
    if spec == 'void':
        return #voidPtr
    else spec == 'bool':
        return #bool
    else spec == 'c_int':
        return #int
    else spec == 'c_uint':
        return #uint
    else spec == 'u8':
        return #uchar
    else spec == 'f32':
        return #float
    else spec == 'f64':
        return #double
    else spec == 'c_long':
        return #long
    else spec.startsWith('?*'):
        return #voidPtr
    else spec.startsWith('[*c]'):
        return #voidPtr
    else spec.startsWith('['):
        idx = spec.findRune(0u']')
        n = spec[1..idx]
        elem = getBindType(spec[idx+1..])
        if elem == none:
            print 'TODO getBindType {spec}'
            return none
        return ArrayType{ elem: elem, n: n }
    else:
        if structs[spec]:
            -- Valid type.
            return spec
        else aliases[spec]:
            -- Valid alias.
            return aliases[spec]
        else:
            print 'TODO getBindType {spec}'
            return none

