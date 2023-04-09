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

script  := 'test_script.cy'
colors  := './scripts/color.ps1'
redCode := '#FD1C35'
greenCode := '#92B55F'
textCode := '#969696'

# --| Actions -------------------------
# --|----------------------------------

# --| Test ------------------
# --|------------------------

test run debug='no': 
  just _test-{{os()}} {{run}} {{debug}}

_test-linux run debug:
  #!{{shebang}}
  . {{colors}}
  $canContinue = $true
  Write-HostColor "Testing parser" -ForegroundColor Yellow
   
  if ('{{debug}}' -match '-debug' ) {
    $env:CYBER_TREE_SITTER_DEBUG=true 
    Write-HostColor "Debugging Enabled" -ForegroundColor Yellow
  }
  else { $env:CYBER_TREE_SITTER_DEBUG=false } 

  try{ tree-sitter test; $canContinue = $? }
  catch{ echo "Failed to test parser"; echo $_;  $canContinue = $false }
  
  if ($canContinue) { echo "Test Successful" }
  else { echo "Failed Testing"; just update; exit 1 }
  
  $testItem = "{{run}}"
  echo "Testing $testItem"
 
  try { 
     if ('{{debug}}' -match '-debug' ) { 
       $debugOut = $(& /bin/bash -c 'CYBER_TREE_SITTER_DEBUG=true tree-sitter parse {{run}} 2>&1')
       
       $debugLines = $debugOut | Select-String -Pattern "DEBUG" -AllMatches -CaseSensitive | Select-Object
       $errrorLines = $debugOut | Select-String -Pattern "ERROR" -AllMatches -CaseSensitive | Select-Object

        if($debugLines.Count -gt 0){
          $debugLines | ForEach-Object { 
            if($_ -match ".*result_symbol.*|.*STRING.*"){
               Write-HostColor $_ -ForegroundColor '{{greenCode}}' 
            } 
            else { write-hostcolor $_ -ForegroundColor '{{textCode}}'  }
          }
        }
        
        if($errrorLines.Count -gt 0){
          $errrorLines | ForEach-Object { Write-HostColor $_ -ForegroundColor '{{redCode}}' }
          $canContinue = $false
        }

     }
     else {
       tree-sitter parse {{run}}; $canContinue = $? 
     }
  }
  catch { echo "Failed to parse sample script"; echo $_; $canContinue = $false }

  if ($canContinue) { echo "Parsed sample script" }
  else { echo "Failed to Parse Sample Script"; just update; exit 1 }
  
  if ($canContinue){ just update } 

# --| Test All ------------------
# --|----------------------------

test-all:
  #!{{shebang}}
  . {{colors}}
  $canContinue = $true
  write-host "Testing parser" 
  
  try{ tree-sitter test; $canContinue = $? }
  catch{ echo "Failed to test parser"; echo $_;  $canContinue = $false }

  if ($canContinue) { write-hostcolor "Parser Test Successful`n" -ForegroundColor '{{greenCode}}' }
  else { echo "Failed Testing"; just update; exit 1 }

  write-host "Parsing Test Scripts"

  $testFolder = "/mnt/x/GitHub/fubark/cyber/test"

  $testFiles = Get-ChildItem $testFolder -Filter "*.cy" | Select-Object -ExpandProperty FullName
  $testFiles | ForEach-Object {
    try { $output = $(tree-sitter parse $_;); $canContinue = $? }
    catch { echo "Failed to parse ${_}"; echo $_; $canContinue = $false }

    if (!$canContinue ){
      $lastLine = $output.Split("\n")[-1]
      $isMissing = $lastLine.Contains("MISSING")

      if($isMissing) { $canContinue = $true }
      else { $canContinue = $false }
    }

    if ($canContinue) {
      write-hostcolor "Passed: ✓ " -ForegroundColor '{{greenCode}}' -NoNewline
      write-hostcolor "$($_)`n" -ForegroundColor '{{textCode}}' -NoNewline
    }
    else { 
      # write-host $output
      write-hostcolor "Failed: ✗ `n$($lastLine)" -ForegroundColor red 
      echo "`nFailed to Parse Sample Script"; just update; exit 1
    }
  }

  if ($canContinue){ just update }


_test-windows run:
  # Do Windows Things

# --| Build -----------------
# --|------------------------

build run=script: 
  just _build-{{os()}} {{run}}

_build-linux run=script:
  #!{{shebang}}
  . {{colors}}
  $canContinue = $true

  echo "Can continue: $canContinue"
  try{ $env:CYBER_TREE_SITTER_DEBUG=true && tree-sitter generate; $canContinue = $? }
  catch{ echo "Failed to generate parser"; $canContinue = $false }
  
  if($canContinue){
    echo "Generated parser" 

    try{ tree-sitter test; $canContinue = $? }
    catch{ echo "Failed to test parser"; $canContinue = $false }
  }
  else { echo "Failed to generate parser"; exit 1 }
  
  if($canContinue){
    echo "Tested parser" 

    try{ $output = $($env:CYBER_TREE_SITTER_DEBUG=true; tree-sitter parse {{run}};); $canContinue = $? }
    catch{ echo "Failed to parse sample script"; $canContinue = $false }

    $errorLines = $output | Select-String -Pattern "ERROR|DEBUG" -AllMatches -CaseSensitive | Select-Object 

    if($errorLines.Count -gt 0){
      $errorLines | ForEach-Object { Write-HostColor $_ -ForegroundColor '{{redCode}}' }
      $canContinue = $false
    }

    if ($canContinue) { echo "Parsed sample script" }
    else { echo "Failed to parse sample script"; just update; exit 1 }

  }
  else { echo "Failed to test parser"; exit 1 }

  if($canContinue){ just update } 
 
_build-windows:
  # Do Windows Things

# --| Build All -----------------
# --|----------------------------

build-all:
  #!{{shebang}}
  . {{colors}}
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
      catch { write-hostcolor "Failed to parse ${_}" -ForegroundColor red ; echo $_; $canContinue = $false }

      if ($canContinue) { echo "Parsed sample script" }
      else { echo "Failed to Parse Sample Script"; just update; exit 1 }
    }

  }
  else { echo "Failed to build wasm"; exit 1 }

  if($canContinue){ just update }


# --| Update ----------------
# --|------------------------

update:
  just _update-{{os()}}

_update-linux:
  cp ./queries/highlights.scm ../nvim-cyber/queries/cyber/highlights.scm
  cp ./queries/locals.scm ../nvim-cyber/queries/cyber/locals.scm
  cp ./queries/tags.scm ../nvim-cyber/queries/cyber/tags.scm

_update-windows:
  # Do Windows Things

