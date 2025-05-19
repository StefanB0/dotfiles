# WSL

### Install the linux distribution (Debian)
Write-Host "Installing Windows Subsystem for Linux..." -ForegroundColor Cyan

wsl --install Debian

### Wait for initial Debian setup (user must complete setup manually)
Write-Host "Waiting for Debian to initialize. Complete user setup, then press Enter to continue..."
Pause

wsl --set-default Debian

### Run the install script inside WSL
$WSLTOHOME = "/mnt/c/Users/$env:USERNAME/"

wsl -d Debian bash -c "mkdir -p ~/.config/install ~/.config/keys/"
wsl -d Debian bash -c "cp $WSLTOHOME/.config/keys/chezmoi-key.txt ~/.config/keys/chezmoi-key.txt"
wsl -d Debian bash -c "cp $WSLTOHOME/.config/install/debian.sh ~/.config/install/debian.sh"
wsl -d Debian bash -c "chmod +x ~/.config/install/debian.sh && ~/.config/install/debian.sh"