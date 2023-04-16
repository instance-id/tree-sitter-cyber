
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingCmdletAliases', '')]

param()

# --| Imports --------------------
# --|-----------------------------
$current = $PSScriptRoot
. "${current}/color.ps1"

$redCode   = '#FD1C35'
$greenCode = '#92B55F'
$textCode  = '#969696'
$yellowCode= '#E8DA5E'

# --| Tests ----------------------
# --|-----------------------------
function RunTest(){
  param(
    [string]$testScript,
    [switch]$debug
  )

  wl-copy $testScript
  
  $canContinue = $true
  Write-HostColor "Testing parser" -ForegroundColor $yellowCode
   
  if ($debug) {
    $env:CYBER_TREE_SITTER_DEBUG=true 
    Write-HostColor "Debugging Enabled" -ForegroundColor $yellowCode
  }
  else { $env:CYBER_TREE_SITTER_DEBUG=false } 

  try{ tree-sitter test; $canContinue = $? }
  catch{ write-hostcolor "Failed to test parser" -foregroundcolor red; echo $_;  $canContinue = $false }
  
  if ($canContinue) { write-hostcolor "Test Successful" -ForegroundColor $greenCode }
  else { write-hostcolor "Failed Testing" -foregroundcolor red; just update; exit 1 }
  
  write-hostcolor "Testing $testScript" -ForegroundColor $yellowCode
 
  try { 
    if ($debug) { 
      $debugOut = $(& /bin/bash -c "CYBER_TREE_SITTER_DEBUG=true tree-sitter parse $testScript 2>&1")

        $debugLines = $debugOut | Select-String -Pattern "DEBUG" -AllMatches -CaseSensitive | Select-Object
        $errrorLines = $debugOut | Select-String -Pattern "ERROR" -AllMatches -CaseSensitive | Select-Object

        if($debugLines.Count -gt 0){
          $debugLines | ForEach-Object { 
            if($_ -match ".*result_symbol.*|.*STRING.*"){
              write-hostcolor $_ -foregroundcolor $greencode 
            } 
            else { write-hostcolor $_ -foregroundcolor $textcode  }
          }
        }

      if($errrorLines.Count -gt 0){
        $errrorlines | foreach-object { write-hostcolor $_ -foregroundcolor red }
        $canContinue = $false
      }

    }
    else {
      tree-sitter parse $testScript; $canContinue = $? 
    }
  }
  catch { write-hostcolor "Failed to parse sample script" -foregroundcolor red; echo $_; $canContinue = $false }

  if ($canContinue) { write-hostcolor "Parsed sample script" -foregroundcolor $greenCode }
  else { write-hostcolor "Failed to Parse Sample Script" -foregroundcolor red; just update; exit 1 }

  if ($canContinue){ just update }
}

# --| Test All -------------------
# --|-----------------------------
function RunTestAll(){
  param(
    [string]$addEndNewline = 'false'
  )

  $canContinue = $true
  write-hostcolor "Testing parser" -ForegroundColor $yellowCode
  
  try{ tree-sitter test; $canContinue = $? }
  catch{ write-hostcolor "Failed to test parser" -foregroundcolor red; echo $_;  $canContinue = $false }

  if ($canContinue) { write-hostcolor "Parser Test Successful`n" -ForegroundColor $greenCode }
  else { write-hostcolor "Failed Testing" -foregroundcolor red; just update; exit 1 }

  write-hostcolor "Parsing Test Scripts" -ForegroundColor $yellowCode

  $testFolder = "/mnt/x/GitHub/fubark/cyber/test"

  $testFiles = Get-ChildItem $testFolder -Filter "*.cy" | Select-Object -ExpandProperty FullName
  $testFiles | ForEach-Object {
    if ($addEndNewline -match 'true') { Add-Content $_ "`n" }

    try { $output = $(tree-sitter parse $_;); $canContinue = $? }
    catch { write-hostcolor "Failed to parse ${_}" -foregroundcolor red; echo $_; $canContinue = $false }

    if (!$canContinue ){
      $lastLine = $output.Split("\n")[-1]
      $isMissing = $lastLine.Contains("MISSING")

      if($isMissing) { $canContinue = $true }
      else { $canContinue = $false }
    }

    if ($canContinue) {
      write-hostcolor "Passed: ✓ " -ForegroundColor $greenCode -NoNewline
      write-hostcolor "$($_)`n" -ForegroundColor $textCode -NoNewline
    }
    else { 
      write-hostcolor "Failed: ✗ `n$($lastLine)" -ForegroundColor red 
      write-hostcolor "`nFailed to Parse Sample Script" -foregroundcolor red; 
      wl-copy $lastLine.split("	")[0]
      just update; 
      exit 1
    }
  }

  if ($canContinue){ 
    write-hostcolor "✓✓ All Tests Passed ✓✓" -ForegroundColor $greenCode
    just update 
  }
}

