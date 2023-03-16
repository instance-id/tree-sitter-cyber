const NEWLINE = token.immediate(/(\r?\n)+/);
const INDENT = token.immediate(/[\t ]+/);
const DEDENT = token.immediate(/[\t ]+$/);

module.exports = grammar({
  name: "cyber",

  extras: $ => [
     $.comment,
      /\s+/,
    ],
  word: $ => $.name,

  inline: $ => [
    $._expression,
  ],

  rules: {
    // Add your language grammar rules here.
    // source_file: $ => repeat( $._statement),
    source_file: $ => seq(optional($.shebang), repeat($._statement)),

    _statement: $ => choice(
      // $.shebang,
      $.object_declaration,
      $.function_definition,
      $.var_declaration,
      $.import_statement,
      $.if_statement,
      $.for_loop,
      $.loop_statement,
      $.assignment_statement,
      $.expression_statement,
      $.comment,
      NEWLINE,
    ),

    // --| Tokens ----------------
    // --|------------------------

    shebang: $ => token.immediate(/#!.*\n+/),
    comment: $ => token(seq('--', /.*/)),
    name: $ => token(/[a-zA-Z_][a-zA-Z0-9_-]*/),

    _whitespace: $ => repeat1(' '),
    _newline: $ => choice( '\n', '\r\n'),
    _whitespace_or_newline: $ => choice( $._whitespace, $._newline),
    number: $ => /\d+(\.\d+)?/,
    string: $ => /'[^']*'/,
    
    identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,
    type_identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    object_declaration: $ => seq(
      'object',
      $.identifier,
      '{',
      repeat($.field_declaration),
      '}'
    ),

    field_declaration: $ => seq(
      $.identifier,
      $.type_identifier,
      optional(';')
    ),

    function_definition: $ => prec(11, seq(
      'func',
      $.identifier,
      '(',
      optional($.parameter_list),
      ')',
      optional($.type_identifier),
      ':',
      $.block
    )),

    parameter_list: $ => seq(
      $.parameter,
      repeat(seq(',', $.parameter))
    ),

    parameter: $ => seq(
      $.identifier,
      $.type_identifier
    ),

    var_declaration: $ => prec.left(12, seq(
      'var',
      $.identifier,
      optional($.type_identifier),
      optional(seq(':', $.expression)),
      optional(';')
    )),

    import_statement: $ => prec(13, seq(
      'import',
      $.identifier,
      $.string
    )),

    block: $ => prec.left(1, seq(
      NEWLINE,
      INDENT,
      repeat1($._statement)
    )),

    // If statement
    if_statement: $ => prec.right(14, seq(
      'if',
      $.expression,
      ':',
      $.block,
      optional($.else_clause)
    )),

    else_clause: $ => seq(
      'else',
      choice(
        seq(':', $.block),
        $.if_statement
      )
    ),

    // Loop statement
    loop_statement: $ => prec(15, seq(
      'loop',
      ':',
      $.block
    )),

    for_loop: $ => seq(
      'for',
      field('list', $.identifier),
      'each',
      field('element', $.identifier),
      ':',
      field('body', $.block)
    ),

    // Assignment statement
    assignment_statement: $ => prec.left(16, seq(
      $.identifier,
      '=',
      $.expression,
      optional(';')
    )),

    // Expression statement
    expression_statement: $ => prec.left(17, seq(
      field('expression', $._expression),
      optional(';') // Make the semicolon optional or sould it not exist?
    )),

    // Add more expression rules
    // --| Expressions -----------
    // --|------------------------
    expression: $ => choice(
      $.identifier,
      $.number,
      $.string,
      $.function_call,
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
      prec.left(7, seq($._expression, 'and', $._expression)), // Add 'and' precedence
      prec.left(8, seq($._expression, 'or', $._expression)), // Add 'or' precedence
      prec.right(7, seq('if', $._expression, ':')),
      prec.right(7, seq('else', ':')),
      prec(11, $.list_expression), // Set precedence for list_expression
      prec(11, $.map_expression), // Set precedence for map_expression
      prec(10, $.tag_expression),// Set precedence for tag_expression
      // Add more expressions as needed
    ),

    function_call: $ => seq(
      $.identifier,
      '(',
      optional($.argument_list),
      ')'
    ),

    argument_list: $ => seq(
      $.expression,
      repeat(seq(',', $.expression))
    ),

    try_expression: $ => prec(11, seq(
      'try',
      $.expression
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

    // List expression
    list_expression: $ => seq(
      '[',
      optional($.expression_list),
      ']'
    ),

    // Map expression
    map_expression: $ => seq(
      '{',
      optional($.key_value_pair_list),
      '}'
    ),

    key_value_pair_list: $ => seq(
      $.key_value_pair,
      repeat(seq(',', $.key_value_pair))
    ),

    key_value_pair: $ => seq(
      $.expression,
      ':',
      $.expression
    ),

    // Tag expression
    tag_expression: $ => seq(
      '#',
      $.identifier
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

    // Add recover block
    recover_block: $ => seq(
      'recover',
      $.identifier,
      ':',
      $.block
    ),

    body: $ => prec.left(seq(
      optional(seq(INDENT, $.shebang))
    )),

    _expression: $ => choice($.expression, $.block),
  }
});



// module.exports = grammar({

//   name: "cyber",

//   extras: $ => [
//     $.comment,
//     /[\s\n]/,
//   ],

//   inline: $ => [
//     $._expression,
//   ],

//   rules: {
//     source_file: $ => repeat($._expression),

//     _expression: $ => choice(
//       $.identifier,
//       $.integer,
//       $.string,
//       $.function_call,
//       $.interpolated_string,
//       $.assignment,
//       $.import_statement,
//       $.if_statement,
//       $.func_definition,
//       $.return_statement,
//       $.print_statement,
//       $.exit_statement,
//       $.equality_expression,
//       $.inequality_expression,
//       $.index_expression,
//       $.map_expression,
//       $.parenthesized_expression,
//       $.method_call_expression
//     ),

//     comment: $ => token(seq('--', /.*/), 'comment'),
//     shebang: $ => token(seq('#!', /.*/), 'shebang'),
//     identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,
//     integer: $ => /[0-9]+/,
//     string: $ => /"[^"]*"/,

//     import_statement: $ => seq(
//       'import',
//       $.identifier,
//       "'",
//       $.identifier,
//       "'"
//     ),

//     import_alias: $ => seq(
//       $.identifier,
//       'as',
//       $.identifier
//     ),

//     map : $ => seq(
//       '{',
//       optional(seq($.identifier, ':', $._expression, repeat(seq(',', $.identifier, ':', $._expression)))),
//       '}'
//     ),

//     function_call: $ => prec.left(1, seq(
//       $.identifier,
//       '(',
//       optional(seq($._expression, repeat(seq(',', $._expression)))),
//       ')'
//     )),

//     assignment: $ => prec.left(2, seq(
//       $.identifier,
//       '=',
//       $._expression
//     )),

//     print_statement: $ => prec.left(2, seq(
//       'print',
//       $._expression
//     )),

//     equality_expression: $ => prec.left( 2, seq(
//       $._expression,
//       '==',
//       $._expression
//     )),

//     index_expression: $ => prec.left(1, seq(
//       $._expression,
//       '[',
//       $._expression,
//       ']'
//     )),

//     method_call_expression: $ => prec.left(1, seq(
//       $._expression,
//       '.',
//       $.identifier,
//       '(',
//       optional(seq($._expression, repeat(seq(',', $._expression)))),
//       ')'
//     )),

//     return_statement: $ => prec.left(2, seq(
//       'return',
//       $._expression
//     )),

//     inequality_expression: $ => prec.left(3, seq(
//       $._expression,
//       '!=',
//       $._expression
//     )),

//     if_statement: $ => prec.left(4, seq(
//       'if',
//       $._expression,
//       ':',
//       repeat($._expression),
//       optional(seq('else', ':', repeat($._expression)))
//     )),

//     func_definition: $ => prec.left(5, seq(
//       'func',
//       $.identifier,
//       '(',
//       optional(seq($.identifier, repeat(seq(',', $.identifier)))),
//       ')',
//       repeat($._expression)
//     )),

//     exit_statement: $ => prec.left(8, seq(
//       'exit',
//       $.integer
//     )),

//     map_expression: $ => prec.left(9, seq(
//       '{',
//       optional(seq($.identifier, ':', $._expression, repeat(seq(',', $.identifier, ':', $._expression)))),
//       '}'
//     )),

//     parenthesized_expression: $ => prec.left(10, seq(
//       '(',
//       $._expression,
//       ')'
//     )),

//     interpolated_string: $ => prec.left(11, seq(
//       '"',
//       repeat(choice(/[^"{]+/, $.interpolation)),
//       '"'
//     )),

//     interpolation: $ => prec.left(12, seq(
//       '{',
//       $._expression,
//       '}'
//     )),

//     _statement: $ => choice(
//       $.function_call,
//       $.assignment,
//       $.import_statement,
//       $.if_statement,
//       $.func_definition,
//       $.return_statement,
//       $.print_statement,
//       $.exit_statement
//     ),

//     _primary_expression: $ => choice(
//       $.identifier,
//       $.integer,
//       $.string,
//       $.function_call,
//       $.interpolated_string,
//       $.map_expression,
//       $.parenthesized_expression,
//       $.method_call_expression
//     ),

//     _binary_expression: $ => choice(
//       $.equality_expression,
//       $.inequality_expression,
//       $.index_expression
//     ),

//     _unary_expression: $ => choice(
//       $.print_statement
//     ),

//     _declaration: $ => choice(
//       $.assignment,
//       $.import_statement,
//       $.func_definition
//     ),

//     _control_flow: $ => choice(
//       $.if_statement,
//       $.return_statement,
//       $.exit_statement
//     ),
//   },
//   conflicts: $ => [
//     [$.equality_expression, $.if_statement],
//   ],
// });




// module.exports = grammar({
//   name: "cyber",

//   extras: $ => [
//     $.comment,
//     /[\s\n]/,
//   ],

//   inline: $ => [
//     $._expression,
//   ],

//   rules: {
//     source_file: $ => repeat($._expression),

//     _expression: $ => choice(
//       $.identifier,
//       $.integer,
//       $.string,
//       $.function_call,
//       $.interpolated_string,
//       $.assignment,
//       $.import_statement,
//       $.if_statement,
//       $.func_definition,
//       $.return_statement,
//       $.print_statement,
//       $.exit_statement,
//       $.equality_expression,
//       $.inequality_expression,
//       $.index_expression,
//       $.map_expression,
//       $.parenthesized_expression,
//       $.method_call_expression
//     ),

//     comment: $ => token(seq('--', /.*/), 'comment'),
//     shebang: $ => token(seq('#!', /.*/), 'shebang'),
//     identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,
//     integer: $ => /[0-9]+/,
//     string: $ => /"[^"]*"/,

//     import_alias: $ => seq(
//       $.identifier,
//       'as',
//       $.identifier
//     ),

//     map : $ => seq(
//       '{',
//       repeat(seq($.identifier, ':', $._expression)),
//       '}'
//     ), 

//     assignment: $ => prec.left(2, seq(
//       $.identifier,
//       '=',
//       $._expression
//     )),

//     print_statement: $ => prec.left(2, seq(
//       'print',
//       $._expression
//     )),

//     equality_expression: $ => prec.left(seq(
//       $._expression,
//       '==',
//       $._expression
//     )),

//     index_expression: $ => prec.left(1, seq(
//       $._expression,
//       '[',
//       $._expression,
//       ']'
//     )),

//     method_call_expression: $ => prec.left(1, seq(
//       $._expression,
//       '.',
//       $.identifier,
//       '(',
//       ')'
//     )),

//     return_statement: $ => prec.left(2, seq(
//       'return',
//       $._expression
//     )),

//     inequality_expression: $ => prec.left(3, seq(
//       $._expression,
//       '!=',
//       $._expression
//     )),

//     if_statement: $ => prec.left(4, seq(
//       'if',
//       $._expression,
//       ':',
//       repeat($._expression)
//     )),

//     func_definition: $ => prec.left(5, seq(
//       'func',
//       $.identifier,
//       choice($.identifier, $.parenthesized_expression),
//       repeat($._expression)
//     )),

//     function_call: $ => prec.left(6, seq(
//       $.identifier,
//       '(',
//       ')'
//     )),

//     import_statement: $ => prec.left(7, seq(
//       'import',
//       $.identifier,
//       "'",
//       $.identifier,
//       "'"
//     )),

//     exit_statement: $ => prec.left(8, seq(
//       'exit',
//       $.integer
//     )),

//     map_expression: $ => prec.left(9, seq(
//       '{',
//       repeat(seq($.identifier, ':', $._expression)),
//       '}'
//     )),

//     parenthesized_expression: $ => prec.left(10, seq(
//       '(',
//       $._expression,
//       ')'
//     )),

//     interpolated_string: $ => prec.left(11, seq(
//       '"',
//       repeat(choice(/[^"{]+/, $.interpolation)),
//       '"'
//     )),

//     interpolation: $ => prec.left(12, seq(
//       '{',
//       $._expression,
//       '}'
//     )),

//     _statement: $ => choice(
//       $.function_call,
//       $.assignment,
//       $.import_statement,
//       $.if_statement,
//       $.func_definition,
//       $.return_statement,
//       $.print_statement,
//       $.exit_statement
//     ),

//     _primary_expression: $ => choice(
//       $.identifier,
//       $.integer,
//       $.string,
//       $.function_call,
//       $.interpolated_string,
//       $.map_expression,
//       $.parenthesized_expression,
//       $.method_call_expression
//     ),

//     _binary_expression: $ => choice(
//       $.equality_expression,
//       $.inequality_expression,
//       $.index_expression
//     ),

//     _unary_expression: $ => choice(
//       $.print_statement
//     ),

//     _declaration: $ => choice(
//       $.assignment,
//       $.import_statement,
//       $.func_definition
//     ),

//     _control_flow: $ => choice(
//       $.if_statement,
//       $.return_statement,
//       $.exit_statement
//     ),
//   },
//   conflicts: $ => [
//     [$.equality_expression, $.if_statement],
//    ],
// });