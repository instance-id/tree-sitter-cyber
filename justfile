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
build_steps := './scripts/build_steps.ps1'

# --| Actions -------------------------
# --|----------------------------------

# --| Test ------------------
# --|------------------------

test run debug='no': 
  just _test-{{os()}} {{run}} {{debug}}

_test-linux run debug:
  #!{{shebang}}
  . {{build_steps}}
  RunTest {{run}} {{debug}}
 
# --| Test All ------------------
# --|----------------------------

test-all:
  #!{{shebang}}
  . {{build_steps}}
  RunTestAll

_test-windows run:
  # Do Windows Things

# --| Build -----------------
# --|------------------------

build run=script: 
  just _build-{{os()}} {{run}}

_build-linux run=script:
  #!{{shebang}}
  . {{build_steps}}
  RunBuild {{run}}
 
_build-windows:
  # Do Windows Things

# --| Build All -----------------
# --|----------------------------

build-all:
  #!{{shebang}}
  . {{build_steps}}
  RunBuildAll

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

