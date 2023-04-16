(identifier) @reference
((identifier) @reference
  (#set! "reference.scope" "parent"))


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

(function_definition
  (function_declaration
   name: (identifier) @name) @definition.function) @scope

(typed_statement
  ((type_identifier) @definition.type
   (#set! "definition.type.scope" "global")))

(typed_statement
  ((type_identifier) @definition.type
   (#set! "definition.type.scope" "global"))
  (object_definition 
    (object_block
      (object_member
        ((identifier) @definition.var
                      (#set! "definition.var.scope" "parent")))) @scope))

(object_initializer
  (member_assignment
    (identifier) @reference.var))

(object_initializer
  ((type_identifier) @reference
                (#set! "reference.scope" "parent")))
  
(field_expression
  (identifier) @reference.var)

(function_definition (block) @scope)
(object_block) @scope

(if_statement (block) @scope)
(block) @scope
