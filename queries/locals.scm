(identifier) @reference

((type_identifier) @reference
                   (set! reference.kind "type"))

(import_statement
  (identifier) @definition.var)

(var_identifier) @definition.var

(local_declaration) @definition.var

(local_declaration
  (identifier) @definition.var)

(augmented_assignment
  left: (pattern) @definition.var)

((function_definition
  (function_declaration
    ((identifier) @definition.function) @scope))
 (#set! definition.function.scope "parent"))

((typed_statement
  (type_identifier) @definition.type) @scope
  (#set! "definition.type.scope" "parent"))

((object_definition 
  (object_block
    (object_member
      (identifier) @definition.var) @scope) @scope)
 (#set! "definition.var.scope" "parent"))

(object_initializer
  (member_assignment
    (identifier) @reference.var))

((object_initializer
  (type_identifier) @reference.type)
 (#set! "reference.type.scope" "parent"))

((object_member
  (identifier) @definition.var) @scope
  (#set! "definition.var.scope" "parent"))

(field_expression
  (identifier) @reference.var)

(function_definition (block) @scope)

(parameter 
  (identifier) @definition.parameter)

(object_block) @scope

(if_statement (block) @scope)
(block) @scope
