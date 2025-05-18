#!/bin/bash
# Bash script to install packages on a generic Debian/Ubuntu derived distribution,
# mostly Debian because Ubuntu and derivatives have a lot of these installed by default.
GITHUB_USERNAME=StefanB0

# Essentials
sudo apt update && sudo apt install -y git curl age tar xz-utils

# Chezmoi init
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME # Public repository
# sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:$GITHUB_USERNAME/dotfiles.git # Private repository
source ~/.bashrc

# Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env # Need to add to .bashrc
cargo install eza aichat du-dust ripgrep bat bottom git-delta zoxide hyperfine procs

# Other packages
sudo apt update && sudo apt install -y \
  git curl neovim aptitude tmux fzf bat fd-find tree jq \
  age build-essential wget gnupg ca-certificates lsb-release \
  zip unzip tar gzip xz-utils 7zip \
  openssl whois curlie httpie nginx \
  pipx python3 python3-pip python3-venv python3-dev python3-wheel
