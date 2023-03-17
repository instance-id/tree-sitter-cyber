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
  "func" @function)

; Function calls
(function_call
  (identifier) @function)

; Punctuation
((function_call
  "(" @punctuation
  ")" @punctuation))
((argument_list
  "," @punctuation))
((key_value_pair
  ":" @punctuation))
((list_expression
  "[" @punctuation
  "]" @punctuation))
((map_expression
  "{" @punctuation
  "}" @punctuation))

; Object declaration
(object_declaration
  "object" @class)

; Field declaration
(field_declaration
  (identifier) @property)

; Parameter list
(parameter_list
  (parameter) @parameter)

; Var declaration
(var_declaration
  "var" @variable)

; Block
(block)

; Loop statement
(loop_statement
  "loop" @keyword)

; For loop
(for_loop
  "for" @keyword
  "each" @keyword)

; If statement
(if_statement
  "if" @keyword)

; Else statement
(else_statement
  "else" @keyword)

; Assignment statement
((assignment_statement
  "=") @operator)
((assignment_statement
  "+=") @operator)
((assignment_statement
  "-=") @operator)

; Expression statement
(expression_statement)

; Interpolated strings
(interpolated_string
  "\"" @string.quote
  "\"" @string.quote)

(interpolation
  "{" @string.special
  (expression) @string.special
  "}" @string.special  )


; Number
(number) @number

; String
(string) @string

; List expression
(list_expression)

; Map expression
(map_expression)

; Tag expression
(tag_expression
  "#" @tag)

"func" @keyword.function

[
 "("
 ")"
 "["
 "]"
 "{"
 "}"
]  @punctuation.bracket


;; [
;;   "object"
;;   "atype"
;;   "tagtype"
;;   "true"
;;   "false"
;;   "none"
;;   "var"
;;   "static"
;;   "capture"
;;   "as"
;; ] @keyword

;; [
;;   "coinit"
;;   "coyield"
;;   "coresume"
;; ]
;; @keyword.coroutine

;; [
;;   "else"
;;   "if"
;;   "match"
;;   "then"
;; ] @conditional

;; [
;;   "do"
;;   "for"
;;   "while"
;;   "yield"
;; ] @repeat

;; ["import" "export"] @include


;; [
;;   "try"
;;   "catch"
;;   "recover"
;; ] @exception

;; "return" @keyword.return