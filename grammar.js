module.exports = grammar({
  name: "cyber",

  extras: $ => [/\s/],

  rules: {
    source_file: $ => repeat($._top_level_statement),

    _top_level_statement: $ => choice(
      $.shebang,
      $.comment,
      $.import_statement,
      $.assignment,
      $.if_statement,
      $.function_definition
    ),

    _inner_statement: $ => choice(
      $.comment,
      $.assignment,
      $.if_statement,
      $.function_definition
    ),

    shebang: $ => /#![^\n]*\n/,

    comment: $ => /--.*/,

    import_statement: $ => seq(
      "import",
      $.identifier,
      $.alias
    ),

    identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    alias: $ => seq(
      "'",
      $.identifier,
      "'"
    ),

    assignment: $ => seq(
      $.identifier,
      "=",
      $._expression
    ),

    _expression: $ => choice(
      $.function_call,
      $.string,
      $.map,
      $.identifier
    ),

    function_call: $ => seq(
      $.identifier,
      "(",
      optional($._expression),
      ")"
    ),

    string: $ => /"[^"]*"/,

    map: $ => seq(
      "{",
      optional(seq(
        $.key_value,
        repeat(seq(",", $.key_value))
      )),
      "}"
    ),

    key_value: $ => seq(
      $.identifier,
      ":",
      $._expression
    ),

    if_statement: $ => seq(
      "if",
      $._expression,
      ":",
      $.statement_block
    ),

    statement_block: $ => prec.left(repeat1($._inner_statement)),

    function_definition: $ => seq(
      "func",
      $.identifier,
      $.parameters,
      $.statement_block
    ),

    parameters: $ => seq(
      "(",
      optional(seq(
        $.identifier,
        repeat(seq(",", $.identifier))
      )),
      ")"
    ),
  }
});
