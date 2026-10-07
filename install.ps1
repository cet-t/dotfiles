#Requires -RunAsAdministrator
[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$DotfilesDir    = Split-Path -Parent $MyInvocation.MyCommand.Path

$NvimSrc        = Join-Path $DotfilesDir "nvim"
$NvimDst        = Join-Path $env:LOCALAPPDATA "nvim"

$NuSrc          = Join-Path $DotfilesDir "nu"
$NuDst          = Join-Path $env:APPDATA "nushell"

$HerdrSrc       = Join-Path $DotfilesDir "herdr"
$HerdrDst       = Join-Path $env:APPDATA "herdr"

$RioSrc         = Join-Path $DotfilesDir "rio"
$RioDst         = Join-Path $env:LOCALAPPDATA "rio"

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
    "stylua",
    "taplo",
    "nodejs",
    # "ripgrep",
    "bat",
    # "nu",
    "bun",
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

# cargo
if (-not (Get-Command cargo -V --ErrorAction SilentlyContinue)) {
    winget install Rustlang.Rustup
    winget pin add --id Rustlang.Rustup --blocking
}

# cargo packages
$cargoPackages = @(
    "ripgrep",
    "rio",
    "nu",
)
foreach ($pkg in $cargoPackages) {
    cargo install pkg
}

# herdr
if (-not (Get-Command herdr -V --ErrorAction SilentlyContinue)) {
    powershell -ExecutionPolicy Bypass -c "irm https://herdr.dev/install.ps1 | iex"
}

# nvim
if (Test-Path $NvimDst) {
    $backup = "${NvimDst}.bak"
    Write-Host "Backup: $NvimDst -> $backup"
    Move-Item -Path $NvimDst -Destination $backup -Force
}
New-Item -ItemType SymbolicLink -Path $NvimDst -Target $NvimSrc | Out-Null
Write-Host "Linked: $NvimSrc -> $NvimDst"

# rio
if (Test-Path $RioDst) {
    $backup = "${RioDst}.bak"
    Write-Host "Backup: $RioDst -> $backup"
    Move-Item -Path $RioDst -Destination $backup -Force
}
New-Item -ItemType SymbolicLink -Path $RioDst -Target $RioSrc | Out-Null
Write-Host "Linked: $RioSrc -> $RioDst"

# nushell
if (-not (Test-Path $NuDst)) {
    New-Item -ItemType Directory -Path $NuDst | Out-Null
}
if (Test-Path $NuDst) {
    Move-Item -Path $NuDst -Destination "${NuDst}.bak" -Force
}
New-Item -ItemType SymbolicLink -Path $NuDst -Target $NuSrc | Out-Null
Write-Host "Linked: $NuSrc -> $NuDst"

# herdr
New-Item -ItemType Directory -Path (Split-Path -Parent $HerdrDst) -Force | Out-Null
if (Test-Path $HerdrDst) {
    $backup = "${HerdrDst}.bak"
    Write-Host "Backup: $HerdrDst -> $backup"
    Move-Item -Path $HerdrDst -Destination $backup -Force
}
New-Item -ItemType SymbolicLink -Path $HerdrDst -Target $HerdrSrc | Out-Null
Write-Host "Linked: $HerdrSrc -> $HerdrDst"

Write-Host "Done. Run 'nvim' to install plugins."
