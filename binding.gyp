{
    "targets": [
        {
            "target_name": "tree_sitter_cyber_binding",
            "include_dirs": [
                "<!(node -e \"require('nan')\")",
                "src"
            ],
            "sources": [
                "bindings/node/binding.cc",
                "src/parser.c",
                "src/scanner.cc"
            ],
            "cflags_c": [
              "-std=c99",
            ],
            ## Seeing if I can get the scanner to be Zig, as it seems appropriate.
            # "libraries": [
            #     "-l:scanner.so" #Replace 'scanner.so' with the appropriate filename for your platform
            # ],
            # "cflags!": ["-fno-exceptions"],
            # "cflags_cc!": ["-fno-exceptions"],
            # "defines": ["NAPI_EXPERIMENTAL"],
            # "xcode_settings": {
            #     "GCC_ENABLE_CPP_EXCEPTIONS": "NO",
            #     "GCC_ENABLE_CPP_RTTI": "NO",
            #     "OTHER_CFLAGS": ["-mmacosx-version-min=10.7"],
            #     "OTHER_CPLUSPLUSFLAGS": ["-mmacosx-version-min=10.7"]
            # },
            # "conditions": [
            #     ["OS=='linux'", {
            #         "ldflags": ["-static-libstdc++", "-static-libgcc"]
            #     }]
            # ]
        }
    ]
}
