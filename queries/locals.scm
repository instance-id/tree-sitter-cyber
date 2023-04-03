
(var_ident) @definition.var

(import_statement
  (identifier) @definition.var)

(assignment
  left: (pattern) @definition.var)


(function_definition
  (function_declaration
    (identifier) @definition.function))

(function_definition
  (function_declaration
    (parameter_list
      (parameter
        (identifier) @definition.parameter ))))

(parameter_list
  (parameter
    (identifier) @definition.parameter))

(object_declaration
  ((type_ident) @variable
  (#set! "definition.type.scope" "parent"))) @definition.type

(object_initializer
  (type_ident) @reference.type)

(function_definition (block) @scope)
(object_declaration (block) @scope)

(if_statement (block) @scope)
(block) @scope
