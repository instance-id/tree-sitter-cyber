#!/usr/bin/env -S just --justfile

# --| Cross platform shebang ----------
# --|----------------------------------
shebang := if os() == 'windows' {
  'pwsh.exe'
} else {
  '/usr/bin/env -S pwsh -noprofile -nologo'
}

set shell := ["/usr/bin/env", "pwsh" ,"-noprofile", "-nologo", "-c"]
set windows-shell := ["pwsh.exe","-NoLogo", "-noprofile", "-c"]

script := 'test_script.cy'

# --| Actions -------------------------
# --|----------------------------------

# --| Test ------------------
test run: 
  just _test-{{os()}} {{run}}

_test-linux run:
  #!{{shebang}}
  $canContinue = $true
  write-host "Testing parser" -ForegroundColor Yellow
   
  try{ tree-sitter test; $canContinue = $? }
  catch{ echo "Failed to test parser"; echo $_;  $canContinue = $false }
  
  if ($canContinue) { echo "Test Successful" }
  else { echo "Failed Testing"; just update; exit 1 }
  
  $testItem = "{{run}}"
  echo "Testing $testItem"
 
  try { tree-sitter parse {{run}}; $canContinue = $? }
  catch { echo "Failed to parse sample script"; echo $_; $canContinue = $false }

  if ($canContinue) { echo "Parsed sample script" }
  else { echo "Failed to Parse Sample Script"; just update; exit 1 }
  
  if ($canContinue){ just update } 

test-all:
  #!{{shebang}}
  $canContinue = $true
  write-host "Testing parser" 
  
  try{ tree-sitter test; $canContinue = $? }
  catch{ echo "Failed to test parser"; echo $_;  $canContinue = $false }

  if ($canContinue) { write-host "Parser Test Successful`n" -ForegroundColor Green}
  else { echo "Failed Testing"; just update; exit 1 }

  write-host "Parsing Test Scripts"

  $testFolder = "./sample_scripts/tests/"
  $testFiles = Get-ChildItem $testFolder -Filter "*.cy" -Recurse | Select-Object -ExpandProperty FullName
  $testFiles | ForEach-Object {
    try { $output = $(tree-sitter parse $_;); $canContinue = $? }
    catch { echo "Failed to parse ${_}"; echo $_; $canContinue = $false }

    if (!$canContinue ){
      $lastLine = $output.Split("\n")[-1].Contains("MISSING")

      if($lastLine) { $canContinue = $true }
      else { $canContinue = $false }
    }

    if ($canContinue) {
      write-host "Passed: ------" -ForegroundColor Green
      write-host "$($_)`n"
    }
    else { 
      # write-host $output
      write-host "Failed: ------`n$($_)" -ForegroundColor Red
      echo "Failed to Parse Sample Script"; just update; exit 1
    }
  }

  if ($canContinue){ just update }


_test-windows run:
  # Do Windows Things

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
  try{ $env:CYBER_TREE_SITTER_DEBUG=true; tree-sitter generate; $canContinue = $? }
  catch{ echo "Failed to generate parser"; $canContinue = $false }
  
  if($canContinue){
    echo "Generated parser" 

    try{ tree-sitter test; $canContinue = $? }
    catch{ echo "Failed to test parser"; $canContinue = $false }
  }
  else { echo "Failed to generate parser"; exit 1 }
  
  # if($canContinue){
  #   echo "Tested parser" 
  #
  #   try { tree-sitter build-wasm; $canContinue = $? }
  #   catch { echo "Failed to build wasm"; $canContinue = $false } 
  # } 
  # else { echo "Failed to test parser"; exit 1 }
  
  if($canContinue){
    echo "Built wasm" 

    try{ tree-sitter parse {{run}}; $canContinue = $? }
    catch{ echo "Failed to parse sample script"; $canContinue = $false }

    if ($canContinue) { echo "Parsed sample script" }
    else { echo "Failed to parse sample script"; just update; exit 1 }

  }
  else { echo "Failed to build wasm"; exit 1 }

  if($canContinue){ just update } 
 
_build-windows:
  # Do Windows Things


build-all:
  #!{{shebang}}
  $canContinue = $true

  echo "Can continue: $canContinue"
  try{ $env:CYBER_TREE_SITTER_DEBUG=true; tree-sitter generate; $canContinue = $? }
  catch{ echo "Failed to generate parser"; $canContinue = $false }
  
  if($canContinue){
    echo "Generated parser" 

    try{ tree-sitter test; $canContinue = $? }
    catch{ echo "Failed to test parser"; $canContinue = $false }
  }
  else { echo "Failed to generate parser"; exit 1 }
  
  if($canContinue){
    echo "Tested parser" 

    try { tree-sitter build-wasm; $canContinue = $? }
    catch { echo "Failed to build wasm"; $canContinue = $false } 
  } 
  else { echo "Failed to test parser"; exit 1 }
  
  if($canContinue){
    echo "Built wasm" 

    $testFolder = "./sample_scripts/tests/"
    $testFiles = Get-ChildItem $testFolder -Filter "*.cy" -Recurse | Select-Object -ExpandProperty FullName
    $testFiles | ForEach-Object {
      try { tree-sitter parse $_; $canContinue = $? }
      catch { echo "Failed to parse ${_}"; echo $_; $canContinue = $false }

      if ($canContinue) { echo "Parsed sample script" }
      else { echo "Failed to Parse Sample Script"; just update; exit 1 }
    }

  }
  else { echo "Failed to build wasm"; exit 1 }

  if($canContinue){ just update }


# --| Update ----------------
update:
  just _update-{{os()}}

_update-linux:
  cp ./queries/highlights.scm ../nvim-cyber/queries/cyber/highlights.scm
  cp ./queries/locals.scm ../nvim-cyber/queries/cyber/locals.scm
  cp ./queries/tags.scm ../nvim-cyber/queries/cyber/tags.scm

_update-windows:
  # Do Windows Things

