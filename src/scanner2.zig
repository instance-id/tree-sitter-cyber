const std = @import("std");
const builtin = @import("builtin");
const assert = std.debug.assert;
const c = @import("c.zig");
const TSLexer = c.TSLexer;
usingnamespace std;

const TokenType = enum {
    NEWLINE,
    INDENT,
    DEDENT,
};

pub const Scanner = struct {
    indent_length_stack: []u16,

    pub fn init() Scanner {
        return Scanner{ .indent_length_stack = []u16{0} };
    }

    pub fn serialize(self: Scanner, buffer: []u8) u32 {
        var i: u32 = 0;
        for (self.indent_length_stack[1..]) |indent_length| {
            if (i >= 1024) break;
            buffer[i] = indent_length;
            i += 1;
        }
        return i;
    }

    pub fn deserialize(self: *Scanner, buffer: []const u8, length: u32) void {
        self.indent_length_stack = []u16{0};
        if (length > 0) {
            var i: u32 = 0;
            while (i < length) : (i += 1) {
                self.indent_length_stack.push(buffer[i]);
            }
        }
    }

    pub fn advance(lexer: *builtin.TSLexer) void {
        lexer.advance(lexer, false);
    }

    pub fn skip(lexer: *builtin.TSLexer) void {
        lexer.advance(lexer, true);
    }

    pub fn scan(self: Scanner, lexer: *builtin.TSLexer, valid_symbols: []const bool) bool {
        lexer.mark_end(lexer);
        var found_end_of_line: bool = false;
        var indent_length: u32 = 0;
        var first_comment_indent_length: i32 = -1;
        while (true) {
            if (lexer.lookahead == '\n') {
                found_end_of_line = true;
                indent_length = 0;
                self.skip(lexer);
            } else if (lexer.lookahead == '\r') {
                indent_length = 0;
                self.skip(lexer);
            } else if (lexer.lookahead == '\t') {
                indent_length += 1;
                self.skip(lexer);
            } else if (lexer.lookahead == '\f') {
                indent_length = 0;
                self.skip(lexer);
            } else if (lexer.lookahead == 0) {
                indent_length = 0;
                found_end_of_line = true;
                break;
            } else {
                break;
            }
        }

        if (found_end_of_line) {
            if (self.indent_length_stack.len > 0) {
                const current_indent_length = self.indent_length_stack[self.indent_length_stack.len - 1];
                if (valid_symbols[INDENT] and indent_length > current_indent_length) {
                    self.indent_length_stack.push(indent_length);
                    lexer.result_symbol = INDENT;
                    return true;
                }
                if (valid_symbols[DEDENT] and indent_length < current_indent_length and first_comment_indent_length < current_indent_length) {
                    self.indent_length_stack.pop();
                    lexer.result_symbol = DEDENT;
                    return true;
                }
            }
            if (valid_symbols[NEWLINE]) {
                lexer.result_symbol = NEWLINE;
                return true;
            }
        }
        return false;
    }
};

pub export fn tree_sitter_cyber_external_scanner_serialize(payload: void, buffer: [*]const u8) u32
{
    const scanner = @intToPtr(?*Scanner, payload);
    return scanner.?.serialize(buffer);
}

pub export fn tree_sitter_cyber_external_scanner_deserialize(payload: void, buffer: [*]const u8, length: u32) void
{
    const scanner = @intToPtr(?*Scanner, payload);
    scanner.?.deserialize(buffer, length);
}

pub export fn tree_sitter_cyber_external_scanner_create() callconv(.C) void {
    const allocator = std.heap.page_allocator;
    return @ptrCast(void, Scanner.create(allocator) catch  null);
}

export fn tree_sitter_cyber_external_scanner_scan(payload: void, lexer: *TSLexer, valid_symbols: []const bool) bool {
    const scanner = @ptrCast(*Scanner, payload);
    return Scanner.scan(scanner, lexer, valid_symbols);
}

pub export fn tree_sitter_cyber_external_scanner_destroy(payload: void) callconv(.C) void {
    const scanner = @ptrCast(*Scanner, payload);
    Scanner.destroy(scanner);
}