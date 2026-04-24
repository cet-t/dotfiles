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
$PsProfileSrc   = Join-Path $DotfilesDir "powershell\profile.ps1"
$PsProfileDst   = $PROFILE

# scoop
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Installing scoop..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

# scoop packages
$scoopPkgs = @(
    "neovim",
    "git",
    "starship",
    "stylua",
    "taplo",
    "nodejs"
)
foreach ($pkg in $scoopPkgs) {
    if (-not (Get-Command $pkg -ErrorAction SilentlyContinue)) {
        Write-Host "Installing $pkg..."
        scoop install $pkg
    } else {
        Write-Host "Already installed: $pkg"
    }
}

# prettier (npm)
if (-not (Get-Command prettier -ErrorAction SilentlyContinue)) {
    Write-Host "Installing prettier..."
    npm install -g prettier
}

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

# PowerShell profile
$PsProfileDir = Split-Path -Parent $PsProfileDst
if (-not (Test-Path $PsProfileDir)) {
    New-Item -ItemType Directory -Path $PsProfileDir | Out-Null
}
if (Test-Path $PsProfileDst) {
    Move-Item -Path $PsProfileDst -Destination "${PsProfileDst}.bak" -Force
}
New-Item -ItemType SymbolicLink -Path $PsProfileDst -Target $PsProfileSrc | Out-Null
Write-Host "Linked: $PsProfileSrc -> $PsProfileDst"

Write-Host "Done. Run 'nvim' to install plugins."
