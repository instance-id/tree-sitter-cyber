const {parenthesized, list_of, commaSep1, sep1 } = require("./rules/utils");

const PREC = {
  type_param   : -1,
  conditional  : -1,
  numeric      : -1,
  parenExpr    : 50,
  INDENT       : 1,
  DEDENT       : 1,
  paren        : 1,
  id           : 2,
  or           : 10,
  and          : 11,
  not          : 12,
  bitwise_or   : 14,
  bitwise_xor  : 14,
  bitwise_not  : 15,
  bitwise_and  : 15,
  xor          : 16,
  shift        : 17,
  plus         : 18,
  times        : 19,
  unary        : 20,
  power        : 21,
  kvp          : 21,
  case         : 21,
  recover_block: 24,
  coyield      : 25,
  match        : 26,
  block        : 26,
  slice        : 30,
  string       : 33,
  eStr         : 33,
  mStr         : 34,
  bool         : 34,
  negation     : 45,
  compare      : 36,
  comparison   : 36,
  param        : 38,
  augmented    : 38,
  paramList    : 39,
  for          : 39,
  if           : 39,
  anonymous    : 40,
  capture      : 40,
  static       : 40,
  cfunc        : 41,
  cstruct      : 42,
  find_rune    : 43,
  field        : 44,
  call         : 45,
  type_cast    : 45,
  closure      : 45,
  lambda       : 46,
  error        : 45,
  throw        : 45,
  coinit       : 45,
  coresume     : 45,
  enclosed     : 45,
  try          : 46,
  else         : 46,
  catch        : 46,
  panic        : 46,
  try_else     : 47,
  index        : 47,
  boolean      : 48,
  binary       : 60,
  object       : 60,
  loDef        : 61,
  varDef       : 62,
  function     : 63,
  fnDef        : 64,
  tag          : 66,
  iStr         : 56,
};

const KPREC = { type: 0, var: 1, func: 2, builtin: 3, repeat: 4, ident: 20, }
const operators = [
  [prec.left, "+", PREC.plus],
  [prec.left, "-", PREC.plus],
  [prec.left, "*", PREC.times],
  [prec.left, "@", PREC.times],
  [prec.left, "/", PREC.times],
  [prec.left, "%", PREC.times],
  [prec.left, "//", PREC.times],
  [prec.left, "|", PREC.bitwise_or],
  [prec.left, "||", PREC.bitwise_xor],
  [prec.left, "~", PREC.bitwise_not],
  [prec.left, "&", PREC.bitwise_and],
  [prec.left, "^", PREC.xor],
  [prec.left, "<<", PREC.shift],
  [prec.left, ">>", PREC.shift],
];

function identifier($, rule, alphaOnly = false) {
  if (alphaOnly) return choice();

}

