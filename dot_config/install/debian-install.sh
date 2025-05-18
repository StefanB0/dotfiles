#!/bin/bash
# Bash script to install packages on a generic Debian/Ubuntu derived distribution,
# mostly Debian because Ubuntu and derivatives have a lot of these installed by default.
sudo apt update && sudo apt install -y \
  git curl neovim aptitude tmux fzf bat fd-find tree jq \
  age build-essential wget gnupg ca-certificates lsb-release \
  zip unzip tar gzip xz-utils 7zip \
  openssl whois curlie httpie nginx \
  pipx python3 python3-pip python3-venv python3-dev python3-wheel
