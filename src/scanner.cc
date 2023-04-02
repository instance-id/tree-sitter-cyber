#include <tree_sitter/parser.h>
#include <vector>
#include <cwctype>
#include <cstring>
#include <cassert>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

#define IS_SPACE_TABS(char) ((char) == ' ' || (char) == '\t')

namespace
{
  using std::iswspace; 
  using std::memcpy; 
  using std::vector;
  void _debug() {
    std::cerr << std::endl;
  }

  template <class T>
    void _debug(T t) {
      std::cerr << t << std::endl;
    }

  template <class T, class... Args>
    void _debug(T t, Args... args) {
      std::cerr << t;
      _debug(args...);
    }

  template <class... Args>
    void debug(Args... args) {
      if (getenv("CYBER_TREE_SITTER_DEBUG") != NULL) {
        std::cerr << std::boolalpha;
        std::cerr << "[DEBUG] ";
        _debug(args...);
      }
    }

  enum TokenType {
    SCOPE_START,
    FUNC_SCOPE_START,
    INLINE_STATEMENT,
    END_OF_STATEMENT,
    INDENT,
    DEDENT,
    NEWLINE,
    ERROR_SENTINEL,
  };

  struct Scanner {
    Scanner() {
      deserialize(NULL, 0); 
    }

    unsigned serialize(char *buffer)
    {
      size_t i = 0;

      vector<uint16_t>::iterator iter = 
        indent_length_stack.begin() + 1, 
        end = indent_length_stack.end();

      for (; iter != end && i < TREE_SITTER_SERIALIZATION_BUFFER_SIZE; ++iter) {
        buffer[i++] = *iter;
      }
      return i;
    }

    void deserialize(const char *buffer, unsigned length) {
      indent_length_stack.clear(); indent_length_stack.push_back(0);
      if (length > 0) { size_t i = 0; for (; i < length; i++) { indent_length_stack.push_back(buffer[i]); }
      }
    }

    void advance(TSLexer *lexer) { 
      lexer->advance(lexer, false); 
    }
    
    void skip(TSLexer *lexer) { 
      lexer->advance(lexer, true); 
    }

    void advance(TSLexer *lexer, bool skip) { lexer->advance(lexer, skip); }

    uint8_t consume_whitespace(TSLexer *lexer) {
      uint8_t count = 0;
      while (lexer->lookahead == ' ' || lexer->lookahead == '\t') {
        skip(lexer);
        ++count;
      }
      debug("consumed ", (int)count, " space(s)");
      return count;
    }

    void skip_space_tabs(TSLexer *lexer) {
      while (IS_SPACE_TABS(lexer->lookahead)) {
        advance(lexer, true);
      }
    }

    bool scan(TSLexer *lexer, const bool *valid_symbols)
    {
      lexer->mark_end(lexer);
      bool found_end_of_line = false;
      uint32_t indent_length = 0;
      int32_t first_comment_indent_length = -1;
      int32_t &lookahead = lexer->lookahead;
      
      debug("scan()");
      debug("col: ", lexer->get_column(lexer));
      debug("next: '", (char)lexer->lookahead, "'");

      if (lexer->eof(lexer)) {
        debug("EOF in scan");
        lexer->result_symbol = END_OF_STATEMENT;
        return true;
      }

      for (;;)
      {
        if (lexer->lookahead == '\n') {
          found_end_of_line = true;
          indent_length = 0; 
          skip(lexer); 
        }
        else if (lexer->lookahead == '\r') { 
          indent_length = 0;
          skip(lexer); 
        }
        else if (lexer->lookahead == '\t' || lexer->lookahead == ' ') { 
          indent_length += 1;
          skip(lexer); 
        }
        else if (lexer->lookahead == '\v') { 
          indent_length = 0; 
          skip(lexer); 
        }
        else if (lexer->lookahead == '\f') { 
          indent_length = 0; 
          skip(lexer); 
        }
        else if (lexer->lookahead == 0) {
          indent_length = 0;
          found_end_of_line = true; 
          break;
        }
        else { break; }
      }

      // --| Scope/Inline Statement differentiation -------
      // --|-----------------------------------------------
      if (lexer->lookahead == ':' &&
          (valid_symbols[SCOPE_START] || valid_symbols[INLINE_STATEMENT])) {
        advance(lexer);
        if (lexer->lookahead == '\n') {
          lexer->mark_end(lexer);
          advance(lexer);
          lexer->result_symbol = SCOPE_START;
          debug("result_symbol = SCOPE_START");
          return true;
        }
        else {
          lexer->mark_end(lexer);
          advance(lexer);
          lexer->result_symbol = INLINE_STATEMENT;
          debug("result_symbol = INLINE_STATEMENT");
          return true;
        }
      }

      if (found_end_of_line) {
        if (!indent_length_stack.empty()) {
          uint16_t current_indent_length = indent_length_stack.back();

          if ( valid_symbols[INDENT] && indent_length > current_indent_length) { 
            indent_length_stack.push_back(indent_length); 
            lexer->result_symbol = INDENT;
            return true; 
          }

          if (valid_symbols[DEDENT] && indent_length < current_indent_length &&
              first_comment_indent_length < (int32_t)current_indent_length) {
            indent_length_stack.pop_back(); 
            lexer->result_symbol = DEDENT; return true; 
          }
        }

        if (valid_symbols[NEWLINE] || valid_symbols[END_OF_STATEMENT]) {
          lexer->result_symbol = NEWLINE; 
          return true; 
        }
      }
      return false;
    }
    vector<uint16_t> indent_length_stack;
  };
}

extern "C"
{
  void *tree_sitter_cyber_external_scanner_create() { return new Scanner(); }
  bool tree_sitter_cyber_external_scanner_scan(void *payload, TSLexer *lexer, const bool *valid_symbols) {
    Scanner *scanner = static_cast<Scanner *>(payload); 
    return scanner->scan(lexer, valid_symbols);
  }
  unsigned tree_sitter_cyber_external_scanner_serialize(void *payload, char *buffer) { 
    Scanner *scanner = static_cast<Scanner *>(payload); 
    return scanner->serialize(buffer); 
  }
  void tree_sitter_cyber_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) { 
    Scanner *scanner = static_cast<Scanner *>(payload); 
    scanner->deserialize(buffer, length);
  }
  void tree_sitter_cyber_external_scanner_destroy(void *payload) {
    Scanner *scanner = static_cast<Scanner *>(payload); 
    delete scanner; 
  }
}
