#include <tree_sitter/parser.h>

#if defined(__GNUC__) || defined(__clang__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wmissing-field-initializers"
#endif

#define LANGUAGE_VERSION 14
#define STATE_COUNT 50
#define LARGE_STATE_COUNT 2
#define SYMBOL_COUNT 34
#define ALIAS_COUNT 0
#define TOKEN_COUNT 16
#define EXTERNAL_TOKEN_COUNT 0
#define FIELD_COUNT 0
#define MAX_ALIAS_SEQUENCE_LENGTH 4
#define PRODUCTION_ID_COUNT 1

enum {
  sym_shebang = 1,
  sym_comment = 2,
  anon_sym_import = 3,
  sym_identifier = 4,
  anon_sym_SQUOTE = 5,
  anon_sym_EQ = 6,
  anon_sym_LPAREN = 7,
  anon_sym_RPAREN = 8,
  sym_string = 9,
  anon_sym_LBRACE = 10,
  anon_sym_COMMA = 11,
  anon_sym_RBRACE = 12,
  anon_sym_COLON = 13,
  anon_sym_if = 14,
  anon_sym_func = 15,
  sym_source_file = 16,
  sym__top_level_statement = 17,
  sym__inner_statement = 18,
  sym_import_statement = 19,
  sym_alias = 20,
  sym_assignment = 21,
  sym__expression = 22,
  sym_function_call = 23,
  sym_map = 24,
  sym_key_value = 25,
  sym_if_statement = 26,
  sym_statement_block = 27,
  sym_function_definition = 28,
  sym_parameters = 29,
  aux_sym_source_file_repeat1 = 30,
  aux_sym_map_repeat1 = 31,
  aux_sym_statement_block_repeat1 = 32,
  aux_sym_parameters_repeat1 = 33,
};

static const char * const ts_symbol_names[] = {
  [ts_builtin_sym_end] = "end",
  [sym_shebang] = "shebang",
  [sym_comment] = "comment",
  [anon_sym_import] = "import",
  [sym_identifier] = "identifier",
  [anon_sym_SQUOTE] = "'",
  [anon_sym_EQ] = "=",
  [anon_sym_LPAREN] = "(",
  [anon_sym_RPAREN] = ")",
  [sym_string] = "string",
  [anon_sym_LBRACE] = "{",
  [anon_sym_COMMA] = ",",
  [anon_sym_RBRACE] = "}",
  [anon_sym_COLON] = ":",
  [anon_sym_if] = "if",
  [anon_sym_func] = "func",
  [sym_source_file] = "source_file",
  [sym__top_level_statement] = "_top_level_statement",
  [sym__inner_statement] = "_inner_statement",
  [sym_import_statement] = "import_statement",
  [sym_alias] = "alias",
  [sym_assignment] = "assignment",
  [sym__expression] = "_expression",
  [sym_function_call] = "function_call",
  [sym_map] = "map",
  [sym_key_value] = "key_value",
  [sym_if_statement] = "if_statement",
  [sym_statement_block] = "statement_block",
  [sym_function_definition] = "function_definition",
  [sym_parameters] = "parameters",
  [aux_sym_source_file_repeat1] = "source_file_repeat1",
  [aux_sym_map_repeat1] = "map_repeat1",
  [aux_sym_statement_block_repeat1] = "statement_block_repeat1",
  [aux_sym_parameters_repeat1] = "parameters_repeat1",
};

static const TSSymbol ts_symbol_map[] = {
  [ts_builtin_sym_end] = ts_builtin_sym_end,
  [sym_shebang] = sym_shebang,
  [sym_comment] = sym_comment,
  [anon_sym_import] = anon_sym_import,
  [sym_identifier] = sym_identifier,
  [anon_sym_SQUOTE] = anon_sym_SQUOTE,
  [anon_sym_EQ] = anon_sym_EQ,
  [anon_sym_LPAREN] = anon_sym_LPAREN,
  [anon_sym_RPAREN] = anon_sym_RPAREN,
  [sym_string] = sym_string,
  [anon_sym_LBRACE] = anon_sym_LBRACE,
  [anon_sym_COMMA] = anon_sym_COMMA,
  [anon_sym_RBRACE] = anon_sym_RBRACE,
  [anon_sym_COLON] = anon_sym_COLON,
  [anon_sym_if] = anon_sym_if,
  [anon_sym_func] = anon_sym_func,
  [sym_source_file] = sym_source_file,
  [sym__top_level_statement] = sym__top_level_statement,
  [sym__inner_statement] = sym__inner_statement,
  [sym_import_statement] = sym_import_statement,
  [sym_alias] = sym_alias,
  [sym_assignment] = sym_assignment,
  [sym__expression] = sym__expression,
  [sym_function_call] = sym_function_call,
  [sym_map] = sym_map,
  [sym_key_value] = sym_key_value,
  [sym_if_statement] = sym_if_statement,
  [sym_statement_block] = sym_statement_block,
  [sym_function_definition] = sym_function_definition,
  [sym_parameters] = sym_parameters,
  [aux_sym_source_file_repeat1] = aux_sym_source_file_repeat1,
  [aux_sym_map_repeat1] = aux_sym_map_repeat1,
  [aux_sym_statement_block_repeat1] = aux_sym_statement_block_repeat1,
  [aux_sym_parameters_repeat1] = aux_sym_parameters_repeat1,
};

