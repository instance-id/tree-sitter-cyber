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
(number) @number

; String
(string) @string

(identifier) @variable

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

(function_definition 
  "func" @keyword.function
  (function_declaration) @function)

(function_definition 
  "func" @keyword.function
  (method_declaration) @function.method)

(function_declaration
  (identifier) @function
  (parameter_list) @parameters)

; (method_declaration 
;   (self) @variable)

; Object declaration
(object_declaration
  "type"  @keyword
  (type_identifier) @type.definition
  "object" @keyword)

(expression_statement
  (call_expression) @function.call)  

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

(assignment 
  left: (_) @variable)

; Parameter list
(parameter_list 
  (parameter) @parameter 
  (#set! parent_highlight_name "parameters"))

(parameter 
  (identifier) @parameter)

(field_expression 
  "." @punctuation.delimiter)

(call_expression
  (identifier) @function.call)

(call_expression
  (field_expression
    object: (identifier) @variable
    (identifier) @function.call))

(key_value_pair) @property

(map_literal 
  "{" @punctuation 
  "}" @punctuation)

(member_assignment 
  ":" @punctuation)

(member_assignment 
  (identifier) @property
  ":" @punctuation
  (identifier) @property)

(coinit_expression 
  (coinit) @keyword.coroutine)

(coinit_declaration
  (identifier) @function)

(coresume_expression 
  (coresume) @keyword.coroutine)

(coyield_statement 
  (coyield) @keyword.coroutine)

; Interpolated strings
(interpolated_string 
  "\"" @string.quote 
  (interpolation)+ "\"" @string.quote)

(interpolation 
  "{" @string.special 
  (_) @variable 
  "}" @string.special)

; Tag expression
(tag_expression 
  "#" @tag)

; --| Keywords --------------
; --|------------------------
[ "," ":" ] @punctuation.delimiter

[ "(" ")" "[" "]" "{" "}" ] @punctuation.bracket

[ "-" "-=" "!=" "*" "*=" "/" "//" "/=" "&" "%" 
  "^" "+" "+=" "<" "<<" "<=" "<>" "=" "==" ">"
  ">=" ">>" "|" "and" "in" "is" "not" "or" ".." ] @operator

[ "type" "var" "static" "capture" "as" "each" ] @keyword

[ "print" ] @function.builtin

[ "tagtype" "atype" "none" "any" ] @type.builtin

[ "else" "if" "match" "then" ] @conditional

[ "do" "for" "while" "break" "continue" ] @repeat

[ "import" "export" ] @include

[ "try" "catch" "recover" ] @exception

