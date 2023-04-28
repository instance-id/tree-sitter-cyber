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
    OBJECT_SCOPE_START,
    OBJECT_DECLARATION,
    TYPE_FIELD,
    TYPE_ALIAS,
    INLINE_STATEMENT,
    END_OF_STATEMENT,
    INDENT,
    DEDENT,
    NEWLINE,
    COMMENT,
    SCOPE_END,
    STRING_START,
    STRING_CONTENT,
    STRING_END,
    TRIPLE_QUOTE_START,
    TRIPLE_QUOTE_END,
    CLOSE_PAREN,
    CLOSE_BRACKET,
    CLOSE_BRACE,
    COLON,
    ERROR_SENTINEL,
  };

  struct Delimiter {
    enum {
      SingleQuote = 1 << 0,
      DoubleQuote = 1 << 1,
      Triple      = 1 << 2,
      Multiline   = 1 << 3,
    };

    Delimiter() : flags(0) {}

    bool is_triple() const { return flags & Triple; }
    bool is_multiline() const { return flags & Multiline; }

    int32_t end_character() const {
      if (flags & SingleQuote) return '\'';
      if (flags & DoubleQuote) return '"';
      return 0;
    }

    void set_triple() { flags |= Triple; }
    void set_multiline() { flags |= Multiline; }

    void set_end_character(int32_t character) {
      switch (character) {
        case '\'':
          flags |= SingleQuote;
          break;
        case '"':
          flags |= DoubleQuote;
          break;
        default:
          assert(false);
      }
    }

    char flags;
  };

  struct Scanner {
    Scanner()
    {
      assert(sizeof(Delimiter) == sizeof(char));
      deserialize(NULL, 0); 
    }

    unsigned serialize(char *buffer)
    {
      size_t i = 0;

      size_t delimiter_count = delimiter_stack.size();
      if (delimiter_count > UINT8_MAX) delimiter_count = UINT8_MAX;
      buffer[i++] = delimiter_count;

      if (delimiter_count > 0) {
        memcpy(&buffer[i], delimiter_stack.data(), delimiter_count);
      }
      i += delimiter_count;

      vector<uint16_t>::iterator
        iter = indent_length_stack.begin() + 1,
             end = indent_length_stack.end();

      for (; iter != end && i < TREE_SITTER_SERIALIZATION_BUFFER_SIZE; ++iter) {
        buffer[i++] = *iter;
      }

      return i;
    }

    void deserialize(const char *buffer, unsigned length)
    {
      delimiter_stack.clear();
      indent_length_stack.clear();
      indent_length_stack.push_back(0);

      if (length > 0) {
        size_t i = 0;

        size_t delimiter_count = (uint8_t)buffer[i++];
        delimiter_stack.resize(delimiter_count);

        if (delimiter_count > 0) {
          memcpy(delimiter_stack.data(), &buffer[i], delimiter_count);
        }

        i += delimiter_count;

        for (; i < length; i++) {
          indent_length_stack.push_back(buffer[i]);
        }
      }
    }

    void advance(TSLexer *lexer) { lexer->advance(lexer, false); }
    void skip(TSLexer *lexer) { lexer->advance(lexer, true); }
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
      int32_t &lookahead = lexer->lookahead;

      debug("scan()");
      debug("col: ", lexer->get_column(lexer));
      debug("next: '", (char)lexer->lookahead, "'");

      consume_whitespace(lexer);
      if (lexer->eof(lexer)) {
        debug("EOF in scan");
        lexer->result_symbol = END_OF_STATEMENT;
        return true;
      }

      bool error_recovery_mode = ((valid_symbols[STRING_CONTENT] && valid_symbols[INDENT]));
      bool sentinel_active = valid_symbols[ERROR_SENTINEL];

      bool within_brackets = valid_symbols[CLOSE_BRACE] 
        || valid_symbols[CLOSE_PAREN] 
        || valid_symbols[CLOSE_BRACKET];

      // --| Multiline String -------------- 
      // --| Inspired by Python Scanner ----
      if (valid_symbols[STRING_CONTENT] && !delimiter_stack.empty() && !error_recovery_mode) {
        Delimiter delimiter = delimiter_stack.back();
        int32_t end_character = delimiter.end_character();

        if (end_character == '"'){
          delimiter.set_multiline();
        } else if (end_character == '\'') {
          delimiter.set_triple();
        }

        debug("end_character: ", (char)end_character);
        debug("is_triple: ", delimiter.is_triple());
        debug("is_multiline: ", delimiter.is_multiline());
        bool has_content = false;

        while (lexer->lookahead) {
          if (lexer->lookahead == end_character) {
            if (delimiter.is_triple()) {
              lexer->mark_end(lexer);
              lexer->advance(lexer, false);

              if (lexer->lookahead == end_character) {
                lexer->advance(lexer, false);

                if (lexer->lookahead == end_character) {
                  if (has_content) {
                    lexer->result_symbol = STRING_CONTENT;
                    debug("result_symbol = STRING_CONTENT");
                    is_multiline_string = true;
                  } else {
                    lexer->advance(lexer, false);
                    lexer->mark_end(lexer);
                    delimiter_stack.pop_back();
                    lexer->result_symbol = STRING_END;
                    debug("result_symbol = TRIPLE_QUOTE_END - TRIPLE ------------");
                  }
                  return true;
                } else {
                  lexer->mark_end(lexer);
                  lexer->result_symbol = STRING_CONTENT;
                  debug("result_symbol = STRING_CONTENT");
                  is_multiline_string = true;
                  return true;
                }
              } else {
                lexer->mark_end(lexer);
                lexer->result_symbol = STRING_CONTENT;
                debug("result_symbol = STRING_CONTENT");
                is_multiline_string = true;
                return true;
              }
            } else if (delimiter.is_multiline()){
              lexer->mark_end(lexer);
              lexer->advance(lexer, false);

              if (has_content) {
                lexer->result_symbol = STRING_CONTENT;
                debug("result_symbol = STRING_CONTENT");
                is_multiline_string = true;
              } else {
                lexer->mark_end(lexer);
                lexer->advance(lexer, false);
                delimiter_stack.pop_back();
                lexer->result_symbol = STRING_END;
                debug("result_symbol = STRING_END  ------------");
                is_multiline_string = false;
              }

              /* lexer->mark_end(lexer); */
              return true;
            } 
            else {
              if (has_content) {
                lexer->result_symbol = STRING_CONTENT;
                debug("result_symbol = STRING_CONTENT  ------------");
                is_multiline_string = true;
              } else {
                lexer->advance(lexer, false);
                delimiter_stack.pop_back();
                lexer->result_symbol = STRING_END;
                debug("result_symbol = STRING_END ---------------------");
                is_multiline_string = false;
              }

              lexer->mark_end(lexer);
              return true;
            }
          } else if (lexer->lookahead == '\n' 
              && has_content 
              && (!delimiter.is_triple() && !delimiter.is_multiline())) {
            debug("STRING CONTENT - NEWLINE");
            is_multiline_string = true;
            return false;
          }

          advance(lexer);
          has_content = true;
          is_multiline_string = true;
          debug("STRING CONTENT - LOOP -- Multiline: ", delimiter.is_multiline(), " Triple: ", delimiter.is_triple());
        }
      }

      lexer->mark_end(lexer);
      bool found_end_of_line = false;
      uint32_t indent_length = 0;
      int32_t first_comment_indent_length = -1;

      // --| Indentation -------------------
      // --|--------------------------------
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
        else if (lexer->lookahead == ' ') { 
          indent_length += 1;
          skip(lexer); 
        }
        else if (lexer->lookahead == '\t') {
          indent_length += 8;
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

      // --| Scope/Inline Statement --------
      // --|--------------------------------
      if (lexer->lookahead == ':' && (valid_symbols[SCOPE_START] || valid_symbols[INLINE_STATEMENT])
          /* && !error_recovery_mode */
         ) {
        advance(lexer);
        consume_whitespace(lexer);
        if (lexer->lookahead == '\n') {
          lexer->mark_end(lexer);
          skip(lexer);
          lexer->result_symbol = SCOPE_START;
          debug("result_symbol = SCOPE_START : Second");
          return true;
        } else {
          lexer->mark_end(lexer);
          advance(lexer);
          lexer->result_symbol = INLINE_STATEMENT;
          debug("result_symbol = INLINE_STATEMENT : Second");
          return true;
        }
      }
      else if(
          valid_symbols[TYPE_ALIAS] && lexer->lookahead == 't' && !valid_symbols[OBJECT_DECLARATION]){
        lexer->mark_end(lexer);
        advance(lexer);
        lexer->result_symbol = TYPE_ALIAS;
        debug("result_symbol = TYPE_ALIAS : First");
        return true;
      }
      else if (valid_symbols[END_OF_STATEMENT]) {
        advance(lexer);
        lexer->result_symbol = END_OF_STATEMENT;
        debug("result_symbol = END_OF_STATEMENT");
        return true;
      }

      else if (valid_symbols[SCOPE_END]) {
        advance(lexer);
        lexer->result_symbol = SCOPE_END;
        debug("result_symbol = SCOPE_END");
        return true;
      } 
      else { is_type_field = false; }

      if (found_end_of_line) {
        if (!indent_length_stack.empty()) {
          uint16_t current_indent_length = indent_length_stack.back();

          if (valid_symbols[INDENT] && indent_length > current_indent_length) { 
            indent_length_stack.push_back(indent_length); 
            lexer->result_symbol = INDENT;
            debug("result_symbol = INDENT");

            return true; 
          }

          if ((valid_symbols[DEDENT] || (!valid_symbols[NEWLINE] && !within_brackets))
              && indent_length < current_indent_length
              && first_comment_indent_length < (int32_t)current_indent_length) 
          {
            indent_length_stack.pop_back(); 
            lexer->result_symbol = DEDENT;
            debug("result_symbol = DEDENT");
            return true; 
          }
        }

        if ((valid_symbols[NEWLINE] || valid_symbols[END_OF_STATEMENT]) && !error_recovery_mode) {
          lexer->result_symbol = NEWLINE; 
          debug("result_symbol = NEWLINE");
          return true; 
        }
      }

      // --| Begin String ------------------
      // --|--------------------------------
      if (first_comment_indent_length == -1 && (valid_symbols[STRING_START] || valid_symbols[TRIPLE_QUOTE_START])) 
      {
        bool has_flags = false;
        Delimiter delimiter;

        if (lexer->lookahead == '\'') {
          advance(lexer);
          if (lexer->lookahead == '\'') {
            advance(lexer);
            if (lexer->lookahead == '\'') {
              advance(lexer);
              debug("STRING: SINGLE_QUOTE: set_triple -------");
              delimiter.set_end_character('\'');
              lexer->mark_end(lexer);
              delimiter.set_triple();
            }
          }
        } 
        else if (lexer->lookahead == '"') 
        {
          delimiter.set_end_character('"');
          advance(lexer);
          lexer->mark_end(lexer);
          delimiter.is_multiline();
          debug("STRING: DOUBLE_QUOTE IS MULTILINE ------------------- ");
        }

        if (delimiter.end_character())
        {
          delimiter_stack.push_back(delimiter);
          lexer->result_symbol = STRING_START;
          debug("result_symbol = STRING_START  ------------");
          is_multiline_string = true;
          return true;
        }
        else if (has_flags) 
        {
          return false;
        }
      }

      return false;
    }

    bool is_type_field;
    const char SINGLE_QUOTE = '\'';
    const char DOUBLE_QUOTE = '"';
    bool is_multiline_string;
    vector<uint16_t> indent_length_stack; 
    vector<Delimiter> delimiter_stack;
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
