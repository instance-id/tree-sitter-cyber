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
            } 
            // else if (lexer.lookahead == 'f') {
            //     indent_length = 0;
            //     self.skip(lexer);
            // } 
            else if (lexer.lookahead == 0) {
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
                if (valid_symbols[TokenType.INDENT] and indent_length > current_indent_length) {
                    self.indent_length_stack.push(indent_length);
                    lexer.result_symbol = TokenType.INDENT;
                    return true;
                }
                if (valid_symbols[TokenType.DEDENT] and indent_length < current_indent_length and first_comment_indent_length < current_indent_length) {
                    self.indent_length_stack.pop();
                    lexer.result_symbol = TokenType.DEDENT;
                    return true;
                }
            }
            if (valid_symbols[TokenType.NEWLINE]) {
                lexer.result_symbol = TokenType.NEWLINE;
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



// const std = @import("std");
// const mem = std.mem;
// const Allocator = std.mem.Allocator;
// const c = @import("c.zig");
// const TSLexer = c.TSLexer;

// const TokenType = enum {
//     NEWLINE,
//     INDENT,
//     DEDENT,
// };

// const Scanner = struct {
//     indent_length_stack: std.ArrayList(u16),

//     pub fn create(allocator: *Allocator) !*Scanner {
//         var scanner = try allocator.create(Scanner);
//         try scanner.indent_length_stack.initCapacity(allocator, 1);
//         scanner.indent_length_stack.appendAssumeCapacity(0);
//         return scanner;
//     }

//     pub fn serialize(self: Scanner, buffer: []u8) u32 {
//         var i: u32 = 0;
//         for (self.indent_length_stack[1..]) |indent_length| {
//             if (i >= 1024) break;
//             buffer[i] = indent_length;
//             i += 1;
//         }
//         return i;
//     }

//     pub fn deserialize(self: *Scanner, buffer: []const u8, length: u32) void {
//         self.indent_length_stack = []u16{0};
//         if (length > 0) {
//             var i: u32 = 0;
//             while (i < length) : (i += 1) {
//                 self.indent_length_stack.push(buffer[i]);
//             }
//         }
//     }

//     pub fn destroy(scanner: *Scanner) void {
//         scanner.indent_length_stack.deinit();
//     }

//     fn advance(lexer: *TSLexer, skip: bool) void {
//         lexer.advance(lexer, skip);
//     }

//     fn mark_end(lexer: *TSLexer) void {
//         lexer.mark_end(lexer);
//     }

//     fn lookahead(lexer: *TSLexer) u8 {
//         return lexer.lookahead(lexer);
//     }

//     pub fn scan(scanner: *Scanner, lexer: *TSLexer, valid_symbols: [*]const bool) bool {
//         scanner.mark_end(lexer);

//         var found_end_of_line = false;
//         var indent_length: u32 = 0;
//         var first_comment_indent_length: i32 = -1;
//         while (true) {
//             const la = scanner.lookahead(lexer);
//             switch (la) {
//                 '\n' => {
//                     found_end_of_line = true;
//                     indent_length = 0;
//                     scanner.advance(lexer, true);
//                 },
//                 '\r' => {
//                     indent_length = 0;
//                     scanner.advance(lexer, true);
//                 },
//                 ' ' => {
//                     indent_length = 0;
//                     scanner.advance(lexer, true);
//                 },
//                 ' ' => {
//                     indent_length += 1;
//                     scanner.advance(lexer, true);
//                 },
//                 '\t' => {
//                     indent_length += 1;
//                     scanner.advance(lexer, true);
//                 },
//                 0 => {
//                     indent_length = 0;
//                     found_end_of_line = true;
//                     break;
//                 },
//                 else => break,
//             }
//         }

//         if (found_end_of_line) {
//             if (scanner.indent_length_stack.len > 0) {
//                 const current_indent_length = scanner.indent_length_stack.items[scanner.indent_length_stack.len - 1];

//                 if (valid_symbols[TokenType.INDENT] and indent_length > current_indent_length) {
//                     scanner.indent_length_stack.append(indent_length);
//                     return TokenType.INDENT;
//                 }

//                 if (valid_symbols[TokenType.DEDENT] and indent_length < current_indent_length and first_comment_indent_length < @intCast(i32, current_indent_length)) {
//                     _ = scanner.indent_length_stack.pop();
//                     return TokenType.DEDENT;
//                 }
//             }

//             if (valid_symbols[TokenType.NEWLINE]) {
//                 return TokenType.NEWLINE;
//             }
//         }

//         return false;
//     }
// };



// // pub export fn tree_sitter_cyber_external_scanner_create() ?*c_void
// // {
// //     return try std.heap.c_allocator.create(Scanner);
// // }

// // pub export fn tree_sitter_cyber_external_scanner_scan(payload: ?*c_void, lexer: *TSLexer, valid_symbols: [*]const bool) bool
// // {
// //     const scanner = @intToPtr(?*Scanner, payload);
// //     return scanner.?.scan(lexer, valid_symbols);
// // }

// // pub export fn tree_sitter_cyber_external_scanner_destroy(payload: ?*c_void) void
// // {
// //     const scanner = @intToPtr(?*Scanner, payload);
// //     std.heap.c_allocator.destroy(scanner.?);
// // }

// pub export fn tree_sitter_cyber_external_scanner_serialize(payload: void, buffer: [*]const u8) u32
// {
//     const scanner = @intToPtr(?*Scanner, payload);
//     return scanner.?.serialize(buffer);
// }

// pub export fn tree_sitter_cyber_external_scanner_deserialize(payload: void, buffer: [*]const u8, length: u32) void
// {
//     const scanner = @intToPtr(?*Scanner, payload);
//     scanner.?.deserialize(buffer, length);
// }

// pub export fn tree_sitter_cyber_external_scanner_create() callconv(.C) void {
//     const allocator = std.heap.page_allocator;
//     return @ptrCast(void, Scanner.create(allocator) catch  null);
// }

// export fn tree_sitter_cyber_external_scanner_scan(payload: void, lexer: *TSLexer, valid_symbols: []const bool) bool {
//     const scanner = @ptrCast(*Scanner, payload);
//     return Scanner.scan(scanner, lexer, valid_symbols);
// }

// pub export fn tree_sitter_cyber_external_scanner_destroy(payload: void) callconv(.C) void {
//     const scanner = @ptrCast(*Scanner, payload);
//     Scanner.destroy(scanner);
// }