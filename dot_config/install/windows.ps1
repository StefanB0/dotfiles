# PowerShell Script to set up a new windows machine computer

### Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Please run this script as an Administrator" -ForegroundColor Red
    exit
}

# Winget

### Check if winget is available
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget is not available. Please ensure Windows Package Manager is installed."
    exit
}

### Install Git
Write-Host "Installing Git..." -ForegroundColor Cyan
winget install Git.Git

### Install PowerToys
Write-Host "Installing PowerToys..." -ForegroundColor Cyan
winget install Microsoft.PowerToys

Write-Host "Installing Visual Studio 2022 Community..." -ForegroundColor Cyan
winget install Microsoft.VisualStudio.2022.Community

Write-Host "Winget Installation complete!" -ForegroundColor Green

# Scoop

### Set execution policy to allow script execution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

### Check if Scoop is already installed
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    ### Install Scoop
    Write-Host "Installing Scoop..." -ForegroundColor Cyan
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

### Add additional buckets
scoop bucket add main
scoop bucket add extras
scoop bucket add versions
scoop bucket add nerd-fonts

### Install
Write-Host "Installing Scoop apps..." -ForegroundColor Green

scoop install `
    7zip ffmpeg chezmoi neovim miktex pipx restic clink yt-dlp age vcredist2022 `
    firefox waterfox discord  obsidian keepassxc krita vlc ocenaudio obs-studio losslesscut media-downloader `
    vscode lazygit pycharm nodejs python rustup `
    cascadia-code firacode-nf-mono go-mono-nf
    # fzf rclone shellcheck everything everything-cli
    # postman librewolf draw.io winmerge

Write-Host "Scoop apps installation complete!" -ForegroundColor Green

# Rust

### Install cargo apps
cargo install eza aichat du-dust ripgrep bat bottom git-delta zoxide hyperfine procs

# Cleanup 

Write-Host "***********************************************************************************************"
Write-Host "Setup Script is complete!" -ForegroundColor Green
