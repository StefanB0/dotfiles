# WSL

### Install the linux distribution (Debian)
Write-Host "Installing Windows Subsystem for Linux..." -ForegroundColor Cyan

wsl --install Debian
wsl --set-default Debian

Write-Host "Waiting for Debian to initialize. Complete the user setup (IN ANOTHER TAB), then press Enter to continue..."
Pause

### Run the install script inside WSL
Write-Host "Configuring WSL distribution..." -ForegroundColor Cyan

$WSLTOHOME = "/mnt/c/Users/$env:USERNAME"

wsl -d Debian bash -c "mkdir -p ~/.config/install ~/.config/keys/"
wsl -d Debian bash -c "cp $WSLTOHOME/.config/keys/chezmoi-key.txt ~/.config/keys/chezmoi-key.txt"
wsl -d Debian bash -c "cp $WSLTOHOME/.config/install/debian.sh ~/.config/install/debian.sh"
wsl -d Debian bash -c "chmod +x ~/.config/install/debian.sh && ~/.config/install/debian.sh"

Pause