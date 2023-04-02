#!/usr/bin/env -S just --justfile

# --| Cross platform shebang ----------
# --|----------------------------------
shebang := if os() == 'windows' {
  'pwsh.exe'
} else {
  '/usr/bin/env pwsh'
}

set shell := ["/usr/bin/env", "pwsh" ,"-noprofile", "-nologo", "-c"]
set windows-shell := ["pwsh.exe","-NoLogo", "-noprofile", "-c"]

script := 'test_script.cy'

# --| Actions -------------------------
# --|----------------------------------

# --| Build -----------------
build run=script: 
  just _build-{{os()}} {{run}}

_build-linux run=script:
  #!{{shebang}}
  $canContinue = $true
  $path = "$PWD/src/scanner.zig"

  # echo "Building scanner: $path"
  # try{ 
  #   & /bin/bash -c  "zig build-lib ${path} --c-import-tree-sitter"
  #   $canContinue = $? 
  # }
  # catch{ echo "Failed to build scanner"; $canContinue = $false }

  echo "Can continue: $canContinue"
  try{ tree-sitter generate; $canContinue = $? }
  catch{ echo "Failed to generate parser"; $canContinue = $false }
  
  if($canContinue){
    echo "Generated parser" 

    try{ tree-sitter test; $canContinue = $? }
    catch{ echo "Failed to test parser"; $canContinue = $false }
  } else { echo "Failed to generate parser"; exit 1 }
  
  if($canContinue){
    echo "Tested parser" 

    try{ tree-sitter build-wasm; $canContinue = $? }
    catch{ echo "Failed to build wasm"; $canContinue = $false }
  } else { echo "Failed to test parser"; exit 1 }
  
  if($canContinue){
    echo "Built wasm" 

    try{ tree-sitter parse ./sample_scripts/{{run}}; $canContinue = $? }
    catch{ echo "Failed to parse sample script"; $canContinue = $false }

    if ($canContinue) { echo "Parsed sample script" }
    else { echo "Failed to parse sample script"; just update; exit 1 }

  } else { echo "Failed to build wasm"; exit 1 }

  if($canContinue){ just update } 
 
_build-windows:
  # Do Windows Things

# --| Update ----------------
update:
  just _update-{{os()}}

_update-linux:
  cp ./queries/highlights.scm ../nvim-cyber/queries/cyber/highlights.scm

_update-windows:
  # Do Windows Things

