const NEWLINE = token.immediate(/(\r?\n)/);
const INDENT = token.immediate(/[\t ]+/);
const DEDENT = token.immediate(/[\t ]+$/);

module.exports = grammar({
  name: "cyber",

  extras: $ => [$.comment, /\s+/],
  word: $ => $.name,
  inline: $ => [
    $._expression,
  ],

  rules: {
    source_file: $ => seq(optional($.shebang), repeat($._statement)),

    _statement: $ => choice(
      $.import_statement,
      $.declaration,
      $.assignment_statement,
      $.expression_statement,
      $.if_statement,
      $.else_statement,
      $.for_loop,
      $.loop_statement,
      $.recover_block,
      $.print_statement,
      NEWLINE,
    ),

    shebang: $ => token.immediate(/#!.*\n+/),
    name: $ => token(/[a-zA-Z_][a-zA-Z0-9_-]*/),
    integer: $ => /[0-9]+/,
    number: $ => /\d+(\.\d+)?/,
    _whitespace: $ => repeat1(' '),
    _newline: $ => choice('\n', '\r\n'),
    _whitespace_or_newline: $ => choice($._whitespace, $._newline),

    identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,
    type_identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    comment: $ => token(choice(
      seq('--', /[^-].*/, optional(/(\r?\n)/)),
      seq('---', /.*/, optional(/(\r?\n)/)),
      seq('--', /-/, repeat1(choice(/[^-]/, /-[^-]/)), /-*/, optional(/(\r?\n)/)),
    )),

    string: $ => prec(1, choice(
      seq('"', repeat(choice(/[^"{}\\]+/, /\\./, seq('{', optional($._expression), '}'))), '"'),
      seq("'", repeat(choice(/[^'{}\\]+/, /\\./, seq('{', optional($._expression), '}'))), "'")
    )),

    import_statement: $ => prec(13, seq(
      'import', $.identifier, $.string,
    )),

    // --| Declaration -----------
    // --|------------------------
    declaration: $ => choice(
      $.object_declaration,
      $.field_declaration,
      $.var_declaration,
      $.function_definition,
    ),

    object_declaration: $ => seq(
      'object', $.identifier, '{', repeat($.field_declaration), '}'
    ),

    field_declaration: $ => prec(11, seq(
      $.identifier, $.type_identifier,
    )),

    var_declaration: $ => prec.left(12, seq(
      'var', $.identifier, optional($.type_identifier), optional(seq(':', $.expression))
    )),

    function_definition: $ => prec(11, seq(
      'func', $.identifier, '(', optional($.parameter_list), ')', optional($.type_identifier), ':', $.block
    )),

    parameter_list: $ => seq(
      $.parameter, repeat(seq(',', $.parameter))
    ),

    parameter: $ => seq(
      $.identifier, $.type_identifier
    ),

    assignment_statement: $ => choice(
      prec.left(16, seq($.identifier, '=', $.expression)),
      prec.left(16, seq($.identifier, '+=', $.expression)),
      prec.left(16, seq($.identifier, '-=', $.expression)),
    ),

    // Expression statement
    expression_statement: $ => prec.left(17, seq(
      field('expression', $._expression),
    )),

    if_statement: $ => prec.left(4, seq(
      'if', $._expression, ':',
      repeat($._expression),
      optional(
        seq('else', optional($._expression) , ':', 
        repeat($._expression)
      ))
    )),

    else_statement: $ => prec.left(4, seq(
      'else', optional($._expression), ':',
      repeat($._expression)
    )),

    loop_statement: $ => prec(15, seq(
      'loop', ':',
      $.block
    )),

    for_loop: $ => seq(
      'for', field('list', $.identifier), 'each', field('element', $.identifier), ':',
      field('body', $.block)
    ),

    print_statement: $ => prec.left(2, seq(
      'print', $._expression
    )),

    // --| Blocks ----------------
    // --|------------------------
    block: $ => prec.left(1, seq(
      NEWLINE,
      INDENT,
      repeat1($._statement)
    )),

    // --| Expressions -----------
    // --|------------------------
    expression: $ => choice(
      $.identifier,
      $.number,
      $.string,
      $.function_call,
      $.interpolated_string,
      prec(1, $.try_expression),
      prec(1, $.catch_expression),
      prec(1, $.panic_expression),
      prec(1, $.coinit_expression),
      prec(2, $.coyield_expression),
      prec(2, $.coresume_expression),
      prec.left(3, seq($._expression, '.', $._expression)),
      prec.left(4, seq($._expression, '+', $._expression)),
      prec.left(4, seq($._expression, '-', $._expression)),
      prec.left(5, seq($._expression, '*', $._expression)),
      prec.left(5, seq($._expression, '/', $._expression)),
      prec.left(5, seq($._expression, '==', $._expression)),
      prec.left(5, seq($._expression, '!=', $._expression)),
      prec.left(6, seq($._expression, '<', $._expression)),
      prec.left(6, seq($._expression, '>', $._expression)),
      prec.left(6, seq($._expression, '<=', $._expression)),
      prec.left(6, seq($._expression, '>=', $._expression)),
      prec.left(7, seq($._expression, 'and', $._expression)),
      prec.left(8, seq($._expression, 'or', $._expression)),
      prec(11, $.list_expression),
      prec(11, $.map_expression),
      prec(10, $.tag_expression),
      prec.left(9, seq($._expression, '[', $._expression, ']')),
    ),

    function_call: $ => seq(
      $.identifier, '(', optional($.argument_list), ')'
    ),

    argument_list: $ => seq(
      $.expression, repeat(seq(',', $.expression))
    ),

    index_expression: $ => prec.left(1, seq(
      $._expression, '[', $._expression, ']'
    )),

    try_expression: $ => prec(11, seq(
      'try', $.expression
    )),

    catch_expression: $ => prec.left(11, seq(
      'catch',
      $.expression,
      optional(seq('then', $.expression)),
      optional(seq('as', $.identifier, 'then', $.expression))
    )),

    panic_expression: $ => prec(11, seq(
      'panic',
      $.expression
    )),

    list_expression: $ => seq(
      '[', optional($.expression_list), ']'
    ),

    map_expression: $ => seq(
      '{', optional($.key_value_pair_list), '}'
    ),

    index_expression: $ => prec.left(1, seq(
      $._expression, '[', $._expression, ']'
    )),

    parenthesized_expression: $ => prec.left(10, seq(
      '(', $._expression, ')'
    )),

    key_value_pair_list: $ => seq(
      $.key_value_pair,
      repeat(seq(',', $.key_value_pair))
    ),

    key_value_pair: $ => seq(
      $.expression, ':', $.expression
    ),

    tag_expression: $ => seq(
      '#', $.identifier
    ),

    expression_list: $ => seq(
      $.expression,
      repeat(seq(',', $.expression))
    ),

    coinit_expression: $ => seq(
      'coinit',
      $.function_call
    ),

    coyield_expression: $ => prec(11, seq(
      'coyield',
      $.expression
    )),

    coresume_expression: $ => seq(
      'coresume',
      $.identifier
    ),

    recover_block: $ => seq(
      'recover', $.identifier, ':',
      $.block
    ),

    interpolated_string: $ => prec.left(11, seq(
      '"', repeat(choice(/[^"{]+/, $.interpolation)), '"'
    )),

    interpolation: $ => prec.left(12, seq(
      '{', $._expression, '}'
    )),

    body: $ => prec.left(seq(
      optional(seq(INDENT, $.shebang))
    )),

    _expression: $ => choice($.expression, $.block),
  }
});
