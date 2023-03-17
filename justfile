#!/usr/bin/env -S just --justfile

# --| Cross platform shebang ----------
# --|----------------------------------
shebang := if os() == 'windows' {
  'pwsh.exe'
} else {
  '/usr/bin/env bash'
}

set shell := ["/usr/bin/env", "bash" ,"-c"]
set windows-shell := ["pwsh.exe","-NoLogo", "-noprofile", "-c"]

# --| Actions -------------------------
# --|----------------------------------

# --| Build -----------------
build:
  just _build-{{os()}}

_build-linux:
  tree-sitter generate
  echo "Generated parser"

  tree-sitter test
  echo "Tested parser"
  
  tree-sitter build-wasm
  echo "Built wasm"

  tree-sitter parse ./sample_scripts/if_tests.cy
  echo "Parsed sample script"

_build-windows:
  # Do Windows Things

# --| Update ----------------
update:
  just _update-{{os()}}

_update-linux:
  cp ./queries/highlights.scm ../nvim-cyber/queries/cyber/highlights.scm

_update-windows:
  # Do Windows Things

