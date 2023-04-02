;identifiers
; (identifier) @variable
;  ((identifier) @constant
;  (#lua-match? @constant "^[A-Z][A-Z_0-9]*$"))

(var_ident) @variable
(type_ident) @type
(import_export) @include
(builtin_type) @type.builtin
(exception_identifiers) @exception
(repeat_identifiers) @repeat
(builtin_function) @function.builtin

; (keyword) @variable

; Shebang
(shebang) @comment

; Comment
(comment) @comment

; Number
(number) @number

; String
(string) @string

; Function Declaration
; (func) @keyword.function

; (statement_indicator) @punctuation.delimiter

; ":" @punctuation.delimiter
[
  ","
  ":"
] @punctuation.delimiter

; Import statement
(import_statement 
  "import" @include
  (string) @module)

(local_declaration 
  (identifier) @local.definition
  (#set! parent_highlight_name "local"))

; Function definition

(function_definition) @function

(function_definition 
  "func" @keyword.function
  (function_declaration) @function)

(function_declaration
  (identifier) @function
  (parameter_list) @parameters)

(call_identifier) @function.call
(call_expression)  @function.call

; (call_expression 
;   name: (field_expression) @function)

(call_expression 
  (identifier) @function.call
  "(" @punctuation.bracket
  ")" @punctuation.bracket)

(call_expression 
  (identifier) @property
  (call_identifier) @function.call)

(field_expression 
  "." @punctuation.delimiter)

(field_expression 
  object: (identifier) @property
  (accessor) @property)

(field_expression 
  object: (identifier) @property
  (call_identifier) @function.call) 

(field_expression 
  object: (identifier) @property
  (identifier) @property) 

(key_value_pair) @property

(for_range_loop 
  "for" @keyword 
  (identifier) @variable)

(for_iterable_loop 
  "for" @keyword 
  (identifier) @variable)

(for_optional_loop 
  "for" @keyword 
  (identifier) @variable)

(map_literal 
  "{" @punctuation 
  "}" @punctuation)

; Object declaration
(object_declaration
  "object" @keyword.class 
  (identifier) @type)

(object_initializer 
  (identifier) @type 
  "{" @punctuation 
  "}" @punctuation)

(member_assignment 
  ":" @punctuation)

(member_assignment 
  (identifier) @property
  ":" @punctuation
  (identifier) @property)

(assignment 
  left: (pattern) @property
  right: (identifier) @property)

(tagtype_declaration 
  "tagtype" @keyword 
  (identifier) @type)

; Parameter list
(parameter_list 
  (parameter) @variable 
  (#set! parent_highlight_name "parameters"))

(parameter 
  (identifier) @variable)

; Var declaration
(var_declaration
  "var" @keyword 
  (identifier) @variable)

; Block
(block 
  (#set! parent_highlight_name "block"))

; If statement
(if_statement 
  "if" @keyword)

; Loop statement
(loop_statement 
  "loop" @keyword)

; While loop
(while_loop 
  "while" @keyword)

(coinit_expression 
  (coinit) @keyword
  (coinit_declaration) @function)

(coresume_expression 
  (coresume) @keyword)

(coyield_statement 
  (coyield) @keyword)

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

; Return statement
(return_statement 
  "return" @keyword)

[ "(" ")" "[" "]" "{" "}" ] @punctuation.bracket

[ "-" "-=" "!=" "*" "*=" "/" "//" "/=" "&" "%" 
  "^" "+" "+=" "<" "<<" "<=" "<>" "=" "==" ">"
  ">=" ">>" "|" "and" "in" "is" "not" "or" ".." ] @operator

[ "func" "object" "atype" "tagtype" "true" "false" 
  "none" "var" "static" "capture" "as" "each" ] @keyword

[ "else" "if" "match" "then" ] @conditional

[ "do" "for" "while" "break" "continue" ] @repeat

[ "import" "export" ] @include

[ "try" "catch" "recover" ] @exception
