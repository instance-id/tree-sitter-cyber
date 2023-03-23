const PREC = {
  slice: -3, lambda: -2, typed_parameter: -1, conditional: -1, parenthesized_expression: 1, parenthesized_list_splat: 1, or: 10, and: 11,
  not: 12, compare: 13, bitwise_or: 14, bitwise_and: 15, xor: 16, shift: 17, plus: 18, times: 19, unary: 20, power: 21, call: 22,
  recover_block: 23, coyield: 24,
};

module.exports = grammar({
  name: "cyber",

  extras: ($) => [$.comment, /\s+/],
  word: ($) => $.name,

  inline: ($) => [
    $._statement,
  ],

  externals: ($) => [$._INDENT, $._DEDENT, $._NEWLINE, $._line],
  conflicts: $ => [[$.expression, $.pattern],  [$.coyield_statement, $.field_declaration], ],

  rules: {
    source_file: ($) => seq(optional($.shebang), repeat($._statement)),

    _statement: ($) => choice(
      $._standard_statements,
      $._complex_statement
    ),

    _standard_statements: ($) => seq(
      $._standard_statement,
      $._NEWLINE,
    ),

    _standard_statement: ($) =>
      choice(
        $.import_statement,
        $.coyield_statement,
        $.declaration,
        $.augmented_assignment,
        $.assignment_statement,
        $.expression_statement,
        $.print_statement,
        $.return_statement,
      ),

    _complex_statement: ($) =>
      choice(
        $.if_statement,
        $.loop_statement,
        $.while_loop,
        $.for_range_loop,
        $.for_iterable_loop,
        $.for_optional_loop,
        $.recover_block
      ),

    _newline: ($) => prec(-5, seq($._NEWLINE)),
    _indent: ($) => seq(repeat($._NEWLINE), $._INDENT),
    _dedent: ($) => seq(repeat($._NEWLINE), $._DEDENT),


    number: ($) => /\d+(\.\d+)?/,
    name: ($) => token(/[a-zA-Z_][a-zA-Z0-9_-]*/), // -- This order matters
    identifier: ($) => /[a-zA-Z_][a-zA-Z0-9_]*/,   // -- Swapping will error

    type: $ => $.identifier,
    type_identifier: ($) => choice(
      /[a-zA-Z_][a-zA-Z0-9_]*/,
      "object", "atype", "tagtype",
      "true", "false", "none", "var", 
      "static", "capture", "as",
    ),

    coyield: ($) => "coyield",
    import_export: ($) => choice("import", "export"),
    comment: $ => token(seq('--', /.*/), /\n|\r\n|$/),
    exception_identifiers: ($) => choice("try", "catch", "recover"),
    repeat_identifiers: ($) => choice("do", "while", "for", "yield", "break", "continue"),
    builtin_function: ($) => token(choice("len", "map", "object", "print", "typeid", "indexChar")),

    string: ($) => prec(1, choice(
      seq('"', repeat(choice(/[^"{}\\]+/, /\\./, seq("{", optional($.expression), "}"))), '"'),
      seq("'", repeat(choice(/[^'{}\\]+/, /\\./, seq("{", optional($.expression), "}"))), "'")
    )),

    shebang: ($) => token.immediate(/#!.*\n+/),
    import_statement: ($) => prec(13, seq("import", $.identifier, $.string)),

    declaration: ($) =>
      prec.left(1, choice(
        $.object_declaration,
        $.field_declaration,
        $.var_declaration,
        $.function_definition,
        $.tagtype_declaration
      )),

    // --| Declarations ---------------
    // --|-----------------------------
    field_declaration: ($) => prec.left(11, seq(
      field("name", $.identifier), 
      optional(field("type", $.type_identifier))
    )),

    var_declaration: ($) => prec.left(12, seq(
      "var", $.identifier, optional($.type_identifier),
      optional(seq(":", $.expression))
    )),

    function_definition: ($) => prec(11, seq(
      "func", field("name", $.identifier), field("parameters", $.parameter_list), optional($.type_identifier), ":",
      field("body", $._block_group)
    )),
    
    parameter_list: ($) => seq(
      "(", commaSep1($.parameter), ")"
    ),

    parameter: ($) => seq(
      $.identifier,
      optional($.type_identifier)
    ),

    object_declaration: $ => prec.left(12, seq(
      "object", field("type", $.identifier), ":",
      optional(repeat(field("member", $.field_declaration))),
      optional($._object_body))
    ),

    _object_body: $ => prec.left(2, choice(
      seq(
        $._statement,
        repeat($._statement),
        repeat($.function_definition)
      ),
      seq(
        $.function_definition,
        repeat($._statement),
        repeat($.function_definition)
      )
    )),

    tagtype_declaration: $ => prec.left(1, 
      seq("tagtype", $.identifier, ":", optional($._tagtype_body))
    ),

    _tagtype_body: $ => seq(
      field("tag", $.identifier),
      repeat(seq(",", field("tag", $.identifier)))
    ),

    // --| Statements -----------------
    // --|-----------------------------
    assignment_statement: $ => seq(
      field('left', $._left_hand_side),
      choice(
        seq('=', field('right', $._right_hand_side)),
        seq(':', field('type', $.type)),
        seq(':', field('type', $.type), '=', field('right', $._right_hand_side))
      )
    ),

    // Expression statement
    expression_statement: ($) => prec.left(10, choice(
      seq(field("expression", $.expression)),
      // $.coyield,
    )),

    if_statement: ($) =>  prec.left(4, seq("if", 
      $._if_statement, 
      optional(field("else", $._else_statement)))
    ),

    _if_statement: ($) => prec.left(4,
      seq($.expression, ":",
      field("body", $._block_group)),
    ),  

    _else_statement: ($) => prec.left(4,
      seq("else", optional($.expression), ":",
      field("body", $._block_group)),
    ),

    match_statement: ($) => seq("match", field("subject", $.expression), ":",
      repeat(field("case", $.match_case))
    ),

    match_case: ($) => seq(
      "case", field("value", $.expression), ":",
      field("body", $._block_group)
    ),

    match_default: ($) => seq(
      "else", ":",
      field("body", $._block_group)
    ),

    // --| Iteration ------------------
    // --|-----------------------------
    loop_statement: ($) => prec(15, seq("loop", ":",
      field("body", $._block_group))
    ),

    while_loop: ($) => prec(1, seq(
      "while",
      field("condition", $.expression), ":",
      field("body", $._block_group))
    ),

    // --| For-Loops -----------
    for_range_loop: $ => prec.left(1, seq("for", $._for_range_loop)),
    for_iterable_loop: $ => prec.left(1, seq("for", $._for_iterable_loop)),
    for_optional_loop: $ => prec.left(1, seq("for", $._for_optional_loop)),

    _for_range_loop: $ => seq(
      field("start", $.expression),
      "..",
      optional("="),
      field("end", $.expression),
      optional(seq(",", field("step", $.expression))),
      "each",
      field("variable", $.identifier),
      field("body", $._block_group)
    ),

    _for_iterable_loop: $ => seq(
      field("iterable", $.expression),
      "each",
      field("variable", $.identifier),
      optional(seq(",", field("second_variable", $.identifier))),
      field("body", $._block_group)
    ),

    _for_optional_loop: $ => seq(
      field('iterator_expression', $.expression),
      'as',
      field('variable', $.identifier),
      ':',
      field('body', $._block_group)
    ),

    slice: $ => prec(PREC.slice, seq(
      field('object', $.expression), 
      '[',
        choice(
          seq(field('start', $.identifier), '..'),
          seq('..', field('end', $.identifier)), 
        ),
      ']'
    )),

    map_literal: $ => prec.left(1, $._map_literal),
    _map_literal: $ => seq("{", optional(seq($.key_value_pair, repeat(seq(",", $.key_value_pair)))), "}"),

    // --|----------------------------
    coyield_statement: ($) => prec(PREC.coyield, seq(
      field("coyield", $.coyield),
      $._newline,
    )),

    print_statement: ($) => prec.left(2, seq("print", $.expression)),
    
    return_statement: ($) => prec.left(2, choice(
      seq("return", optional($._expressions)),
    )),

    // --| Blocks ----------------
    _block_group: ($) =>
      choice(
        alias($._standard_statements, $.block),
        seq($._indent, $.block),
        alias($._newline, $.block),
    ),

    inline_block: ($) => seq(
      $._standard_statement, 
    ),

    block: ($) => seq(
      repeat($._statement),
      $._dedent
    ),

    // --| Expressions -----------
    _expressions: ($) => choice(
      $.expression,
      $.expression_list
    ),

    expression: ($) =>
      choice(
        $.comparison_operator,
        $.boolean_operator, 
        $.binary_operator, 
        $.identifier,
        $.number, 
        $.string, 
        $.object_initializer,
        $.function_call, 
        $.slice, 
        $.interpolated_string,
        $.object_accessor,
        prec(1, $.try_expression),
        prec(1, $.catch_expression),
        prec(1, $.panic_expression),
        prec(1, $.coinit_expression),
        prec(2, $.coresume_expression),
        prec(11, $.map_literal),
        prec(10, $.tag_expression),),

    boolean_operator: ($) =>
      choice(
        prec.left(PREC.and,
          seq(
            field("left", $.expression),
            field("operator", "and"),
            field("right", $.expression)
          )),
        prec.left(PREC.or,
          seq(
            field("left", $.expression),
            field("operator", "or"),
            field("right", $.expression)
          ))
      ),

    binary_operator: ($) => {
      const table = [
        [prec.left, "+", PREC.plus],
        [prec.left, "-", PREC.plus],
        [prec.left, "*", PREC.times],
        [prec.left, "@", PREC.times],
        [prec.left, "/", PREC.times],
        [prec.left, "%", PREC.times],
        [prec.left, "//", PREC.times],
        [prec.left, "|", PREC.bitwise_or],
        [prec.left, "&", PREC.bitwise_and],
        [prec.left, "^", PREC.xor],
        [prec.left, "<<", PREC.shift],
        [prec.left, ">>", PREC.shift],
      ];
      return choice(
        ...table.map(([fn, operator, precedence]) =>
          fn(
            precedence,
            seq(
              field("left", $.expression),
              field("operator", operator),
              field("right", $.expression)
            ))));
    },

    comparison_operator: ($) => prec.left(PREC.compare, seq(
      $.expression,
      repeat1(seq(
        field("operators", choice("<", "<=", "==", "!=", ">=", ">", "<>", "in", 
        seq("not", "in"), "is", seq("is", "not"))), $.expression)))
    ),

    augmented_assignment: ($) =>
      seq(
        field("left", $._left_hand_side),
        field("operator", choice("+=", "-=", "*=", "/=")),
        field("right", $._right_hand_side)
      ),

    _left_hand_side: ($) => choice($.pattern, $.pattern_list),
    _right_hand_side: ($) =>
      choice(
        $.expression,
        $.expression_list,
        $.assignment_statement,
        $.augmented_assignment
      ),

    pattern: ($) =>
      choice(
        $.identifier,
        $.keyword_identifier,
        $.index_expression,
        $.range_expressions,
        $.tag_expression,
        $.object_accessor
      ),

    pattern_list: ($) => prec.left(seq(
      $.pattern, choice(",", seq(repeat1(seq(",", $.pattern)), optional(",")))
    )),

    object_accessor: $ => prec.left(PREC.call,
      choice(
        seq(field("object", $.expression), '.', field("property", $.expression)),
      )
    ),

    object_initializer: $ => prec.left(PREC.call, seq(
      field("object", $.identifier),
      '{', optional(seq($.member_assignment, repeat(seq(",", $.member_assignment)))), '}'
    )),

    member_assignment: $ => prec.left(PREC.call, seq(
      field("member", $.identifier), ':', field("value", $.expression)
    )),

    function_call: ($) => prec.left(PREC.call,
      choice(seq(field("function", $.identifier), "(", optional( $.argument_list), ")"),)
    ),

    argument_list: ($) => seq(
      $.expression, repeat(seq(",", $.expression))
    ),

    keyword_argument: ($) => seq(
      field("name", choice(
        $.identifier,
        $.keyword_identifier,
        alias("match", $.identifier)
      )),
      "=", field("value", $.expression)
    ),

    try_expression: ($) => prec.left(1, seq(
      "try", $.expression)
    ),

    catch_expression: ($) => prec.left(1, seq(
      "catch", $.expression,
      optional(seq("then", $.expression)),
      optional(seq("as", $.identifier, "then", $.expression))
    )),

    range_expressions: ($) => choice(
      $.range_expression,
    ),

    range_expression: ($) => prec.left(1, seq(
      field("left", $.identifier),
      field("operator", ".."),
      field("right", $.identifier)
    )),

    panic_expression: ($) => prec.left(11, seq("panic", $.expression)),
    index_expression: ($) => prec.left(1, seq($.expression, "[", $.expression, "]")),
    parenthesized_expression: ($) => prec.left(10, seq("(", $.expression, ")")),

    key_value_pair: ($) => seq(
      field("key", $.expression), ":", field("value", $.expression)
    ),

    tag_expression: ($) => seq(
      "#", field("tag", $.identifier)
    ),

    expression_list: ($) => prec.left(11, seq(
      $.expression, repeat(seq(",", $.expression))
    )),

    coinit_expression: ($) => prec(PREC.call, seq(
      "coinit", '(', optional($.argument_list), ')'
    )),

    coresume_expression: $ => prec(PREC.call - 1, seq(
      'coresume', field('operand', $.expression)
    )),

    recover_block: ($) => prec(PREC.recover_block,
      seq("recover", $.identifier, ":", $._block_group)
    ),

    interpolated_string: ($) => prec.left(11, seq(
      '"', repeat(choice(/[^"{]+/, $.interpolation)), '"')
    ),

    interpolation: ($) => prec.left(12, seq("{", $.expression, "}")),

    keyword_identifier: ($) => prec(-3, alias(
      choice(
        "print", "async", "await", "coinit", "coyield", "coresume",
        "recover", "panic", "try", "catch", "then", "as", "match",
        "in", "is", "not", "true", "false", "none", "atype", "typeid",
        "str", "any", "insert", "remove", "indexChar"
      ),
      $.identifier)
    ),
  },
});

function commaSep1(rule) {
  return sep1(rule, ",");
}

function sep1(rule, separator) {
  return seq(rule, repeat(seq(separator, rule)));
}
