$Script:defaultColors = @{
  Black  = "#0c0c0c";
  DarkBlue	= "#0037da";
  DarkGreen	= "#13a10e";
  DarkCyan	= "#3a96dd";
  DarkRed		= "#c50f1f";
  DarkMagenta	= "#891798";
  DarkYellow	= "#c19a00";
  Gray		= "#cccccc";
  DarkGray	= "#767676";
  Blue		= "#3b79ff";
  Green		= "#16c60c";
  Cyan		= "#61d6d6";
  Red			= "#e74856";
  Magenta		= "#b4009f";
  Yellow		= "#f9f1a5";
  White		= "#f2f2f2";
};

function ConvertFrom-Hex {
  param(
      [Parameter(Mandatory = $true, Position = 1)] [string] $Color
      )

  if ($Color -in $Script:defaultColors.Keys) {
    $Color = $Script:defaultColors[$Color];
  }

  if ($Color -notmatch "^#[0-9A-F]{6}$") {
    throw "Hex color $Color is not valid!";
  }

# Remove # symbol
  $Color = $Color.Remove(0, 1);

  $red    = $Color.Remove(2, 4);
  $green  = $Color.Remove(4, 2).Remove(0, 2);
  $blue   = $Color.Remove(0, 4);

  $red    = [System.Convert]::ToInt32($red, 16);
  $green  = [System.Convert]::ToInt32($green, 16);
  $blue   = [System.Convert]::ToInt32($blue, 16);

  return "$red;$green;$blue";
}

function Write-HostColor {
  param(
      [Parameter(Mandatory = $true, Position = 1)] [string] $Value,
      [Parameter(Mandatory = $true, Position = 2)] [string] $ForegroundColor,
      [switch] $NoNewLine
  )

  $ForegroundColor = ConvertFrom-Hex -Color $ForegroundColor;
  Write-Host "`e[38;2;${ForegroundColor}m$Value`e[0m" -NoNewline:$NoNewLine;
}
