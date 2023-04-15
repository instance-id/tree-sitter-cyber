;identifiers
; (identifier) @variable
;  ((identifier) @constant
;   (#lua-match? @type "^[A-Z][A-Z_0-9]*$"))

; ((identifier) @function.method
;  (#is-not? local))

(var_identifier) @variable
(type_identifier) @type
(import_export) @include
(builtin_type) @type.builtin
(exception_identifiers) @exception
(repeat_identifiers) @repeat
(builtin_function) @function.builtin
(self) @parameter

; Shebang
(shebang) @comment

; Comment
(comment) @comment

; Number
(numeric_literal) @number

; String
(string) @string
(multiline_string) @string

(identifier) @variable
(boolean) @constant.builtin
(boolean_operator) @keyword
(and_operator) @keyword
(or_operator) @keyword
(not_operator) @keyword
(bang_operator) @keyword


(capture_identifier) @keyword
(lambda_operator) @punctuation.bracket
(static_identifier) @keyword
(else_identifier) @conditional
; --| Statements ------------
; --|------------------------
; Import statement
(import_statement 
  "import" @include
  (identifier) @variable
  (string) @module)

(local_declaration 
  (identifier) @variable
  (#set! parent_highlight_name "local"))

; Var declaration
(var_declaration
  "var" @keyword 
  (identifier) @variable)

(anonymous_definition
  (anonymous_function
    (func) @function))

(anonymous_function
  (func) @function)

(function_definition 
  (func) @keyword.function
  (function_declaration
    name: (identifier) @function
    ; "(" @punctuation.bracket
    ; ")" @punctuation.bracket
    ) @function)

(function_definition 
  (func) @keyword.function
  (method_declaration
    (method_parameter_list) @parameters)) @function.method
    ; open_paren: (_) @punctuation.bracket
    ; close_paren: (_) @punctuation.bracket) @function)

(function_declaration
  (identifier) @function)
  ; (parameter_list) @parameters)

; Object declaration
; (object_declaration
;   "type"  @keyword
;   type_name: (identifier) @type.definition
;   type_of: (identifier) @type)

; (object_declaration
;   ; "type"  @keyword
;   type_name: (type_identifier) @type.definition
;   type_of: (type_identifier) @type)+

; (object_definition
;  (object_block
;   (local_declaration) @member_declaration))

; (expression_statement
;   (call_expression) @function.call)  

; --| Conditional -----------
(if_statement 
  "if" @conditional)

; --| Iteration -------------
; Loop statement
(loop_statement 
  "loop" @repeat)

; While loop
(while_loop 
  "while" @repeat)

(for_range_loop 
  "for" @repeat 
  (identifier) @variable)

(for_iterable_loop 
  "for" @repeat 
  (identifier) @variable)

(for_optional_loop 
  "for" @repeat 
  (identifier) @variable)

(object_initializer 
  (type_identifier) @type) 
  ; (open_brace) @punctuation 
  ; (close_brace) @punctuation)

(tagtype_declaration 
  "tagtype" @keyword 
  (identifier) @type)

; Return statement
(return_statement 
  "return" @keyword.return)

; Block
(block 
  (#set! parent_highlight_name "block"))

; --| Expression ------------
; --|------------------------

(augmented_assignment 
  left: (_) @variable)

; Parameter list
; (parameter_list 
;   (parameter) @parameter 
;   (#set! parent_highlight_name "parameters"))

(parameter 
  (identifier) @parameter)

; --| Object/Member ---------
; (object_parameter
;   object_mapping: (identifier) @parameter)


; (fields_parameter
;   (array_literal
;     (tag_expression)* @tag             
;    )) @parameter

(member_assignment 
  ":" @punctuation)

(member_assignment 
  member: (identifier) @property)

; --| Function call ---------
(call_expression
  name: (identifier)  @function.call)

; --| Exception -------------
(error_expression
  (error) @exception)

; --| CFunc call ------------
; (cfunc_call
;   (args_parameter
;     ; (array_literal
;       (identifier
;         (var_identifier) @type)))

(cfunc_call) @function.call
(symbol_parameter) @parameter

; (args_parameter
;   (array_literal
;     (tag_expression)* @tag             
;    )) @parameter

(ret_parameter) @parameter

; --| CStruct call ------------ 
(cstruct_call) @function.call

; (cstruct_call
;   (fields_parameter
;     (array_literal
;       (identifier
;         (var_identifier) @type))))

(cstruct_call
  (object_parameter
    (identifier
      (var_identifier) @type)))

; --| Map/KV ---------------
(key_value_pair) @property

; (map_literal 
; (open_brace) @punctuation 
; (close_brace) @punctuation

; --| findRune --------------
(encoded_string
  (numeric_literal) @number)

; (codepoint 
;   (numeric_literal) @number)

(find_rune) @function.call

(find_rune
  [
   (numeric_literal) @number 
   (string) @string.escape
   (encoded_string) @string.escape
  ])

; --| Coroutine -------------

(coinit_expression 
  (coinit) @keyword.coroutine)

(coinit_declaration
  (identifier) @function)

(coresume_expression 
  (coresume) @keyword.coroutine)

(coyield_statement 
  (coyield) @keyword.coroutine)

; Interpolated strings
; (interpolated_string 
;   "\"" @string.quote 
;   (interpolation)+ "\"" @string.quote)
;
; (interpolation 
;   "{" @string.special 
;   (_) @variable 
;   "}" @string.special)

; Tag expression
(tag_expression 
  "#" @tag
  tag: (identifier) @type)

; --| Keywords --------------
; --|------------------------
[ "," ":" ] @punctuation.delimiter

; [ "(" ")" "[" "]" "{" "}" ] @punctuation.bracket
; (open_paren) @punctuation.bracket
; (close_paren) @punctuation.bracket

[ "-" "-=" "!=" "*" "*=" "/" "//" "/=" "&" "%" 
  "^" "+" "+=" "<" "<<" "<=" "<>" "=" "==" ">"
  ">=" ">>" "|" "in" "is" "not" ".." ] @keyword

[ "type" "var" "as" "each" ] @keyword

[ "print" ] @function.builtin

[ "tagtype" "atype" "none" "any" "number" "pointer" ] @type.builtin

[ "if" "match" "then" ] @conditional

[ "do" "for" "while" "break" "continue" ] @repeat

[ "import" "export" ] @include

[ "try" "catch" "recover" ] @exception