static const TSSymbolMetadata ts_symbol_metadata[] = {
  [ts_builtin_sym_end] = {
    .visible = false,
    .named = true,
  },
  [sym_shebang] = {
    .visible = true,
    .named = true,
  },
  [sym_comment] = {
    .visible = true,
    .named = true,
  },
  [anon_sym_import] = {
    .visible = true,
    .named = false,
  },
  [sym_identifier] = {
    .visible = true,
    .named = true,
  },
  [anon_sym_SQUOTE] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_EQ] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_LPAREN] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_RPAREN] = {
    .visible = true,
    .named = false,
  },
  [sym_string] = {
    .visible = true,
    .named = true,
  },
  [anon_sym_LBRACE] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_COMMA] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_RBRACE] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_COLON] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_if] = {
    .visible = true,
    .named = false,
  },
  [anon_sym_func] = {
    .visible = true,
    .named = false,
  },
  [sym_source_file] = {
    .visible = true,
    .named = true,
  },
  [sym__top_level_statement] = {
    .visible = false,
    .named = true,
  },
  [sym__inner_statement] = {
    .visible = false,
    .named = true,
  },
  [sym_import_statement] = {
    .visible = true,
    .named = true,
  },
  [sym_alias] = {
    .visible = true,
    .named = true,
  },
  [sym_assignment] = {
    .visible = true,
    .named = true,
  },
  [sym__expression] = {
    .visible = false,
    .named = true,
  },
  [sym_function_call] = {
    .visible = true,
    .named = true,
  },
  [sym_map] = {
    .visible = true,
    .named = true,
  },
  [sym_key_value] = {
    .visible = true,
    .named = true,
  },
  [sym_if_statement] = {
    .visible = true,
    .named = true,
  },
  [sym_statement_block] = {
    .visible = true,
    .named = true,
  },
  [sym_function_definition] = {
    .visible = true,
    .named = true,
  },
  [sym_parameters] = {
    .visible = true,
    .named = true,
  },
  [aux_sym_source_file_repeat1] = {
    .visible = false,
    .named = false,
  },
  [aux_sym_map_repeat1] = {
    .visible = false,
    .named = false,
  },
  [aux_sym_statement_block_repeat1] = {
    .visible = false,
    .named = false,
  },
  [aux_sym_parameters_repeat1] = {
    .visible = false,
    .named = false,
  },
};

static const TSSymbol ts_alias_sequences[PRODUCTION_ID_COUNT][MAX_ALIAS_SEQUENCE_LENGTH] = {
  [0] = {0},
};

static const uint16_t ts_non_terminal_alias_map[] = {
  0,
};

static const TSStateId ts_primary_state_ids[STATE_COUNT] = {
  [0] = 0,
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8,
  [9] = 9,
  [10] = 10,
  [11] = 11,
  [12] = 12,
  [13] = 13,
  [14] = 14,
  [15] = 15,
  [16] = 16,
  [17] = 17,
  [18] = 18,
  [19] = 19,
  [20] = 20,
  [21] = 21,
  [22] = 22,
  [23] = 23,
  [24] = 24,
  [25] = 25,
  [26] = 26,
  [27] = 27,
  [28] = 28,
  [29] = 29,
  [30] = 30,
  [31] = 31,
  [32] = 32,
  [33] = 33,
  [34] = 34,
  [35] = 35,
  [36] = 36,
  [37] = 37,
  [38] = 38,
  [39] = 39,
  [40] = 40,
  [41] = 41,
  [42] = 42,
  [43] = 43,
  [44] = 44,
  [45] = 45,
  [46] = 46,
  [47] = 47,
  [48] = 48,
  [49] = 49,
};

