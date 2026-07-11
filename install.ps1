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
$NuSrc          = Join-Path $DotfilesDir "nu"
$NuDst          = Join-Path $env:APPDATA "nushell"

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
    "nodejs",
    "go",
    "ripgrep",
    "bat",
    "nu"
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

# Go tools
$goTools = @(
    "golang.org/x/tools/gopls@latest",
    "golang.org/x/tools/cmd/goimports@latest"
)
foreach ($tool in $goTools) {
    $bin = ($tool -split "/")[-1] -replace "@.*", ""
    if (-not (Get-Command $bin -ErrorAction SilentlyContinue)) {
        Write-Host "Installing $bin..."
        go install $tool
    } else {
        Write-Host "Already installed: $bin"
    }
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

# nushell
if (-not (Test-Path $NuDst)) {
    New-Item -ItemType Directory -Path $NuDst | Out-Null
}
if (Test-Path $NuDst) {
    Move-Item -Path $NuDst -Destination "${NuDst}.bak" -Force
}
New-Item -ItemType SymbolicLink -Path $NuDst -Target $NuSrc | Out-Null
Write-Host "Linked: $NuSrc -> $NuDst"

Write-Host "Done. Run 'nvim' to install plugins."
