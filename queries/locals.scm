(import_statement
  (identifier) @definition.var)


(var_identifier) @definition.var

(import_statement
  (identifier) @definition.var)

(assignment
  left: (pattern) @definition.var)


(function_definition
  (function_declaration
   name: (identifier) @name) @definition.function) @scope

(function_definition
  (function_declaration
    (parameter_list
      (parameter
        (identifier) @definition.parameter)))) @scope

(parameter_list
  (parameter
    (identifier) @definition.parameter))

; (object_definition
;   ((object_declaration)+
;     ((identifier) @definition.type
;   (#set! "definition.type.scope" "parent"))
;   (identifier) @reference.type)) @definition.type

  ; ((identifier) @variable
  ;             (#set! "definition.type.scope" "parent"))
  ; (identifier) @reference.type) @definition.type

; (object_initializer
;   (identifier
;     (type_identifier) @type))

(object_initializer
  (type_identifier) @reference.type)

(function_definition (block) @scope)
(object_definition (object_block) @scope)

(if_statement (block) @scope)
(block) @scope