static bool ts_lex(TSLexer *lexer, TSStateId state) {
  START_LEXER();
  eof = lexer->eof(lexer);
  switch (state) {
    case 0:
      if (eof) ADVANCE(7);
      if (lookahead == '"') ADVANCE(4);
      if (lookahead == '#') ADVANCE(2);
      if (lookahead == '\'') ADVANCE(21);
      if (lookahead == '(') ADVANCE(23);
      if (lookahead == ')') ADVANCE(24);
      if (lookahead == ',') ADVANCE(27);
      if (lookahead == '-') ADVANCE(6);
      if (lookahead == ':') ADVANCE(29);
      if (lookahead == '=') ADVANCE(22);
      if (lookahead == 'f') ADVANCE(19);
      if (lookahead == 'i') ADVANCE(12);
      if (lookahead == '{') ADVANCE(26);
      if (lookahead == '}') ADVANCE(28);
      if (lookahead == '\t' ||
          lookahead == '\n' ||
          lookahead == '\r' ||
          lookahead == ' ') SKIP(0)
      if (('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 1:
      if (lookahead == '\n') ADVANCE(8);
      if (lookahead != 0) ADVANCE(1);
      END_STATE();
    case 2:
      if (lookahead == '!') ADVANCE(1);
      END_STATE();
    case 3:
      if (lookahead == '"') ADVANCE(4);
      if (lookahead == ')') ADVANCE(24);
      if (lookahead == '{') ADVANCE(26);
      if (lookahead == '}') ADVANCE(28);
      if (lookahead == '\t' ||
          lookahead == '\n' ||
          lookahead == '\r' ||
          lookahead == ' ') SKIP(3)
      if (('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 4:
      if (lookahead == '"') ADVANCE(25);
      if (lookahead != 0) ADVANCE(4);
      END_STATE();
    case 5:
      if (lookahead == '-') ADVANCE(6);
      if (lookahead == 'f') ADVANCE(19);
      if (lookahead == 'i') ADVANCE(13);
      if (lookahead == '\t' ||
          lookahead == '\n' ||
          lookahead == '\r' ||
          lookahead == ' ') SKIP(5)
      if (('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 6:
      if (lookahead == '-') ADVANCE(9);
      END_STATE();
    case 7:
      ACCEPT_TOKEN(ts_builtin_sym_end);
      END_STATE();
    case 8:
      ACCEPT_TOKEN(sym_shebang);
      END_STATE();
    case 9:
      ACCEPT_TOKEN(sym_comment);
      if (lookahead != 0 &&
          lookahead != '\n') ADVANCE(9);
      END_STATE();
    case 10:
      ACCEPT_TOKEN(anon_sym_import);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 11:
      ACCEPT_TOKEN(sym_identifier);
      if (lookahead == 'c') ADVANCE(31);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 12:
      ACCEPT_TOKEN(sym_identifier);
      if (lookahead == 'f') ADVANCE(30);
      if (lookahead == 'm') ADVANCE(16);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 13:
      ACCEPT_TOKEN(sym_identifier);
      if (lookahead == 'f') ADVANCE(30);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 14:
      ACCEPT_TOKEN(sym_identifier);
      if (lookahead == 'n') ADVANCE(11);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 15:
      ACCEPT_TOKEN(sym_identifier);
      if (lookahead == 'o') ADVANCE(17);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 16:
      ACCEPT_TOKEN(sym_identifier);
      if (lookahead == 'p') ADVANCE(15);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 17:
      ACCEPT_TOKEN(sym_identifier);
      if (lookahead == 'r') ADVANCE(18);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 18:
      ACCEPT_TOKEN(sym_identifier);
      if (lookahead == 't') ADVANCE(10);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 19:
      ACCEPT_TOKEN(sym_identifier);
      if (lookahead == 'u') ADVANCE(14);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 20:
      ACCEPT_TOKEN(sym_identifier);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 21:
      ACCEPT_TOKEN(anon_sym_SQUOTE);
      END_STATE();
    case 22:
      ACCEPT_TOKEN(anon_sym_EQ);
      END_STATE();
    case 23:
      ACCEPT_TOKEN(anon_sym_LPAREN);
      END_STATE();
    case 24:
      ACCEPT_TOKEN(anon_sym_RPAREN);
      END_STATE();
    case 25:
      ACCEPT_TOKEN(sym_string);
      END_STATE();
    case 26:
      ACCEPT_TOKEN(anon_sym_LBRACE);
      END_STATE();
    case 27:
      ACCEPT_TOKEN(anon_sym_COMMA);
      END_STATE();
    case 28:
      ACCEPT_TOKEN(anon_sym_RBRACE);
      END_STATE();
    case 29:
      ACCEPT_TOKEN(anon_sym_COLON);
      END_STATE();
    case 30:
      ACCEPT_TOKEN(anon_sym_if);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    case 31:
      ACCEPT_TOKEN(anon_sym_func);
      if (('0' <= lookahead && lookahead <= '9') ||
          ('A' <= lookahead && lookahead <= 'Z') ||
          lookahead == '_' ||
          ('a' <= lookahead && lookahead <= 'z')) ADVANCE(20);
      END_STATE();
    default:
      return false;
  }
}

static const TSLexMode ts_lex_modes[STATE_COUNT] = {
  [0] = {.lex_state = 0},
  [1] = {.lex_state = 0},
  [2] = {.lex_state = 0},
  [3] = {.lex_state = 0},
  [4] = {.lex_state = 0},
  [5] = {.lex_state = 0},
  [6] = {.lex_state = 0},
  [7] = {.lex_state = 0},
  [8] = {.lex_state = 0},
  [9] = {.lex_state = 0},
  [10] = {.lex_state = 0},
  [11] = {.lex_state = 0},
  [12] = {.lex_state = 5},
  [13] = {.lex_state = 5},
  [14] = {.lex_state = 0},
  [15] = {.lex_state = 0},
  [16] = {.lex_state = 3},
  [17] = {.lex_state = 0},
  [18] = {.lex_state = 0},
  [19] = {.lex_state = 0},
  [20] = {.lex_state = 3},
  [21] = {.lex_state = 3},
  [22] = {.lex_state = 3},
  [23] = {.lex_state = 5},
  [24] = {.lex_state = 5},
  [25] = {.lex_state = 5},
  [26] = {.lex_state = 3},
  [27] = {.lex_state = 0},
  [28] = {.lex_state = 0},
  [29] = {.lex_state = 0},
  [30] = {.lex_state = 0},
  [31] = {.lex_state = 0},
  [32] = {.lex_state = 0},
  [33] = {.lex_state = 0},
  [34] = {.lex_state = 3},
  [35] = {.lex_state = 3},
  [36] = {.lex_state = 0},
  [37] = {.lex_state = 0},
  [38] = {.lex_state = 0},
  [39] = {.lex_state = 0},
  [40] = {.lex_state = 0},
  [41] = {.lex_state = 3},
  [42] = {.lex_state = 0},
  [43] = {.lex_state = 0},
  [44] = {.lex_state = 3},
  [45] = {.lex_state = 0},
  [46] = {.lex_state = 3},
  [47] = {.lex_state = 0},
  [48] = {.lex_state = 3},
  [49] = {.lex_state = 0},
};

static const uint16_t ts_parse_table[LARGE_STATE_COUNT][SYMBOL_COUNT] = {
  [0] = {
    [ts_builtin_sym_end] = ACTIONS(1),
    [sym_shebang] = ACTIONS(1),
    [sym_comment] = ACTIONS(1),
    [anon_sym_import] = ACTIONS(1),
    [sym_identifier] = ACTIONS(1),
    [anon_sym_SQUOTE] = ACTIONS(1),
    [anon_sym_EQ] = ACTIONS(1),
    [anon_sym_LPAREN] = ACTIONS(1),
    [anon_sym_RPAREN] = ACTIONS(1),
    [sym_string] = ACTIONS(1),
    [anon_sym_LBRACE] = ACTIONS(1),
    [anon_sym_COMMA] = ACTIONS(1),
    [anon_sym_RBRACE] = ACTIONS(1),
    [anon_sym_COLON] = ACTIONS(1),
    [anon_sym_if] = ACTIONS(1),
    [anon_sym_func] = ACTIONS(1),
  },
  [1] = {
    [sym_source_file] = STATE(47),
    [sym__top_level_statement] = STATE(2),
    [sym_import_statement] = STATE(2),
    [sym_assignment] = STATE(2),
    [sym_if_statement] = STATE(2),
    [sym_function_definition] = STATE(2),
    [aux_sym_source_file_repeat1] = STATE(2),
    [ts_builtin_sym_end] = ACTIONS(3),
    [sym_shebang] = ACTIONS(5),
    [sym_comment] = ACTIONS(5),
    [anon_sym_import] = ACTIONS(7),
    [sym_identifier] = ACTIONS(9),
    [anon_sym_if] = ACTIONS(11),
    [anon_sym_func] = ACTIONS(13),
  },
};

static const uint16_t ts_small_parse_table[] = {
  [0] = 7,
    ACTIONS(7), 1,
      anon_sym_import,
    ACTIONS(9), 1,
      sym_identifier,
    ACTIONS(11), 1,
      anon_sym_if,
    ACTIONS(13), 1,
      anon_sym_func,
    ACTIONS(15), 1,
      ts_builtin_sym_end,
    ACTIONS(17), 2,
      sym_shebang,
      sym_comment,
    STATE(3), 6,
      sym__top_level_statement,
      sym_import_statement,
      sym_assignment,
      sym_if_statement,
      sym_function_definition,
      aux_sym_source_file_repeat1,
  [28] = 7,
    ACTIONS(19), 1,
      ts_builtin_sym_end,
    ACTIONS(24), 1,
      anon_sym_import,
    ACTIONS(27), 1,
      sym_identifier,
    ACTIONS(30), 1,
      anon_sym_if,
    ACTIONS(33), 1,
      anon_sym_func,
    ACTIONS(21), 2,
      sym_shebang,
      sym_comment,
    STATE(3), 6,
      sym__top_level_statement,
      sym_import_statement,
      sym_assignment,
      sym_if_statement,
      sym_function_definition,
      aux_sym_source_file_repeat1,
  [56] = 3,
    ACTIONS(36), 3,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
    ACTIONS(38), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
    STATE(5), 5,
      sym__inner_statement,
      sym_assignment,
      sym_if_statement,
      sym_function_definition,
      aux_sym_statement_block_repeat1,
  [75] = 7,
    ACTIONS(42), 1,
      sym_comment,
    ACTIONS(45), 1,
      anon_sym_import,
    ACTIONS(47), 1,
      sym_identifier,
    ACTIONS(50), 1,
      anon_sym_if,
    ACTIONS(53), 1,
      anon_sym_func,
    ACTIONS(40), 2,
      ts_builtin_sym_end,
      sym_shebang,
    STATE(5), 5,
      sym__inner_statement,
      sym_assignment,
      sym_if_statement,
      sym_function_definition,
      aux_sym_statement_block_repeat1,
  [102] = 3,
    ACTIONS(60), 1,
      anon_sym_LPAREN,
    ACTIONS(58), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
    ACTIONS(56), 7,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
      anon_sym_RPAREN,
      anon_sym_COMMA,
      anon_sym_RBRACE,
      anon_sym_COLON,
  [121] = 2,
    ACTIONS(64), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
    ACTIONS(62), 7,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
      anon_sym_RPAREN,
      anon_sym_COMMA,
      anon_sym_RBRACE,
      anon_sym_COLON,
  [137] = 2,
    ACTIONS(68), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
    ACTIONS(66), 7,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
      anon_sym_RPAREN,
      anon_sym_COMMA,
      anon_sym_RBRACE,
      anon_sym_COLON,
  [153] = 2,
    ACTIONS(72), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
    ACTIONS(70), 7,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
      anon_sym_RPAREN,
      anon_sym_COMMA,
      anon_sym_RBRACE,
      anon_sym_COLON,
  [169] = 2,
    ACTIONS(76), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
    ACTIONS(74), 7,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
      anon_sym_RPAREN,
      anon_sym_COMMA,
      anon_sym_RBRACE,
      anon_sym_COLON,
  [185] = 2,
    ACTIONS(80), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
    ACTIONS(78), 7,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
      anon_sym_RPAREN,
      anon_sym_COMMA,
      anon_sym_RBRACE,
      anon_sym_COLON,
  [201] = 6,
    ACTIONS(9), 1,
      sym_identifier,
    ACTIONS(11), 1,
      anon_sym_if,
    ACTIONS(13), 1,
      anon_sym_func,
    ACTIONS(82), 1,
      sym_comment,
    STATE(18), 1,
      sym_statement_block,
    STATE(4), 5,
      sym__inner_statement,
      sym_assignment,
      sym_if_statement,
      sym_function_definition,
      aux_sym_statement_block_repeat1,
  [224] = 6,
    ACTIONS(9), 1,
      sym_identifier,
    ACTIONS(11), 1,
      anon_sym_if,
    ACTIONS(13), 1,
      anon_sym_func,
    ACTIONS(82), 1,
      sym_comment,
    STATE(19), 1,
      sym_statement_block,
    STATE(4), 5,
      sym__inner_statement,
      sym_assignment,
      sym_if_statement,
      sym_function_definition,
      aux_sym_statement_block_repeat1,
  [247] = 2,
    ACTIONS(84), 3,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
    ACTIONS(86), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
  [259] = 2,
    ACTIONS(88), 3,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
    ACTIONS(90), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
  [271] = 5,
    ACTIONS(92), 1,
      sym_identifier,
    ACTIONS(94), 1,
      anon_sym_RPAREN,
    ACTIONS(96), 1,
      sym_string,
    ACTIONS(98), 1,
      anon_sym_LBRACE,
    STATE(40), 3,
      sym__expression,
      sym_function_call,
      sym_map,
  [289] = 2,
    ACTIONS(100), 3,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
    ACTIONS(102), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
  [301] = 2,
    ACTIONS(104), 3,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
    ACTIONS(106), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
  [313] = 2,
    ACTIONS(108), 3,
      ts_builtin_sym_end,
      sym_shebang,
      sym_comment,
    ACTIONS(110), 4,
      anon_sym_import,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
  [325] = 4,
    ACTIONS(92), 1,
      sym_identifier,
    ACTIONS(98), 1,
      anon_sym_LBRACE,
    ACTIONS(112), 1,
      sym_string,
    STATE(15), 3,
      sym__expression,
      sym_function_call,
      sym_map,
  [340] = 4,
    ACTIONS(92), 1,
      sym_identifier,
    ACTIONS(98), 1,
      anon_sym_LBRACE,
    ACTIONS(114), 1,
      sym_string,
    STATE(36), 3,
      sym__expression,
      sym_function_call,
      sym_map,
  [355] = 4,
    ACTIONS(92), 1,
      sym_identifier,
    ACTIONS(98), 1,
      anon_sym_LBRACE,
    ACTIONS(116), 1,
      sym_string,
    STATE(45), 3,
      sym__expression,
      sym_function_call,
      sym_map,
  [370] = 2,
    ACTIONS(118), 1,
      sym_comment,
    ACTIONS(120), 3,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
  [379] = 2,
    ACTIONS(122), 1,
      sym_comment,
    ACTIONS(124), 3,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
  [388] = 2,
    ACTIONS(126), 1,
      sym_comment,
    ACTIONS(128), 3,
      sym_identifier,
      anon_sym_if,
      anon_sym_func,
  [397] = 3,
    ACTIONS(130), 1,
      sym_identifier,
    ACTIONS(132), 1,
      anon_sym_RBRACE,
    STATE(29), 1,
      sym_key_value,
  [407] = 3,
    ACTIONS(134), 1,
      anon_sym_COMMA,
    ACTIONS(137), 1,
      anon_sym_RBRACE,
    STATE(27), 1,
      aux_sym_map_repeat1,
  [417] = 3,
    ACTIONS(139), 1,
      anon_sym_RPAREN,
    ACTIONS(141), 1,
      anon_sym_COMMA,
    STATE(28), 1,
      aux_sym_parameters_repeat1,
  [427] = 3,
    ACTIONS(144), 1,
      anon_sym_COMMA,
    ACTIONS(146), 1,
      anon_sym_RBRACE,
    STATE(31), 1,
      aux_sym_map_repeat1,
  [437] = 3,
    ACTIONS(148), 1,
      anon_sym_RPAREN,
    ACTIONS(150), 1,
      anon_sym_COMMA,
    STATE(28), 1,
      aux_sym_parameters_repeat1,
  [447] = 3,
    ACTIONS(144), 1,
      anon_sym_COMMA,
    ACTIONS(152), 1,
      anon_sym_RBRACE,
    STATE(27), 1,
      aux_sym_map_repeat1,
  [457] = 3,
    ACTIONS(150), 1,
      anon_sym_COMMA,
    ACTIONS(154), 1,
      anon_sym_RPAREN,
    STATE(30), 1,
      aux_sym_parameters_repeat1,
  [467] = 2,
    ACTIONS(156), 1,
      anon_sym_LPAREN,
    STATE(12), 1,
      sym_parameters,
  [474] = 2,
    ACTIONS(130), 1,
      sym_identifier,
    STATE(37), 1,
      sym_key_value,
  [481] = 2,
    ACTIONS(158), 1,
      sym_identifier,
    ACTIONS(160), 1,
      anon_sym_RPAREN,
  [488] = 1,
    ACTIONS(162), 2,
      anon_sym_COMMA,
      anon_sym_RBRACE,
  [493] = 1,
    ACTIONS(137), 2,
      anon_sym_COMMA,
      anon_sym_RBRACE,
  [498] = 2,
    ACTIONS(164), 1,
      anon_sym_SQUOTE,
    STATE(14), 1,
      sym_alias,
  [505] = 1,
    ACTIONS(139), 2,
      anon_sym_RPAREN,
      anon_sym_COMMA,
  [510] = 1,
    ACTIONS(166), 1,
      anon_sym_RPAREN,
  [514] = 1,
    ACTIONS(168), 1,
      sym_identifier,
  [518] = 1,
    ACTIONS(170), 1,
      anon_sym_SQUOTE,
  [522] = 1,
    ACTIONS(172), 1,
      anon_sym_COLON,
  [526] = 1,
    ACTIONS(174), 1,
      sym_identifier,
  [530] = 1,
    ACTIONS(176), 1,
      anon_sym_COLON,
  [534] = 1,
    ACTIONS(178), 1,
      sym_identifier,
  [538] = 1,
    ACTIONS(180), 1,
      ts_builtin_sym_end,
  [542] = 1,
    ACTIONS(182), 1,
      sym_identifier,
  [546] = 1,
    ACTIONS(184), 1,
      anon_sym_EQ,
};

static const uint32_t ts_small_parse_table_map[] = {
  [SMALL_STATE(2)] = 0,
  [SMALL_STATE(3)] = 28,
  [SMALL_STATE(4)] = 56,
  [SMALL_STATE(5)] = 75,
  [SMALL_STATE(6)] = 102,
  [SMALL_STATE(7)] = 121,
  [SMALL_STATE(8)] = 137,
  [SMALL_STATE(9)] = 153,
  [SMALL_STATE(10)] = 169,
  [SMALL_STATE(11)] = 185,
  [SMALL_STATE(12)] = 201,
  [SMALL_STATE(13)] = 224,
  [SMALL_STATE(14)] = 247,
  [SMALL_STATE(15)] = 259,
  [SMALL_STATE(16)] = 271,
  [SMALL_STATE(17)] = 289,
  [SMALL_STATE(18)] = 301,
  [SMALL_STATE(19)] = 313,
  [SMALL_STATE(20)] = 325,
  [SMALL_STATE(21)] = 340,
  [SMALL_STATE(22)] = 355,
  [SMALL_STATE(23)] = 370,
  [SMALL_STATE(24)] = 379,
  [SMALL_STATE(25)] = 388,
  [SMALL_STATE(26)] = 397,
  [SMALL_STATE(27)] = 407,
  [SMALL_STATE(28)] = 417,
  [SMALL_STATE(29)] = 427,
  [SMALL_STATE(30)] = 437,
  [SMALL_STATE(31)] = 447,
  [SMALL_STATE(32)] = 457,
  [SMALL_STATE(33)] = 467,
  [SMALL_STATE(34)] = 474,
  [SMALL_STATE(35)] = 481,
  [SMALL_STATE(36)] = 488,
  [SMALL_STATE(37)] = 493,
  [SMALL_STATE(38)] = 498,
  [SMALL_STATE(39)] = 505,
  [SMALL_STATE(40)] = 510,
  [SMALL_STATE(41)] = 514,
  [SMALL_STATE(42)] = 518,
  [SMALL_STATE(43)] = 522,
  [SMALL_STATE(44)] = 526,
  [SMALL_STATE(45)] = 530,
  [SMALL_STATE(46)] = 534,
  [SMALL_STATE(47)] = 538,
  [SMALL_STATE(48)] = 542,
  [SMALL_STATE(49)] = 546,
};

static const TSParseActionEntry ts_parse_actions[] = {
  [0] = {.entry = {.count = 0, .reusable = false}},
  [1] = {.entry = {.count = 1, .reusable = false}}, RECOVER(),
  [3] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_source_file, 0),
  [5] = {.entry = {.count = 1, .reusable = true}}, SHIFT(2),
  [7] = {.entry = {.count = 1, .reusable = false}}, SHIFT(41),
  [9] = {.entry = {.count = 1, .reusable = false}}, SHIFT(49),
  [11] = {.entry = {.count = 1, .reusable = false}}, SHIFT(22),
  [13] = {.entry = {.count = 1, .reusable = false}}, SHIFT(48),
  [15] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_source_file, 1),
  [17] = {.entry = {.count = 1, .reusable = true}}, SHIFT(3),
  [19] = {.entry = {.count = 1, .reusable = true}}, REDUCE(aux_sym_source_file_repeat1, 2),
  [21] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_source_file_repeat1, 2), SHIFT_REPEAT(3),
  [24] = {.entry = {.count = 2, .reusable = false}}, REDUCE(aux_sym_source_file_repeat1, 2), SHIFT_REPEAT(41),
  [27] = {.entry = {.count = 2, .reusable = false}}, REDUCE(aux_sym_source_file_repeat1, 2), SHIFT_REPEAT(49),
  [30] = {.entry = {.count = 2, .reusable = false}}, REDUCE(aux_sym_source_file_repeat1, 2), SHIFT_REPEAT(22),
  [33] = {.entry = {.count = 2, .reusable = false}}, REDUCE(aux_sym_source_file_repeat1, 2), SHIFT_REPEAT(48),
  [36] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_statement_block, 1),
  [38] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_statement_block, 1),
  [40] = {.entry = {.count = 1, .reusable = true}}, REDUCE(aux_sym_statement_block_repeat1, 2),
  [42] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_statement_block_repeat1, 2), SHIFT_REPEAT(5),
  [45] = {.entry = {.count = 1, .reusable = false}}, REDUCE(aux_sym_statement_block_repeat1, 2),
  [47] = {.entry = {.count = 2, .reusable = false}}, REDUCE(aux_sym_statement_block_repeat1, 2), SHIFT_REPEAT(49),
  [50] = {.entry = {.count = 2, .reusable = false}}, REDUCE(aux_sym_statement_block_repeat1, 2), SHIFT_REPEAT(22),
  [53] = {.entry = {.count = 2, .reusable = false}}, REDUCE(aux_sym_statement_block_repeat1, 2), SHIFT_REPEAT(48),
  [56] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym__expression, 1),
  [58] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym__expression, 1),
  [60] = {.entry = {.count = 1, .reusable = true}}, SHIFT(16),
  [62] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_map, 4),
  [64] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_map, 4),
  [66] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_map, 3),
  [68] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_map, 3),
  [70] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_function_call, 3),
  [72] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_function_call, 3),
  [74] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_map, 2),
  [76] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_map, 2),
  [78] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_function_call, 4),
  [80] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_function_call, 4),
  [82] = {.entry = {.count = 1, .reusable = true}}, SHIFT(4),
  [84] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_import_statement, 3),
  [86] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_import_statement, 3),
  [88] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_assignment, 3),
  [90] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_assignment, 3),
  [92] = {.entry = {.count = 1, .reusable = true}}, SHIFT(6),
  [94] = {.entry = {.count = 1, .reusable = true}}, SHIFT(9),
  [96] = {.entry = {.count = 1, .reusable = true}}, SHIFT(40),
  [98] = {.entry = {.count = 1, .reusable = true}}, SHIFT(26),
  [100] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_alias, 3),
  [102] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_alias, 3),
  [104] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_function_definition, 4),
  [106] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_function_definition, 4),
  [108] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_if_statement, 4),
  [110] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_if_statement, 4),
  [112] = {.entry = {.count = 1, .reusable = true}}, SHIFT(15),
  [114] = {.entry = {.count = 1, .reusable = true}}, SHIFT(36),
  [116] = {.entry = {.count = 1, .reusable = true}}, SHIFT(45),
  [118] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_parameters, 3),
  [120] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_parameters, 3),
  [122] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_parameters, 2),
  [124] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_parameters, 2),
  [126] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_parameters, 4),
  [128] = {.entry = {.count = 1, .reusable = false}}, REDUCE(sym_parameters, 4),
  [130] = {.entry = {.count = 1, .reusable = true}}, SHIFT(43),
  [132] = {.entry = {.count = 1, .reusable = true}}, SHIFT(10),
  [134] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_map_repeat1, 2), SHIFT_REPEAT(34),
  [137] = {.entry = {.count = 1, .reusable = true}}, REDUCE(aux_sym_map_repeat1, 2),
  [139] = {.entry = {.count = 1, .reusable = true}}, REDUCE(aux_sym_parameters_repeat1, 2),
  [141] = {.entry = {.count = 2, .reusable = true}}, REDUCE(aux_sym_parameters_repeat1, 2), SHIFT_REPEAT(46),
  [144] = {.entry = {.count = 1, .reusable = true}}, SHIFT(34),
  [146] = {.entry = {.count = 1, .reusable = true}}, SHIFT(8),
  [148] = {.entry = {.count = 1, .reusable = true}}, SHIFT(25),
  [150] = {.entry = {.count = 1, .reusable = true}}, SHIFT(46),
  [152] = {.entry = {.count = 1, .reusable = true}}, SHIFT(7),
  [154] = {.entry = {.count = 1, .reusable = true}}, SHIFT(23),
  [156] = {.entry = {.count = 1, .reusable = true}}, SHIFT(35),
  [158] = {.entry = {.count = 1, .reusable = true}}, SHIFT(32),
  [160] = {.entry = {.count = 1, .reusable = true}}, SHIFT(24),
  [162] = {.entry = {.count = 1, .reusable = true}}, REDUCE(sym_key_value, 3),
  [164] = {.entry = {.count = 1, .reusable = true}}, SHIFT(44),
  [166] = {.entry = {.count = 1, .reusable = true}}, SHIFT(11),
  [168] = {.entry = {.count = 1, .reusable = true}}, SHIFT(38),
  [170] = {.entry = {.count = 1, .reusable = true}}, SHIFT(17),
  [172] = {.entry = {.count = 1, .reusable = true}}, SHIFT(21),
  [174] = {.entry = {.count = 1, .reusable = true}}, SHIFT(42),
  [176] = {.entry = {.count = 1, .reusable = true}}, SHIFT(13),
  [178] = {.entry = {.count = 1, .reusable = true}}, SHIFT(39),
  [180] = {.entry = {.count = 1, .reusable = true}},  ACCEPT_INPUT(),
  [182] = {.entry = {.count = 1, .reusable = true}}, SHIFT(33),
  [184] = {.entry = {.count = 1, .reusable = true}}, SHIFT(20),
};