# --| Build ----------------------
# --|-----------------------------
function RunBuild(){
  param(
    [string]$scriptPath
  )

  wl-copy $scriptPath
  $canContinue = $true

  try{ $env:CYBER_TREE_SITTER_DEBUG=true && tree-sitter generate; $canContinue = $? }
  catch{ write-hostcolor "Failed to generate parser" -foregroundcolor red; $canContinue = $false }
  
  if($canContinue){
    write-hostcolor "Generated parser" -foregroundcolor $greenCode 

    try{ tree-sitter test; $canContinue = $? }
    catch{ write-hostcolor "Failed to test parser" -foregroundcolor red; $canContinue = $false }
  }
  else { write-hostcolor "Failed to generate parser" -foregroundcolor red; exit 1 }
  
  if($canContinue){
    write-hostcolor "Tested parser" -foregroundcolor $greenCode 

    try{ $output = $($env:CYBER_TREE_SITTER_DEBUG=true; tree-sitter parse $scriptPath;); $canContinue = $? }
    catch{ write-hostcolor "Failed to parse sample script" -foregroundcolor red; $canContinue = $false }

    $errorLines = $output | Select-String -Pattern "ERROR|DEBUG" -AllMatches -CaseSensitive | Select-Object 

    if($errorLines.Count -gt 0){
      $errorLines | ForEach-Object { Write-HostColor $_ -ForegroundColor red }
      $canContinue = $false
    }

    if ($canContinue) { write-hostcolor "Parsed sample script" -foregroundcolor $greenCode }
    else { write-hostcolor "Failed to parse sample script" -foregroundcolor red; just update; exit 1 }

  }
  else { write-hostcolor "Failed to test parser" -foregroundcolor red; exit 1 }

  if($canContinue){ just update } 
}

# --| Build All ------------------
# --|-----------------------------
function RunBuildAll(){
  $canContinue = $true

  try{ $env:CYBER_TREE_SITTER_DEBUG=true; tree-sitter generate; $canContinue = $? }
  catch{ write-hostcolor "Failed to generate parser" -foregroundcolor red; $canContinue = $false }
  
  if($canContinue){
    write-hostcolor "Generated parser" -foregroundcolor $greenCode 

    try{ tree-sitter test; $canContinue = $? }
    catch{ write-hostcolor "Failed to test parser" -foregroundcolor red; $canContinue = $false }
  }
  else { write-hostcolor "Failed to generate parser" -foregroundcolor red; exit 1 }
  
  if($canContinue){
    write-hostcolor "Tested parser" -foregroundcolor $greenCode 

    try { tree-sitter build-wasm; $canContinue = $? }
    catch { write-hostcolor "Failed to build wasm" -foregroundcolor red; $canContinue = $false } 
  } 
  else { write-hostcolor "Failed to test parser" -foregroundcolor red; exit 1 }
  
  if($canContinue){
    write-hostcolor "Built wasm" -foregroundcolor $greenCode 

    $testFolder = "./sample_scripts/tests/"
    $testFiles = Get-ChildItem $testFolder -Filter "*.cy" -Recurse | Select-Object -ExpandProperty FullName
    $testFiles | ForEach-Object {
      try { tree-sitter parse $_; $canContinue = $? }
      catch { write-hostcolor "Failed to parse ${_}" -ForegroundColor red; $canContinue = $false }

      if ($canContinue) { write-hostcolor "Parsed sample script" -foregroundcolor $greenCode }
      else { write-hostcolor "Failed to Parse Sample Script" -foregroundcolor red; just update; exit 1 }
    }

  }
  else { write-hostcolor "Failed to build wasm" -foregroundcolor red ; exit 1 }

  if($canContinue){ just update }
}
