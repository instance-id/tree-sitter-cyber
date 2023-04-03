const { key_val_arg, commaSep1, sep1, command, keyword } = require("./rules/utils");

const PREC = {
  INDENT: 1, DEDENT: 1, slice: -3, lambda: -2, typed_parameter: -1, conditional: -1, parenthesized_expression: 1,
  or: 10, 
  and: 11, 
  not: 12, 
  compare: 13,
  bitwise_or: 14, 
  bitwise_and: 15, 
  xor: 16, 
  shift: 17, 
  plus: 18, 
  times: 19, 
  unary: 20, power: 21, call: 22, recover_block: 23, coyield: 24, block: 25,
};

const KPREC = {
  type: 0,
  var: 1,
  func: 2,
  builtin: 3,
  repeat: 4,
  ident: 5,
}

module.exports = grammar({
  name: "cyber",

  extras: ($) => [/\s/, /[\t ]/, $.comment],
  word: ($) => $.keyword,

  inline: ($) => [$._statement, $._indent, $._dedent, $._newline, $.keyword_identifier],
  externals: ($) => [
    $._scope_start,
    $._func_scope_start,
    $._inline_statement,
    $._end_of_statement,
    $._INDENT,
    $._DEDENT,
    $._NEWLINE, 
    $._line
  ],
  conflicts: ($) => [
    [$._expression, $.pattern], 
    [$.block, $.inline_block],
    [$.accessor, $.field_expression, $.try_expression],
    [$.accessor, $.field_expression, $.catch_expression],
    [$.accessor, $.field_expression, $.panic_expression]
  ],

  rules: {
    source_file: ($) => seq(optional($.shebang), repeat($._statement)),

    // @ts-ignore
    keyword: ($) => /[a-zA-Z_](\w|#)*/,
    type: ($) => $.identifier,
    _whitespace: ($) => /(\s|\\\r?\n)+/,
    _spacetoken: ($) => token(optional(/[ \r\t]+/)),

    _newline: ($) => prec(1, $._NEWLINE),
    _indent: ($) => prec(PREC.INDENT,$._INDENT),
    _dedent: ($) => prec(PREC.DEDENT, $._DEDENT),

    number: ($) => /\d+(\.\d+)?/,
    name: ($) => token(/[a-zA-Z_][a-zA-Z0-9_-]*/), // -- This order matters
    identifier: ($) => prec(2,                    // -- Swapping will error
     choice(
        $.var_ident,
        $.type_ident, 
        $.builtin_type, 
        $.import_export,
        $.exception_identifiers,
        $.repeat_identifiers,
        $.builtin_function,
        prec(KPREC.ident, /[a-z_][a-zA-Z0-9_-]*/)
    )),

    var_ident: $ => prec(KPREC.var, choice(/[a-z]/, /[a-z][a-z0-9_]*[a-z0-9]/)),
    type_ident: $ => prec(KPREC.type, choice(/[A-Z][a-z0-9_]*[a-z0-9]/)),
    builtin_type: ($) => prec(KPREC.builtin, choice(
      "int", "float", "string", "bool", "none", "any", "void", "static", "capture", 
      "object", "atype", "tagtype", "true", "false", "none", "static", "capture", "as"
    )),

    import_export: ($) => choice("import", "export"),
    comment: ($) => token(seq("--", /.*/), /\n|\r\n|$/),
    exception_identifiers: ($) => choice("try", "catch", "recover"),
    repeat_identifiers: ($) => choice("do", "while", "for", "yield", "break", "continue"),
    builtin_function: ($) => token(choice("len", "map", "print", "typeid", "indexChar")),

    string: ($) => prec(1, choice(
      seq('"', repeat(choice(/[^"{}\\]+/, /\\./, seq("{", optional($._expression), "}"))), '"'),
      seq("'", repeat(choice(/[^'{}\\]+/, /\\./, seq("{", optional($._expression), "}"))), "'")
    )),

    // --| Statements ------------------
    _statement: ($) => choice(
      $._standard_statements,
      $._complex_statement,
    ),

    _standard_statements: ($) => prec.left(
      seq(
        $._standard_statement,
        $._newline,
      )),

    _standard_statement: ($) =>
      choice(
        $.import_statement,
        $._declaration,
        $.expression_statement,
        $.coyield_statement,
        $.assignment,
        $.print_statement,
        $.return_statement
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

    _declaration: ($) => prec.left(1,
      choice(
        $.local_declaration,
        $.object_declaration,
        $.var_declaration,
        $.function_definition,
        $.tagtype_declaration
      )),

    // --| Declarations ---------------
    // --|-----------------------------
    shebang: ($) => token.immediate(/#!.*\n+/),
    import_statement: ($) => prec(13, seq("import", $.identifier, $.string)),

    local_declaration: ($) => prec.left(1, seq(
      field("name", $.identifier),
      choice(
        seq("=", $._expression),
        field("type", $.identifier)
      ),
    )),

    // Static variable declaration
    var_declaration: ($) => prec.left(12, seq(
      "var", $.identifier,
      seq(":", $._expression))
    ),

    // Static function declaration
    function_definition: ($) => prec(11, seq(
      "func",
      $.function_declaration,
      optional(field("return_type", $.identifier)),
      field("body", $._block_group)
    )),

    function_declaration: ($) => prec.left(12, seq(
      field("name", $.identifier),
      field("parameters", $.parameter_list),
    )),

    parameter_list: ($) => seq("(", optional(commaSep1($.parameter)), ")"),
    parameter: ($) => seq(field("name", $.identifier), optional($.builtin_type)),

    object_declaration: ($) => prec.left(12, seq(
      "type",
      field("type", $.type_ident),
      "object",
      optional(field("body", $._block_group)),
    )),

    object_member: ($) => prec.right(PREC.call,seq(
      field("member", $.identifier), field("type", $.identifier),
      $._newline
    )),

    tagtype_declaration: ($) => prec.left(1, seq(
      "tagtype", $.identifier, 
      optional($._tagtype_body)
    )),

    _tagtype_body: ($) => seq(
      field("tag", $.identifier),
      repeat(seq(",", field("tag", $.identifier)))
    ),

    // --| Statements -----------------
    // --|-----------------------------
    // Expression statement
    expression_statement: ($) => prec.left(PREC.call, seq(
      field("expression", $._expression))
    ),

    // --| If/Else --------------------
    // --|-----------------------------
    if_statement: ($) => prec.left(4, seq(
      "if", $._if_statement,
      optional(field("else", $._else_statement))
    )),

    _if_statement: ($) => prec.left(4,
      seq(
        seq(field("condition", $._expression)),
        field("body", $._block_group)
      )),

    _if_statement_inline: ($) => prec.left(4,
      seq(
        field("condition", $._expression),
        field("inline_body", $._standard_statement)
    )),

    _else_statement: ($) => prec.left(4,
      seq(
        "else", optional($._expression),
        field("body", $._block_group)
    )),

    // --| Match Statements -----------
    // --|-----------------------------
    match_statement: ($) => seq(
      "match",
      field("subject", $._expression),
      repeat(field("case", $.match_case))
    ),

    match_case: ($) => seq(
      "case",
      field("value", $._expression),
      field("body", $._block_group)
    ),

    match_default: ($) => seq(
      "else",
      field("body", $._block_group)
    ),

    // --| Iteration ------------------
    // --|-----------------------------
    loop_statement: ($) => prec(15, seq(
      "loop", 
      field("body", $._block_group)
    )),

    while_loop: ($) => prec(1, seq(
      "while",
      field("condition", $._expression),
      field("body", $._block_group)
    )),

    // --| For-Loops -------------
    // --|------------------------
    for_range_loop: ($) => prec.left(1, seq("for", $._for_range_loop)),
    for_iterable_loop: ($) => prec.left(1, seq("for", $._for_iterable_loop)),
    for_optional_loop: ($) => prec.left(1, seq("for", $._for_optional_loop)),

    _for_range_loop: ($) => seq(
      field("start", $._expression),
      "..",
      optional("="),
      field("end", $._expression),
      optional(seq(",", field("step", $._expression))),
      "each",
      field("variable", $.identifier),
      field("body", $._block_group)
    ),

    _for_iterable_loop: ($) => seq(
      field("iterable", $._expression),
      "each",
      field("variable", $.identifier),
      optional(seq(",", field("second_variable", $.identifier))),
      field("body", $._block_group)
    ),

    _for_optional_loop: ($) => seq(
      field("iterator_expression", $._expression),
      "as",
      field("variable", $.identifier),
      field("body", $._block_group)
    ),

    // --| Other Statements ------
    // --|------------------------
    coyield_statement: ($) => prec(PREC.coyield, seq(field("coyield", $.coyield), $._newline)),
    print_statement: ($) => prec.left(2, seq("print", $._expression)),
    return_statement: ($) => prec.left(2, seq("return", optional($._expressions), $._newline)),

    // --| Blocks ----------------
    // --|------------------------
    _block_group: ($) => prec.left(PREC.block, 
      choice(
        $.inline_block,
        $.block,
      )),

    inline_block: ($) => prec.left(PREC.block + 1, seq(
      $._inline_statement,
      $._standard_statement,
      $._newline,
    )),

    block: ($) => prec.right(seq(
      $._scope_start,
      $._indent,
      repeat1($._statement),
      $._dedent,
    )),

    recover_block: ($) => prec(PREC.recover_block,
      seq(
        "recover", 
        $.identifier, 
        $._block_group
    )),

    // --| Expressions -----------
    // --|------------------------
    _expressions: ($) => choice(
      $._expression,
      $.expression_list, 
    ),

    _expression: ($) =>
      choice(
        $.identifier,
        $.number,
        $.string,
        $.boolean,
        $.binary_operator,
        $.boolean_operator,
        $.comparison_operator,
        $.object_initializer,
        $.slice,
        $.interpolated_string,
        $.field_expression,
        prec(11, $.try_expression),
        prec(11, $.catch_expression),
        prec(11, $.panic_expression),
        prec(11, $.coinit_expression),
        prec(11, $.coresume_expression),
        prec(11, $.map_literal),
        prec(12, $.tag_expression),
        prec(PREC.call +5, $.call_expression),
      ),

    // --| Operators ------------------
    // --|-----------------------------
    boolean_operator: ($) => choice(
     prec.left(PREC.and, seq(
      field("left", $._expression),
      field("operator", "and"),
      field("right", $._expression)
    )),
      prec.left(PREC.or, seq(
        field("left", $._expression),
        field("operator", "or"),
        field("right", $._expression)
      ))),

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
          fn(precedence,
            seq(
              field("left", $._expression),
              field("operator", operator),
              field("right", $._expression)
            ))));
    },

    comparison_operator: ($) => prec.left(PREC.compare, seq(
      field("left",$._expression),
      repeat1(seq( field("operators", choice(
        "<", "<=", "==", "!=", ">=", ">", "<>", "in",
        seq("not", "in"), "is", seq("is", "not"))), 
      field("right", $._expression),
    )))),

    // --| Assignment -----------------
    // --|-----------------------------
    assignment: ($) =>
      seq(
        field("left", $._left_hand_side),
        field("operator", choice("=", "+=", "-=", "*=", "/=")),
        field("right", $._right_hand_side)
      ),

    _left_hand_side: ($) => choice($.pattern),

    _right_hand_side: ($) => choice(
      $._expression,
      $.expression_list,
      $.assignment
    ),

    pattern: ($) =>
      choice(
        $.identifier,
        $.keyword_identifier,
        $.index_expression,
        $.range_expressions,
        $.tag_expression,
        $.call_expression,
        $.field_expression,
      ),

    pattern_list: ($) => prec.left(5, seq(
      $.pattern, commaSep1($.pattern))
    ),

    expression_list: ($) => prec.left(11, seq(
      $._expression, repeat1(seq(",", $._expression)))
    ),

    // --| Field/Accessor -------------
    // --|-----------------------------
    accessor: ($) => prec(PREC.call, repeat1(seq(
      field("value", $._expression), ".",
    ))),   

    field_expression: ($) => prec(PREC.call,
      seq(
        field("object", $._expression), ".",
        choice(
          prec(PREC.call - 1, $.accessor),
          prec(PREC.call, $._expression),
        )
      )),

    // --| Functions ------------------
    // --|-----------------------------
    call_identifier: ($) => prec.left(PREC.call - 2, seq(
      field("name", $.identifier), "(", optional(commaSep1($._expression)), ")"
    )),

    call_expression: ($) => prec.left(PREC.call +5 , seq(
      $._expression, "(", optional(commaSep1($._expression)), ")"
    )),

    // --| Object ---------------------
    // --|-----------------------------
    object_initializer: ($) => prec.left(PREC.call - 1, seq(
      field("object", $.type_ident), "{", optional(sep1($.member_assignment, ",")), "}"
    )),

    member_assignment: ($) => prec.left(PREC.call,
      seq(field("member", $.identifier), ":", field("value", $._expression))
    ),

    argument_list: ($) => commaSep1($._expression),
    parenthesized_expression: ($) => prec.left(10, seq("(", $._expression, ")")),

    // --| Exception ------------------
    // --|-----------------------------
    try_expression: ($) => prec.left(PREC.call - 10, seq("try", $._expression)),

    catch_expression: ($) => prec.left(1, seq(
      "catch",
      $._expression,
      optional(seq("then", $._expression)),
      optional(seq("as", $.identifier, "then", $._expression))
    )),

    panic_expression: ($) => prec.left(11, seq("panic", $._expression)),

    // --| Tags -----------------------
    // --|-----------------------------
    tag_expression: ($) => seq("#", field("tag", $.identifier)),

    // --| Concurrency ----------------
    // --|-----------------------------
    coinit_expression: ($) => seq(
      field("coinit", $.coinit),
      $.coinit_declaration   
    ),

    coinit_declaration: ($) => seq(
      field("coinit_function", $.identifier),
      optional(seq(".", repeat(seq($.identifier,".")))),
      seq("(", optional(commaSep1($._expression)), ")"),
    ),

    coresume_expression: ($) => seq(field("coresume", $.coresume), field("operand", $._expression)),

    // --| Array/Map ------------------
    // --|-----------------------------
    range_identifier: ($) => "..",
    range_expressions: ($) => choice($.range_expression),

    range_expression: ($) => prec.left(1, seq(
      field("left", $.identifier),
      field("operator", $.range_identifier),
      field("right", $.identifier)
    )),

    index_expression: ($) => prec.left(1, seq($._expression, "[", $._expression, "]")),

    key_value_pair: ($) => seq(field("key", $._expression), ":", field("value", $._expression)),

    slice: ($) => prec(PREC.slice, seq(
      field("object", $._expression),
      "[",
      choice(
        seq(field("start", $.identifier), ".."),
        seq("..", field("end", $.identifier))
      ),
      "]"
    )),

    map_literal: ($) => seq( 
      "{", optional(seq($.key_value_pair, repeat(seq(",", $.key_value_pair)))), "}"
    ),

    interpolated_string: ($) => prec.left(11, seq('"', repeat(choice(/[^"{]+/, $.interpolation)), '"')),
    interpolation: ($) => prec.left(12, seq("{", $._expression, "}")),

    // --| Keywords/Indicators --------
    // --|-----------------------------
    _statement_indicator: ($) => token.immediate(":"),

    true: ($) => "true",
    false: ($) => "false",
    none: ($) => "none",
    ident: ($) => /[a-zA-Z\x80-\xff](_?[a-zA-Z0-9\x80-\xff])*/,

    boolean: ($) => choice("true", "false", "none"),

    coinit: ($) => "coinit",
    coresume: ($) => "coresume",
    coyield: ($) => "coyield",

    keyword_identifier: ($) => prec(-3, alias(choice(
      "print", "async", "await", "coinit", "coyield", "coresume", "recover", "panic", "try", "catch", "then", "as", "match",
      "in", "is", "not", "true", "false", "none", "atype", "typeid", "str", "any", "insert", "remove", "indexChar"), $.identifier)
    ),
  },
});

