const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const scanner = b.addSharedLibrary(.{
        .name = "scanner",
        .root_source_file = .{ .path = "src/scanner.zig" },
        .target = target,
        .optimize = optimize,
    });

    // scanner.setTarget(target);
    // scanner.setBuildMode(b.release_mode);
    // scanner.src_files = &[_][]const u8{"scanner.zig"};
    scanner.linkLibC();
    scanner.linkSystemLibrary("c");

    // Add this line to link the Rust-generated Tree-sitter
    // Add these lines to link the Rust-generated Tree-sitter dynamic library
    scanner.linkSystemLibrary("tree_sitter");
    scanner.addIncludePath("src/tree-sitter");
    scanner.addLibraryPath("src/");

    scanner.install();
}
