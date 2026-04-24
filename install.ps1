#Requires -RunAsAdministrator
[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$DotfilesDir    = Split-Path -Parent $MyInvocation.MyCommand.Path
$NvimSrc        = Join-Path $DotfilesDir "nvim"
$NvimDst        = Join-Path $env:LOCALAPPDATA "nvim"
$AlacrittyDir   = Join-Path $env:APPDATA "alacritty"
$AlacritySrc    = Join-Path $DotfilesDir "alacritty\alacritty.toml"
$AlacrittyDst   = Join-Path $AlacrittyDir "alacritty.toml"

# nvim
if (Test-Path $NvimDst) {
    $backup = "${NvimDst}.bak"
    Write-Host "Backup: $NvimDst -> $backup"
    Move-Item -Path $NvimDst -Destination $backup -Force
}
New-Item -ItemType SymbolicLink -Path $NvimDst -Target $NvimSrc | Out-Null
Write-Host "Linked: $NvimSrc -> $NvimDst"

# alacritty
if (-not (Test-Path $AlacrittyDir)) {
    New-Item -ItemType Directory -Path $AlacrittyDir | Out-Null
}
if (Test-Path $AlacrittyDst) {
    Move-Item -Path $AlacrittyDst -Destination "${AlacrittyDst}.bak" -Force
}
New-Item -ItemType SymbolicLink -Path $AlacrittyDst -Target $AlacritySrc | Out-Null
Write-Host "Linked: $AlacritySrc -> $AlacrittyDst"

Write-Host "Done. Run 'nvim' to install plugins."
