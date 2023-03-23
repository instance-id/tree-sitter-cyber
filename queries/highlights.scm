; Identifiers
(identifier) @variable

; Shebang
(shebang) @comment

; Comment
(comment) @comment

; Import statement
(import_statement 
  "import" @include
  (identifier) @module)

; Function definition
(function_definition 
  "func" @function 
  (identifier) @function.name)

; Function calls
(function_call 
  (identifier) @function 
  (argument_list) @punctuation.bracket)

(function_call 
  (identifier) @function)

((key_value_pair ":" @punctuation))

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

(object_declaration 
  "object" @keyword.class 
  (identifier) @entity.name.class)

(object_initializer 
  (identifier) @type 
  "{" @punctuation 
  "}" @punctuation)

(member_assignment 
  (identifier) @property ":" @punctuation (expression) @property)

(tagtype_declaration 
  "tagtype" @keyword (identifier) @type)

; Field declaration
(field_declaration 
  (identifier) @property)

(field_declaration 
  (identifier) @property 
  (type_identifier) @type)

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

; Assignment statement
(assignment_statement 
  "=" @operator)

(coyield_statement 
  (coyield) @keyword)

; Interpolated strings
(interpolated_string 
  "\"" @string.quote 
  (interpolation)+ "\"" @string.quote)

(interpolation 
  "{" @string.special 
  (expression) @variable 
  "}" @string.special)

; Number
(number) @number

; String
(string) @string

; Tag expression
(tag_expression 
  "#" @tag)

; Return statement
(return_statement 
  "return" @keyword)

[ 
  "(" ")" "[" "]" "{" "}"
] @punctuation.bracket

[
 "-" "-=" "!=" "*" "*=" "/" "//" "/=" "&" "%" 
 "^" "+" "+=" "<" "<<" "<=" "<>" "=" "==" ">"
 ">=" ">>" "|" "and" "in" "is" "not" "or"
] @operator

[ 
  "object" "atype" "tagtype" "true" "false" 
  "none" "var" "static" "capture" "as" "each"
] @keyword

[
 "else" "if" "match" "then" 
] @conditional

[
 "do" "for" "while" "break" "continue" 
] @repeat

[
 "import" "export"
] @include

[
 "try" "catch" "recover" 
] @exception

[
 ".."
] @operator.range

[
 "each"
] @keyword
