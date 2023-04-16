;identifiers
; (identifier) @variable
;  ((identifier) @constant
;   (#lua-match? @type "^[A-Z][A-Z_0-9]*$"))

; ((identifier) @function.method
;  (#is-not? local))


; ((identifier) @type
;    (#lua-match? @type "^[A-Z][a-zA-Z_0-9]*$"))  

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
open_brace: (_) @punctuation.bracket
close_brace: (_) @punctuation.bracket

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
  ((identifier) @type
   (#lua-match? @variable "^[A-Z][a-zA-Z_0-9]*$")))

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
  (func) @function
  "(" @punctuation.bracket
  ")" @punctuation.bracket)

(function_definition 
  (func) @keyword.function
  (function_declaration
    name: (identifier) @function) @function)

(function_definition 
  (func) @keyword.function
  (method_declaration
    (method_parameter_list) @parameters)) @function.method

(function_declaration
  (identifier) @function)

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

(object_initializer 
  (type_identifier) @type
  "{" @punctuation
  "}" @punctuation)

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

(parameter 
  (identifier) @parameter)

(field_expression
  ((identifier) @variable
   (#is? @variable "var"))
  property: (identifier) @property)

; --| Object/Member ---------
; (object_parameter
;   object_mapping: (identifier) @parameter)

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
(cfunc_call) @function.call
(symbol_parameter) @parameter

(ret_parameter) @parameter

; --| CStruct call ------------ 
(cstruct_call) @function.call

(cstruct_call
  (object_parameter
    (identifier
      (var_identifier) @type)))

; --| Map/KV ---------------
(key_value_pair) @property

; --| findRune --------------
(encoded_string
  (numeric_literal) @number)

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


(enclosed_expression
  [
   "(" 
   "{"
   "["
  ] @punctuation.bracket
  [
   ")" 
   "}" 
   "]"
   ] @punctuation.bracket)

(index_expression
  [
   "[" @punctuation
   "]" @punctuation
   ])

; Tag expression
(tag_expression 
  "#" @tag
  tag: (identifier) @type)

 
; --| Keywords --------------
; --|------------------------
[ "," ":" ] @punctuation.delimiter

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

