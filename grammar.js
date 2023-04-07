const { key_val_arg, commaSep1, sep1, command, keyword } = require("./rules/utils");

const PREC = {
  INDENT:        1, 
  DEDENT:        1, 
  slice:        -3,
  lambda:       -2,
  type_param:   -1,
  conditional:  -1,
  paren:         1, 
  or:            10,
  and:           11, 
  not:           12, 
  compare:       13, 
  bitwise_or:    14, 
  bitwise_and:   15,
  xor:           16,
  shift:         17, 
  plus:          18, 
  times:         19, 
  unary:         20, 
  power:         21,
  kvp:           21,
  case:          21,
  call:          22, 
  function:      23,
  recover_block: 24, 
  coyield:       25, 
  tag:           25,
  match:         26,
  block:         26,
};

const KPREC = { type: 0, var: 1, func: 2, builtin: 3, repeat: 4, ident: 5, }

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
    [$.string, $.string_interpolation],
    [$.match_case]
  ],

  rules: {
    source_file: ($) => seq(optional($.shebang), repeat($._statement)),

    // @ts-ignore
    keyword: (_$) => /[a-zA-Z_](\w|#)*/,
    type: ($) => $.identifier,
    _whitespace: (_$) => /(\s|\\\r?\n)+/,
    _spacetoken: (_$) => token(optional(/[ \r\t]+/)),

    _newline: ($) => prec(1, $._NEWLINE),
    _indent: ($) => prec(PREC.INDENT,$._INDENT),
    _dedent: ($) => prec(PREC.DEDENT, $._DEDENT),

    number: (_$) => /\d+(\.\d+)?/,
    name: (_$) => token(/[a-zA-Z_][a-zA-Z0-9_-]*/), // -- This order matters
    identifier: ($) => prec(2,                    // -- Swapping will error
     choice(
        $.var_identifier,
        $.type_identifier, 
        $.import_export,
        $.builtin_type,
        $.exception_identifiers,
        $.repeat_identifiers,
        $.builtin_function,
        prec(KPREC.ident, /[a-z_][a-zA-Z0-9_-]*/)
    )),

    var_identifier: (_$) => prec(KPREC.var, choice(/[a-z]/, /[a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9]/)),
    type_identifier: (_$) => prec(KPREC.type, choice(/[a-zA-Z]/,/[a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9]/)),
    builtin_type: (_$) => prec(KPREC.builtin, choice(
      "int", "float", "string", "bool", "none", "any", "void", "static", "capture", 
      "object", "atype", "tagtype", "true", "false", "none", "static", "capture", "as", "number", "pointer"
    )),

    import_export: (_$) => choice("import", "export"),
    comment: (_$) => token(seq("--", /.*/), /\n|\r\n|$/),
    exception_identifiers: (_$) => choice("try", "catch", "recover"),
    repeat_identifiers: (_$) => choice("do", "while", "for", "yield", "break", "continue"),
    builtin_function: (_$) => token(choice("len", "map", "print", "typeid", "indexChar")),

    escape_sequence: (_$) => token(seq('\\', token.immediate(
      choice(
        /[uU][0-9a-fA-F]{1,6}/, 
        /x[0-9a-fA-F]{2}/,
        /["'`$\\abfnrtv]/,
        /[0-7]{1,3}/,
    )))),

    codepoint: (_$) => prec(1, token.immediate(
      choice(
        seq(/[\u0000-\u007F]/,/[\u0000-\u007F]/),
        /x[0-9a-fA-F]{2}/,
        choice('\\', /[uU][0-9a-fA-F]{1,6}/),
    ))),

    encoded_string: ($) => prec(1, seq($.codepoint, $.string)),

    string: ($) => prec(1, choice(
      seq('"', repeat(choice(/[^"{}\\]+/, /\\./,
        prec(2, repeat1($.string_interpolation)), '{', '}'
      )), '"'),
      seq("'", repeat(choice(/[^'{}\\]+/, /\\./, prec(2, repeat1($.string_interpolation)), '{', '}')), "'")
    )),

    string_interpolation: ($) => seq("{", $._expression, "}"),

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
        $._expression_statement,
        $.coyield_statement,
        $.assignment,
        $.print_statement,
        $.return_statement
      ),

    _complex_statement: ($) =>
      choice(
        $.if_statement,
        $.match_statement,
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
        $.object_definition,
        $.var_declaration,
        $.function_definition,
        $.tagtype_declaration
      )),

    // --| Declarations ---------------
    // --|-----------------------------
    shebang: (_$) => token.immediate(/#!.*\n+/),
    import_statement: ($) => prec(13, seq("import", $.identifier, $.string)),

    local_declaration: ($) => prec.left(1, seq(
      field("name", $.identifier),
      choice(
        seq("=",
          choice(
            $._expression,
            $._statement
        )),
        field("type", $.identifier)
      ),
    )),

    // Static variable declaration
    var_declaration: ($) => prec.left(12, seq(
      "var", $.identifier,
      seq(":", 
        choice(
            $._expression,
            $._statement
        )))
    ),

    anonymous_function: ($) => seq($.func, $.parameter_list),
    anonymous_definition: ($) => prec.left(PREC.function, seq(
      $.anonymous_function,
      optional($._block_group)
    )),

    // Static function declaration

    function_definition: ($) => prec(11, seq(
      alias("func", $.func),
      choice($.function_declaration, $.method_declaration),
      optional(field("return_type", $.identifier)),
      choice(
        field("body", $._block_group),
        $._standard_statements
      )
    )),

    function_declaration: ($) => prec.left(12, seq(
      field("name", $.identifier),
      field("parameters", $.parameter_list),
    )),

    method_declaration: ($) => prec.left(12, seq(
      field("name", $.identifier),
      field("parameters", $.method_parameter_list),
    )),

    parameter_list: ($) => seq(
      "(",
        choice(
          optional($.parameter),
          optional(commaSep1($, $.parameter)), 
        ),
      ")"
    ),

    method_parameter_list: ($) => seq(
      "(",
      $.self, optional(","), 
      optional(commaSep1($, $.parameter)), 
      ")"
    ),

    parameter: ($) => seq(field("name", $.identifier), optional($.type_identifier)),
    
    // --| Object Definitions ---------
    // --|-----------------------------
    object_definition: ($) => prec.left(12, seq(
      repeat1($.object_declaration),
      optional(field("body", $.object_block)),
    )),

    object_declaration: ($) => seq(
      "type",
      field("type_name", $.type_identifier),
      field("type_of", $.type_identifier),
    ),

    object_member: ($) => prec.right(PREC.call,seq(
      field("member", $.identifier), optional(field("type", $.identifier)),
      $._newline
    )),

    object_block: ($) => prec.right(seq(
      $._scope_start,
      $._indent,
      repeat($.object_member),
      repeat($._statement),
      $._dedent,
    )),


    // --| Tag Types ------------------
    // --|-----------------------------
    tagtype_declaration: ($) => prec.left(PREC.tag, seq(
      "tagtype", $.identifier, 
      optional($._tagtype_body)
    )),

    _tagtype_body: ($) => prec.right(seq(
      field("tag", $.identifier),
      repeat(seq(",", field("tag", $.identifier)))
    )),

    // --| Statements -----------------
    // --|-----------------------------
    // Expression statement
    _expression_statement: ($) => prec.left(PREC.call, seq(
      field("expression", $._expression))
    ),

    // --| If/Else --------------------
    // --|-----------------------------
    if_statement: ($) => prec.left(4, seq(
      "if", $._if_statement,
      repeat(field("else", $._else_statement))
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
      "match", field("subject", $._expression),
      field("body", $.match_block),
    ),

    match_block: ($) => prec.right(seq(
      $._scope_start,
      $._indent,
      repeat1($.match_case),
      $._dedent,
    )),

    match_case: ($) => prec.left(PREC.match, seq(
      choice(
        field("pattern", $._expression),
        seq(
          field("pattern", $._expression),
          repeat1(seq(',', field("pattern", $._expression)))
        ),
        "else"
      ),
      ":",
      choice(
       field("value", $._standard_statement),
       field("value", $._expression),
    ))),

    match_default: ($) => seq(
      "else", field("body", $._block_group)
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
        $.index_expression,
        $.object_initializer,
        // $.match_case,
        $.slice,
        $.anonymous_definition,
        $.cfunc_call,
        $.cstruct_call,
        $.find_rune,
        $.field_expression,
        prec(11, $.try_expression),
        prec(11, $.catch_expression),
        prec(11, $.panic_expression),
        prec(11, $.coinit_expression),
        prec(11, $.coresume_expression),
        prec(11, $.array_literal),
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
      repeat1(seq(field("operators", choice(
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
      $.pattern, commaSep1($, $.pattern))
    ),

    expression_list: ($) => prec.left(11, seq(
      sep1($, $._expression, ",")
    )),

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
      field("name", $.identifier), "(", optional(commaSep1($, $._expression)), ")"
    )),

    call_expression: ($) => prec.left(PREC.call +5 ,
      choice(
        seq(field("name", $.identifier), 
          "(",
          choice(
            optional($._expression),
            optional(commaSep1($, $._expression)), 
          ),
          ")",
        ),
        seq( field("name",$._expression), 
          "(", 
          choice(
            optional($._expression),
            optional(commaSep1($, $._expression)), 
          ),
          ")"
    ))),

    // --| Object ---------------------
    // --|-----------------------------
    object_initializer: ($) => prec.left(PREC.call - 1, seq(
      field("type_name", $.type_identifier),
      "{", 
        choice(
          optional($.member_assignment),
          optional(sep1($, $.member_assignment, optional(","))), 
        ),
      optional(","),
      "}"
    )),

    member_assignment: ($) => prec.left(PREC.call,
      seq(
        field("member", $.identifier), ":", field("value", $._expression),
        optional(","),
        optional($._newline)
      )
    ),

    argument_list: ($) => commaSep1($, $._expression),
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

    // --| FFI ------------------------
    // --|-----------------------------
    // --| CFunc ----------------------
    cfunc_call: ($) => prec.left(PREC.call, seq(
      "CFunc", "{", $.symbol_parameter, $.args_parameter, $.ret_parameter, "}")
    ),

    symbol_parameter: ($) => prec.left(PREC.call, seq(
      "sym", ":" , field("symbol", $.string), ",",
    )),
    
    args_parameter: ($) => prec.left(PREC.call, seq(
      "args", ":" , field("arguments", $.array_literal), ",",
    )),

    ret_parameter: ($) => prec.left(PREC.call, seq(
        "ret", ":" , field("type_mapping", choice($.identifier, $.tag_expression)),
    )),

    // --| CStruct --------------------
    cstruct_call: ($) => prec.left(PREC.call, seq(
      "CStruct", "{", $.fields_parameter, $.object_parameter, "}")
    ),

    fields_parameter: ($) => prec.left(PREC.call, seq(
      "fields", ":" , field("arguments", $.array_literal), ",",
    )),

    object_parameter: ($) => prec.left(PREC.call, seq(
      "type", ":" , field("object_mapping", $.identifier)
    )),

    // --| findRune -------------------
    find_rune: ($) => prec.left(PREC.call, seq(
      "findRune", "(", optional($.codepoint), $.string, ")")
    ),

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
      seq("(", optional(commaSep1($, $._expression)), ")"),
    ),

    coresume_expression: ($) => seq(field("coresume", $.coresume), field("operand", $._expression)),

    // --| Array/Map ------------------
    // --|-----------------------------
    range_identifier: (_$) => "..",
    range_expressions: ($) => choice($.range_expression),

    range_expression: ($) => prec.left(1, seq(
      field("left", $.identifier),
      field("operator", $.range_identifier),
      field("right", $.identifier)
    )),

    index_expression: ($) => prec.left(1, seq(
      $._expression, 
      choice(
        $.slice,
        $.array_literal
    ))),

    key_value_pair: ($) => prec(PREC.kvp, seq(
      field("key", $._expression), ":", field("value", $._expression)
    )),

    slice: ($) => prec(PREC.slice, seq(
      "[",  
      choice(
        seq(field("start", $._expression), "..", field("end", $._expression)),
        seq(field("start", $._expression), ".."),
        seq("..", field("end", $._expression))
      ),
      "]"
    )),

    map_literal: ($) => seq( 
      "{",
          choice(
            optional(prec.left(seq(commaSep1($, $.key_value_pair, true)))),
            optional(prec.left(repeat1(prec.left(seq($.key_value_pair, optional(','), optional($._newline)))))),
          ), 
      "}"
    ),

    array_literal: ($) => seq(
      "[",
        choice(
          optional(prec.left(seq(commaSep1($, $._expression, true), optional(',')))),
          optional(prec.left(repeat1(prec.left(seq($._expression, optional(','), optional($._newline)))))),
        ),
      "]"
    ),

    // --| Keywords/Indicators --------
    // --|-----------------------------
    _statement_indicator: (_$) => token.immediate(":"),

    true:  (_$) => "true",
    false: (_$) => "false",
    none:  (_$) => "none",
    self:  (_$) => "self",
    type:  (_$) => "type",
    func:  (_$) => token("func"),

    ident: (_$) => /[a-zA-Z\x80-\xff](_?[a-zA-Z0-9\x80-\xff])*/,

    boolean: (_$) => choice("true", "false", "none"),

    coinit:   (_$) => "coinit",
    coresume: (_$) => "coresume",
    coyield:  (_$) => "coyield",

    keyword_identifier: ($) => prec(-3, alias(choice(
      // Async ---------
      "async",
      "await",
      "coinit",
      "coyield", 
      "coresume", 
      // Exception -----
      "recover", 
      "panic", 
      "try", 
      "catch", 
      // Control -------
      "if",
      "then", 
      // Type ----------
      "as", 
      "none", 
      "atype", 
      "any", 
      "str", 
      "typeid", 
      "type",
      "object",
      // Compare -------
      "match",
      "in", 
      "is", 
      "not", 
      "true", 
      "false", 
      // Function ------
      "print",
      "insert", 
      "remove", 
      "indexChar"
    ), $.identifier)
    ),
  },
});