module.exports = grammar({
  name: "cyber",

  extras: ($) => [/\s/, /[\t ]/, $.shebang, $.comment],
  word: ($) => $.keyword,

  inline: ($) => [$._statement, $._indent, $._dedent, $._newline, $.keyword_identifier],
  externals: ($) => [
    $._scope_start,
    $._func_scope_start,
    $._object_scope_start,
    $._object_declaration,
    $.type_field,
    $._type_alias,
    $._inline_statement,
    $._end_of_statement,
    $._INDENT,
    $._DEDENT,
    $._NEWLINE, 
    $.comment,
    $._scope_end,
    $._string_start,
    $._string_content,
    $._string_end,
    $._triple_quote_start,
    $._triple_quote_end,
    ")", "]", "}",":",
    $._error_sentinel,
  ],

  conflicts: ($) => [
    [$.block, $.inline_block],
    [$.match_case], [$.binary_operator],
    [$.binary_operator, $.negation_operator],
    [$._expression, $.arithmetic_expression],
    [$.arithmetic_expression],
    [$.arithmetic_expression, $.binary_operator],
    [$.closure_expression],[$.coinit_declaration]
  ],

  rules: {
    source_file: ($) => seq(
      optional($.shebang),
      repeat($._statement),
    ),

      // @ts-ignore
    keyword: (_$) => /[a-zA-Z_](\w|#)*/,
    _whitespace: (_$) => /[ \t]+/,

    _newline: ($) => prec(1, $._NEWLINE),
    _indent: ($) => prec(PREC.INDENT,$._INDENT),
    _dedent: ($) => prec(PREC.DEDENT, $._DEDENT),

    codepoint: ($) => prec(60, 
      choice(
        $.numeric_literal,
        seq(/[\u0000-\u007F]/,/[\u0000-\u007F]/),
        /x[0-9a-fA-F]{2}/,
        choice('\\', /[uU][0-9a-fA-F]{1,6}/),
      )),

    numeric_literal: (_$) => {
      const separator = "'";
      const hex = /[0-9a-fA-F]{2,8}/;
      const decimal = /[0-9]/;
      const octal_digit = /[0-7]/;
      const octal = seq(optional(decimal), choice('o', 'O'), optional(/[+-]/), repeat1(octal_digit));

      const hexDigits = seq(repeat1(hex), repeat(seq(separator, repeat1(hex))));
      const decimalDigits = seq(repeat1(decimal), repeat(seq(separator, repeat1(decimal))));

      return prec(PREC.numeric, token(
        choice(
          prec.left(3, octal),
          prec.left(2, seq(
            optional(/[~]/), 
            optional(/[+-]/), 
            choice(
              seq(/[0-9][0-9_]*(\.[0-9_]+)?([eE][+-]?[0-9_]+)?/, optional(/[uUfF]/)),
              seq((choice('0x', '0b')), hexDigits)
            ), 
          )),

          prec.left(1, seq(
            optional(/[~]/), 
            optional(/[+-]/), 
            prec(4 ,optional(choice('0x', '0b'))), 
            choice(
              seq(/[0-9]+#[0-9a-fA-F._-]+#([eE][+-]?[0-9_]+)?/, optional(/[uUfF]/)),
              decimalDigits 
            ))),
        )))
    },

    name: (_$) => token(/[a-zA-Z_][a-zA-Z0-9_-]*/), // -- This order matters
    identifier: ($) => prec(PREC.id,                // -- Swapping will error
      choice(
        $.builtin_function,
        $.var_identifier,
        $.type_identifier, 
        $.import_export,
        $.exception_identifiers,
        $.repeat_identifiers,
        prec(KPREC.ident, /[a-z_][a-zA-Z0-9_-]*/)
      )),

    var_identifier: (_$) => prec(KPREC.var, choice(/[a-z]/, /[a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9]/)),
    type_identifier: ($) => prec(KPREC.type, choice(
      $.builtin_type,
      /[a-zA-Z]/,/[a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9]/)
    ),
    builtin_type: ($) => prec(KPREC.builtin, choice(
      "int", "float", "bool", "none", "any", "void", "object", 
      "atype", "tagtype", "true", "false", "number", "pointer", 
      "string", "rawstring", "boolean", "char", "byte", "short",
      "long", "uchar", "ushort", "ulong", "uint", "int8", "int16",
      "int32", "int64", "charPtr", "voidPtr", "double",
      $.cfunc, $.error, 
    )),

    import_export: (_$) => choice("import", "export"),
    comment: (_$) => token(seq("--", /.*/), /\n|\r\n|$/),

    exception_identifiers: ($) => choice($.try_identifier, $.catch_identifier, "recover"),
    repeat_identifiers: (_$) => choice("do", "while", "for", "yield", "break", "continue", "pass"),
    builtin_function: (_$) => token(choice("len", "map", "print", "typeid", "indexChar", "insert", "string", "exit")),

    escape_sequence: (_$) => token(seq('\\', token.immediate(
      choice(
        /[uU][0-9a-fA-F]{1,6}/, 
        /x[0-9a-fA-F]{2}/,
        /["'`$\\abfnrtv]/,
        /[0-7]{1,3}/,
    )))),

    encoded_string: ($) => prec(PREC.eStr, 
      seq(
        $.numeric_literal, 
        $.string
    )),

    multiline_string: ($) => choice(
      // --| Triple Quoted ------------
      prec(2, seq(
        alias($._string_start,  "'''"), 
        repeat(choice(
          $.string_interpolation, 
          $._string_content,
        )), 
        alias($._string_end, "'''"))),

      // --| Double Quoted ------------
      prec(1, seq(
        alias($._string_start,  '"'), 
        repeat(choice(
          $.string_interpolation, 
          $._string_content,
        )), 
        alias($._string_end, '"'),
    ))),

      // --| Single Quoted ------------
    string: ($) => prec(PREC.string, choice(       
      prec(50, seq(
        "'", 
        repeat(
          choice(
            /[^'{}\\]+/, /\\./,
            $.string_interpolation, 
          )), 
        "'"
      )),
    )),

    string_interpolation: ($) => prec(PREC.iStr, seq(
      $._open_brace, 
      $._expression, 
      $._close_brace
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
      $._expression_statement,
      $.coyield_statement,
      $.print_statement,
      $.return_statement,
      $.exit_statement
    ),

    _complex_statement: ($) =>
    choice(
      $.if_statement,
      $.match_statement,
      $.loop_statement,
      $.while_loop,
      $.for_range_loop,
      $.for_iterable_loop,
      $.try_statement,
      $.recover_block
    ),

    _declaration: ($) => prec.left(60, 
      choice(
        $.local_declaration,
        $.typed_statement,
        $.var_declaration,
        $.function_definition,
        $.tagtype_declaration
      )
    ),

    // --| Declarations ---------------
    // --|-----------------------------
    shebang: ($) => seq("#!", /.*/, $._newline),
    import_statement: ($) => prec(13, seq("import", $.identifier, $.string)),

    local_declaration: ($) => prec.left(PREC.loDef, 
      seq(
        field("name", $._expression),
        choice(
          prec.left(10, seq("=",
            choice(
              prec.left(10, $._expression),
              prec.left(10 ,$._statement)
            ))),
          prec.left(0 , field("type", $.identifier)),
        ),
      )),

    // Static variable declaration
    var_declaration: ($) => prec.left(PREC.varDef, seq(
      "var", $.identifier, 
      optional($.type_identifier),
      seq(":", 
        choice(
          $._expression,
          $._statement
        )))
    ),

    anonymous_function: ($) => prec.left(seq($.func, parenthesized($, optional(list_of($, $.parameter))))),
    anonymous_definition: ($) => prec.left(PREC.function, seq(
      prec.left($.anonymous_function),
      optional($._block_group)
    )),

    // Static function declaration
    function_definition: ($) => prec(PREC.fnDef, seq(
      alias("func", $.func),
      choice($.function_declaration, $.method_declaration),
      optional(field("return_type", $.identifier)),
      choice(
        field("body", $._block_group),
        field("static_assignment", seq("=", $._standard_statements)),
        $._standard_statements
      )
    )),

    function_declaration: ($) => prec.left(PREC.fnDef, seq(
      field("name", $.identifier),
      choice(
        prec.left(field("parameters", parenthesized($, optional(list_of($, $.typed_parameter))))),
        field("parameters", parenthesized($, list_of($, seq(
          $.parameter, 
          optional(
            seq(
              // $._whitespace, 
              choice(
                $.type_identifier,
                $.field_expression
              )))
        ))))
      ),
    )),

    method_declaration: ($) => prec.left(PREC.fnDef - 1, seq(
      field("name", $.identifier),
      field("parameters", $.method_parameter_list),
    )),

    parenthesized_expression: ($) => prec.left(PREC.paramList, 
      choice(
        prec(3, seq(parenthesized($, optional($.parameter), true))),
        prec(2, seq(parenthesized($, optional(list_of($, $.parameter, ',')),true))),
        prec(1, repeat1(seq(parenthesized($, optional(list_of($, $.parameter, ',')), true)))),
      )),

    method_parameter_list: ($) => prec.left(PREC.paramList,
      parenthesized($,
        seq(
          seq($.self, optional(",")), 
          optional(list_of($, $.parameter, ','))
        ),
      )),

    typed_parameter: ($) => prec.left(PREC.param, seq(  
      field("name", $.identifier),
      choice(field("type", $.type_identifier), field("type", $.field_expression))
    )),

    parameter: ($) => prec.left(PREC.param, seq(
      prec.left(50,
        choice(
          prec.left(PREC.param, $._expression),
          prec.left(PREC.param - 1, 
            seq(
              field("name", $.identifier),
              optional($.type_identifier)
            )
          ))
    ))),

    // --| Object Definitions ---------
    // --|-----------------------------
    typed_statement: ($) => prec.left(PREC.object, seq(
      $.type,
      field("object_name", $.type_identifier),
      choice(
        alias($.field_expression, $.type_alias),
        $.identifier
      ),
      choice(
        $.object_definition,
        $._newline,
      )
    )),

    object_definition: ($) => seq(
      alias($._scope_start, ":"),      
      field("body", $.object_block)
    ),

    object_member: ($) => prec.left(PREC.object + 1, seq(
      prec(PREC.object+1, field("member", $.identifier)), 
      prec(PREC.object, optional(
        choice(
          // field("type", $.builtin_type),
          field("type", $.type_identifier),
          field("type", $.field_expression) 
      ))),
      $._newline
    )),

    object_block: ($) => prec.left(PREC.object+1, seq(
      $._indent,
      prec(PREC.object, repeat1(prec(PREC.object, $.object_member))),
      prec(PREC.object, repeat(prec(PREC.object, $._statement))),
      $._dedent,
    )),

    type_alias: ($) => seq( $._newline ),

    // --| Tag Types ------------------
    // --|-----------------------------
    tagtype_declaration: ($) => prec.left(PREC.tag, seq(
      "tagtype", $.identifier, 
      optional($._tagtype_body)
    )),

    _tagtype_body: ($) => prec.left(seq(
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
    if_statement: ($) => prec.left(PREC.if, seq(
      "if", 
      prec.left(PREC.if, $._if_statement),
      repeat(field("else", $._else_statement))
    )),

    _if_statement: ($) => prec.left(PREC.if,
      seq(
        seq(field("condition", $._expression)),
        field("body", $._block_group),
      )),

    if_statement_inline: ($) => prec.left(PREC.if,
      seq(
        field("condition", $._expression),
        field("inline_body", $._statement)
      )),

    _else_statement: ($) => prec.left(40,
      seq(
        $.else_identifier, optional($._expression),
        field("body", $._block_group)
      )),

      // --| Match Statements -----------
    // --|-----------------------------
    match_statement: ($) => seq(
      "match", field("subject", $._expression),
      field("body", $.match_block),
    ),

    match_block: ($) => prec.left(seq(
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
        $.else_identifier
      ),
      ":",
      choice(
        field("value", $._standard_statement),
        field("value", $._expression),
      ))),

    match_default: ($) => seq(
      $.else_identifier, field("body", $._block_group)
    ),

    // --| Iteration ------------------
    // --|-----------------------------
    loop_statement: ($) => prec(15, seq(
      "loop", 
      field("body", $._block_group)
    )),

    while_loop: ($) => prec(1, seq(
      "while",
      optional(field("condition", $._expression)),
      optional(seq("some", field("variable", $.identifier))),
      field("body", $._block_group)
    )),

    // --| For-Loops -------------
    // --|------------------------
    for_range_loop:    ($) => prec.left(PREC.for,   seq("for", $._for_range_loop)),
    for_iterable_loop: ($) => prec.left(PREC.for+1, seq("for", $._for_iterable_loop)),

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

    // --| Exception Statements --
    // --|------------------------
    try_statement: ($) => prec.left(1, seq(
      $.try_identifier,
      field("body", $._block_group),
      $.catch_statement,
    )),

    catch_identifier: (_$) => "catch",  
    catch_statement: ($) => prec.left(1, seq(
      $.catch_identifier,
      optional(field("exception", $.identifier)),
      field("body", $.catch_block),
    )),

    catch_block: ($) => prec.left(seq(
      $._scope_start,
      $._indent,
      repeat1($._statement),
      choice($._dedent, $._newline),
    )),

    // --| Other Statements ------
    // --|------------------------
    coyield_statement: ($) => prec(PREC.coyield, seq(field("coyield", $.coyield), $._newline)),
    
    print_statement: ($) => prec.left(2, seq("print", $._expression)),
    exit_statement: ($) => prec.left(2, seq("exit", $.numeric_literal)),

    return_statement: ($) => prec.left(
      seq(
        "return", 
        optional(list_of($, $._expression)), 
        optional($._newline)
    )),

    // --| Blocks ----------------
    // --|------------------------
    _block_group: ($) => prec.left(PREC.block, 
      choice(
        $.inline_block,
        $.block,
      )),

    inline_block: ($) => prec.left(PREC.block + 1, seq(
      alias($._inline_statement,":"),
      $._statement,
      $._newline,
    )),

    block: ($) => prec.left(seq(
      alias($._scope_start, ":"),
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
      prec.left(49 ,choice(
        prec(PREC.parenExpr,   $.parenthesized_expression),
        prec.left(PREC.id,     $.identifier),
        prec.left(PREC.numeric,$.numeric_literal),
        prec(PREC.string,      $.string),
        prec(PREC.eStr,        $.encoded_string),
        prec(PREC.mStr,        $.multiline_string),
        prec(PREC.bool,        $.boolean),
        prec(PREC.binary,      $.binary_operator),
        prec(PREC.boolean ,    $.boolean_operator),
        prec(PREC.negation,    $.negation_operator),
        prec(PREC.comparison,  $.comparison_operator),
        prec(PREC.object,      $.object_initializer),
        prec(PREC.augmented,   $.augmented_assignment),
        prec(PREC.if,          $.if_expression),
        prec(PREC.anonymous,   $.anonymous_definition),
        prec(PREC.cfunc,       $.cfunc_call),
        prec(PREC.cstruct,     $.cstruct_call),
        // prec(PREC.find_rune,   $.find_rune),
        prec(PREC.field,       $.field_expression),
        prec(PREC.call,        $.call_expression),
        prec(PREC.type_cast,   $.type_cast),
        prec(PREC.closure,     $.closure_expression),
        prec(PREC.capture,     $.capture_expression), 
        prec(PREC.static,      $.static_expression), 
        prec(PREC.error,       $.error_expression),
        prec(PREC.throw,       $.throw_expression),
        prec(PREC.try,         $.try_expression),
        prec(PREC.try_else,    $.try_else_expression),
        prec(PREC.catch,       $.catch_expression),
        prec(PREC.panic,       $.panic_expression),
        prec(PREC.coinit,      $.coinit_expression),
        prec(PREC.coresume,    $.coresume_expression),
        prec(PREC.enclosed,    $.enclosed_expression),
        prec(PREC.tag,         $.tag_expression),
        prec.left(PREC.index,  $.index_expression),
    )),

    // --| Operators ------------------
    // --|-----------------------------
    or_operator:   (_$) => "or",
    and_operator:  (_$) => "and",
    not_operator:  (_$) => "not",
    bang_operator: (_$) => "!",

    boolean_operator: ($) => prec(48,choice(
      prec.left(PREC.and, seq(
        field("left", $._expression),
        field("operator", $.and_operator),
        field("right", $._expression)
      )),
      prec.left(PREC.or, seq(
        field("left", $._expression),
        field("operator", $.or_operator),
        field("right", $._expression)
      )),
      prec.left(PREC.not, seq(
        choice(
          prec(PREC.not, field("operator", $.not_operator)),
          prec(PREC.not + 50,field("operator", $.bang_operator)),
        ),
        prec(PREC.call ,field("right", $._expression))
      )),
    )),

    binary_operator: ($) => {
      return choice(
        ...operators.map(([fn, operator, precedence]) =>
          fn(precedence,
            prec.left(60, 
              choice(
                prec.left(62 ,seq(
                  field("left", $.parameter),
                  field("operator", operator),
                  field("right", $.parameter),
                )),
                
                prec.left(61, seq(
                  field("operator", operator),
                  field("right", $.parameter), 
                )),
                
                prec.left(60, seq(
                  field("left", $.parameter), 
                  field("operator", operator),
                )),
            )))));
    },

    arithmetic_expression: ($) =>
    {
      return choice(
        ...operators.map(([fn, operator, precedence]) =>
          fn(precedence,
            choice(
              prec.left(70, (repeat1(seq($.parameter, operator)))),
              prec.left(70, (repeat1(seq(operator, $.parameter)))),
              prec.left(70, (repeat1(seq(optional(operator), $.parameter, operator)))),
              prec.left(53, (seq(operator, $.numeric_literal))),
              prec.left(53, (seq($.numeric_literal, operator))),
              prec.left(52, (seq($.numeric_literal, operator, $.numeric_literal))),
              prec.left(51, (seq($._expression, operator))),
              prec.left(51, (seq(operator, $._expression))),
              prec.left(50, (seq($._expression, operator, $.numeric_literal))),
              prec.left(50, (seq($.numeric_literal, operator, $._expression))),
            ),
        )));
    },

    negation_operator: ($) => 
      prec.left(PREC.negation, seq(
        field("operator", choice("-")),
        choice(
          field("left", $.parenthesized_expression),
        ),
      )),

    comparison_operator: ($) => prec.left(PREC.compare, seq(
      prec.left(50, field("left", 
        choice(
          $.numeric_literal,
          $._expression
        ))),
      prec.left(
        seq(
          field("operators", choice("<", "<=", "==", "!=", ">=", ">", "<>", "in", 
            seq($.not_operator, "in"), "is", seq("is", $.not_operator))), 
        )),
      prec.left(50, field("right", 
        choice(
          $.numeric_literal, 
          $._expression
        ))),
    )),

    // --| Assignment -----------------
    // --|-----------------------------
    augmented_assignment: ($) =>
      seq(
        field("left", $._left_hand_side),
        field("operator", choice(
          "+=", "-=", "*=", "/=")),
        field("right", $._right_hand_side)
      ),

    _left_hand_side: ($) => choice($.pattern),

    _right_hand_side: ($) => prec.left(35,
      choice(
        list_of($ ,$._expression),
        $.augmented_assignment
    )),

    pattern: ($) =>
      choice(
        $.identifier,
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

    // --| If Expression --------------
    // --|-----------------------------
    if_expression: ($) => prec.left(PREC.if, seq(
      "if", field("condition", $._expression),
      "then", field("then", $._expression),
      $.else_identifier, field("else", $._expression)
    )),

    // --| Field/Accessor -------------
    // --|-----------------------------
    accessor: ($) => prec(PREC.call, repeat1(seq(
      field("value", $._expression), ".",
    ))),   

    field_expression: ($) => prec(PREC.field,
      seq(
        field("object", $._expression), ".",
        field("property", choice(
          prec(PREC.field - 1, $.accessor),
          prec(PREC.field, $._expression),
        ))
    )),

    // --| Functions ------------------
    // --|-----------------------------
    call_expression: ($) => prec.left(PREC.call,
      choice(
        prec(PREC.call, seq(
          field("name", $.identifier), 
          parenthesized($, seq(optional(prec.left(list_of($, $.parameter))),
          ))
        )),
      )),

    // --| Object ---------------------
    // --|-----------------------------
    object_initializer: ($) => prec.left(PREC.object, seq(
      field("object_name", $.type_identifier),
      $._open_brace, 
          choice(
            optional($.member_assignment),
            optional(sep1($, $.member_assignment, optional(","))), 
          ),
        optional(","),
      $._close_brace
    )),

    member_assignment: ($) => prec.left(PREC.object - 1,
      seq(
        field("member", $.identifier), ":", field("value", $._expression),
        optional(","),
        optional($._newline)
      )
    ),

    argument_list: ($) => commaSep1($, $._expression),

    parenthesized_expression: ($) => prec.left(PREC.parenExpr, seq(
      "(",
      choice(
        $.identifier,
        $.numeric_literal,
        $.binary_operator,
        $._expression,
      ), 
        ")"
    )),

    // --| Type Related ---------------
    // --|-----------------------------
    as_identifier: (_$) => "as",
    type_cast: ($) => prec.left(PREC.type_cast, seq(
      $._expression, $.as_identifier, $.type_identifier
    )),

    
    // --| Lambda ---------------------
    // --|-----------------------------
    lambda_operator: (_$) => "=>",
    lambda_expression: ($) => prec.left(PREC.lambda, seq(
      parenthesized($, list_of($, $.parameter)), parenthesized($, list_of($, $.parameter)) 
    )),

    // --| Closure --------------------
    // --|-----------------------------
    closure_expression: ($) => prec.left(PREC.closure, 
      choice(
        seq(parenthesized($, list_of($, $.parameter)), $.lambda_operator, $._expression),
        seq($._expression, $.lambda_operator, $._expression),
    )),

    // --| Capture --------------------
    // --|-----------------------------
    capture_identifier: (_$) => "capture",
    capture_expression: ($) => prec.left(PREC.capture, seq(
      $.capture_identifier, $._expression
    )),
    
    // --| Static ---------------------
    // --|-----------------------------
    static_identifier: (_$) => "static",
    static_expression: ($) => prec.left(PREC.static, seq(
      $.static_identifier, $._expression
    )),

    // --| Exception ------------------
    // --|-----------------------------
    error_expression: ($) => prec.left(PREC.error, 
      choice(
        seq($.error,".", $._expression),
        seq($.error, $._open_paren, $._expression, $._close_paren),
    )),

    try_expression: ($) => prec.left(PREC.try,
      choice(
        prec(20, seq($.try_identifier, $._expression, $.else_expression)),
        seq($.try_identifier, $._expression),
      )
    ),
    
    else_expression: ($) => prec.left(PREC.else, seq(
      $.else_identifier, $._expression
    )),

    try_else_expression: ($) => prec.left(PREC.try_else, seq(
      $.try_expression, $.else_expression,
    )),

    catch_expression: ($) => prec.left(PREC.catch, seq(
      $.catch_identifier,
      $._expression,
      optional(seq("then", $._expression)),
      optional(seq($.as_identifier, $.identifier, "then", $._expression))
    )),

    panic_expression: ($) => prec.left(PREC.panic, seq(
      $.panic_identifier, $._expression)
    ),
    
    throw_expression: ($) => prec.left(PREC.throw, seq(
      $.throw_identifier, $._expression)
    ),

    // --| FFI ------------------------
    // --|-----------------------------
    // --| CFunc ----------------------
    cfunc_call: ($) => prec.left(PREC.cfunc, seq(
      $.cfunc, $._open_brace, $.symbol_parameter, $.args_parameter, $.ret_parameter, $._close_brace)
    ),

    symbol_parameter: ($) => prec.left(PREC.cfunc, seq( "sym", ":" , field("symbol", $.string), ",",)),
    args_parameter: ($) => prec.left(PREC.cfunc, seq( "args", ":" , field("arguments", $.array_contents), ",",)),
    ret_parameter: ($) => prec.left(PREC.cfunc, seq( "ret", ":" , field("type_mapping", choice($.identifier, $.tag_expression)),)),

    // --| CStruct --------------------
    cstruct_call: ($) => prec.left(PREC.cstruct, seq(
      "CStruct", $._open_brace, $.fields_parameter, $.object_parameter, $._close_brace)
    ),

    fields_parameter: ($) => prec.left(PREC.cstruct, seq( "fields", ":" , field("arguments", $.array_contents), ",",)),
    object_parameter: ($) => prec.left(PREC.cstruct, seq( "type", ":" , field("object_mapping", $.identifier))),

    // --| findRune -------------------
    find_rune: ($) => prec.left(PREC.find_rune, seq(
      "findRune", $._open_paren, 
        choice(
          prec.left($.encoded_string),
          prec.left($.string),
          prec.left($.numeric_literal),
        ),
    $._close_paren
    )),

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
      parenthesized($, field("parameters", list_of($, $.parameter))),
    ),

    coresume_expression: ($) => prec.left(seq(
      field("coresume", $.coresume), field("operand", $._expression)
    )),

    // --| Array/Map ------------------
    // --|-----------------------------
    range_expressions: ($) => choice($.range_expression),

    range_expression: ($) => prec.left(1, seq(
      field("left", $.identifier),
      field("operator", $.range_operator),
      field("right", $.identifier)
    )),

    index_expression: ($) => prec.left(PREC.index, seq(
      $._expression, 
      choice(
        prec.left(PREC.slice, seq( 
          $._open_bracket, 
          choice($.array_contents, $.slice), 
          $._close_bracket)
        ),
      ),
    )),

    key_value_pair: ($) => prec(PREC.kvp, seq(
      field("key", $._expression), ":", field("value", $._expression)
    )),

    slice: ($) => prec.left(PREC.slice, seq(
      choice(
      seq($.range_operator, field("end", $._expression)),
        seq(field("start", $._expression), $.range_operator),
        seq(field("start", $._expression), $.range_operator, field("end", $._expression)),
      ),
    )),

    map_literal: ($) => seq( 
        choice(
          prec.left(seq(commaSep1($, $.key_value_pair, true))),
          prec.left(repeat1(prec.left(seq($.key_value_pair, optional(','), optional($._newline))))),
        ), 
    ),

    enclosed_expression: ($) => choice(
      prec.left($.object_initializer),
      seq($._open_paren,   $._expression,             $._close_paren),
      field("array_literal", seq($._open_bracket, optional($.array_contents), $._close_bracket)),
      seq($._open_brace,   optional($.map_literal),   $._close_brace),
    ),

    array_contents: ($) => prec.left(1 ,seq(
        prec.left(2, list_of($, $._expression, ',', true)),
    )),

    // --| Keywords/Indicators --------
    // --|-----------------------------
    _statement_indicator: (_$) => token(":"),

    true:  (_$) => "true",
    false: (_$) => "false",
    none:  (_$) => "none",
    self:  (_$) => "self",
    type:  (_$) => token("type"),
    func:  (_$) => token("func"),
    error: (_$) => token("error"),
    cfunc: (_$) => token("CFunc"),  
    try_identifier: (_$) => "try",
    else_identifier: (_$) => "else",
    panic_identifier: (_$) => "panic",  
    throw_identifier: (_$) => "throw",  
    range_operator: (_$) => "..",

    ident: (_$) => /[a-zA-Z\x80-\xff](_?[a-zA-Z0-9\x80-\xff])*/,

    boolean: (_$) => choice("true", "false", "none"),

    coinit:   (_$) => "coinit",
    coresume: (_$) => "coresume",
    coyield:  (_$) => "coyield",
    _open_paren:    (_$) => alias("open_paren", "("),
    _close_paren:   (_$) => field("close_paren", ")"),
    _open_brace:    (_$) => field("open_brace", "{"),       
    _close_brace:   (_$) => field("close_brace", "}"),
    _open_bracket:  (_$) => field("open_bracket", "["),
    _close_bracket: (_$) => field("close_bracket", "]"),

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
      "indexChar"),
      $.identifier)
    ),
  },
});
