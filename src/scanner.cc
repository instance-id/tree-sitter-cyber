#include "tree_sitter/parser.h"
#include <stdio.h>

#include <algorithm>
#include <cassert>
#include <cstring>
#include <cwctype>
#include <iostream>
#include <string>
#include <vector>

enum TokenType { INDENT, DEDENT, NEWLINE, LINE };

struct Scanner {
  uint32_t prev_indent = 0;
};

extern "C" {
  void *tree_sitter_cyber_external_scanner_create() {
    return new Scanner(); 
  }

  void tree_sitter_cyber_external_scanner_destroy(void *payload) {
    delete static_cast<Scanner *>(payload);
  }

  unsigned tree_sitter_cyber_external_scanner_serialize(void *payload, char *buffer) {
    char *start = buffer;
    const Scanner *state = static_cast<Scanner *>(payload);

    auto curr = std::to_string(state->prev_indent);
    memcpy(buffer, curr.c_str(), curr.size());
    buffer += curr.size();

    return buffer - start;
  }

  void tree_sitter_cyber_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) {
    Scanner *state = static_cast<Scanner *>(payload);
    const char *end = buffer + length;

    if (length == 0) {
      *state = {};
      return;
    }

    state->prev_indent = std::stoi(std::string(buffer, end));
  }

  bool tree_sitter_cyber_external_scanner_scan(void *payload, TSLexer *lexer,
      const bool *valid_symbols) {

    if (!lexer->lookahead) {
      lexer->mark_end(lexer);
      return false;
    }

    Scanner *state = static_cast<Scanner *>(payload);
    int32_t &lookahead = lexer->lookahead;
    TSSymbol &result_symbol = lexer->result_symbol;
    auto advance = [lexer] { lexer->advance(lexer, false); };
    auto skip = [lexer] { lexer->advance(lexer, true); };
    void (*mark_end)(TSLexer *) = lexer->mark_end;
    auto get_column = [lexer] { return lexer->get_column(lexer); };
    bool (*is_at_included_range_start)(const TSLexer *) =
      lexer->is_at_included_range_start;

    if (valid_symbols[NEWLINE]) {
      bool escape = false;
      if (lookahead == '\\') {
        escape = true;
        skip();
      }

      bool eol = false;
      while (lookahead == '\n' || lookahead == '\r') {
        eol = true;
        skip();
      }
      if (eol && !escape) {
        result_symbol = NEWLINE;
        return true;
      }
    }

    if (valid_symbols[INDENT] || valid_symbols[DEDENT]) {
      while (std::iswspace(lookahead)) {
        switch (lookahead) {
          case '\n':
            return false;

          case '\t':
          case ' ':
            skip();
            break;
        }
      }

      auto indent = get_column();
      if (indent > state->prev_indent && valid_symbols[INDENT] &&
          state->prev_indent == 0) {
        result_symbol = INDENT;
        state->prev_indent = indent;
        return true;
      } else if (indent < state->prev_indent && valid_symbols[DEDENT] &&
          indent == 0) {
        result_symbol = DEDENT;
        state->prev_indent = indent;
        return true;
      }
    }

    return false;
  }
}
