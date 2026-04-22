#Requires -RunAsAdministrator
[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$DotfilesDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$NvimSrc     = Join-Path $DotfilesDir "nvim"
$NvimDst     = Join-Path $env:LOCALAPPDATA "nvim"

if (Test-Path $NvimDst) {
    $backup = "${NvimDst}.bak"
    Write-Host "Backup: $NvimDst -> $backup"
    Move-Item -Path $NvimDst -Destination $backup -Force
}

New-Item -ItemType SymbolicLink -Path $NvimDst -Target $NvimSrc | Out-Null
Write-Host "Linked: $NvimSrc -> $NvimDst"
Write-Host "Done. Run 'nvim' to install plugins."