#ifdef __cplusplus
extern "C" {
#endif
#ifdef _WIN32
#define extern __declspec(dllexport)
#endif

extern const TSLanguage *tree_sitter_cyber(void) {
  static const TSLanguage language = {
    .version = LANGUAGE_VERSION,
    .symbol_count = SYMBOL_COUNT,
    .alias_count = ALIAS_COUNT,
    .token_count = TOKEN_COUNT,
    .external_token_count = EXTERNAL_TOKEN_COUNT,
    .state_count = STATE_COUNT,
    .large_state_count = LARGE_STATE_COUNT,
    .production_id_count = PRODUCTION_ID_COUNT,
    .field_count = FIELD_COUNT,
    .max_alias_sequence_length = MAX_ALIAS_SEQUENCE_LENGTH,
    .parse_table = &ts_parse_table[0][0],
    .small_parse_table = ts_small_parse_table,
    .small_parse_table_map = ts_small_parse_table_map,
    .parse_actions = ts_parse_actions,
    .symbol_names = ts_symbol_names,
    .symbol_metadata = ts_symbol_metadata,
    .public_symbol_map = ts_symbol_map,
    .alias_map = ts_non_terminal_alias_map,
    .alias_sequences = &ts_alias_sequences[0][0],
    .lex_modes = ts_lex_modes,
    .lex_fn = ts_lex,
    .primary_state_ids = ts_primary_state_ids,
  };
  return &language;
}
#ifdef __cplusplus
}
#endif
