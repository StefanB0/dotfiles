#!/bin/bash
# Bash script to run on a clean wsl distribution after instalation

# Essentials
sudo apt update && sudo apt install -y git curl age tar xz-utils

# Chezmoi init
GITHUB_USERNAME=StefanB0
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME # Public repository
# sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:$GITHUB_USERNAME/dotfiles.git # Private repository
source ~/.bashrc

# Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env # Need to add to .bashrc
cargo install eza aichat du-dust ripgrep bat bottom git-delta zoxide hyperfine procs
