#!/bin/bash

# Check if latest version of neovim nightly is installed
local_nvim_version=$(nvim --version | grep 'NVIM v' | awk '{print $2}')
latest_nvim_version=$(curl -s https://api.github.com/repos/neovim/neovim/releases | grep -m1 'NVIM v' | awk -F'\' '{print $2}' | awk '{print substr($0, 7)}')

if [ "$local_nvim_version" == "$latest_nvim_version" ]; then
    printf "Neovim nightly is up to date\n"
    printf "Local version  : $local_nvim_version\n"
    printf "Latest version : $latest_nvim_version\n"
else
    printf "Neovim nightly is not up to date\n"
    printf "Local version  : $local_nvim_version\n"
    printf "Latest version : $latest_nvim_version\n"
    printf "Updating neovim nightly\n"

    if [ "$(whoami)" == "root" ]; then
        # Some of the following commands require sudo
        printf "Running as root\n"
        curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
        # xattr -c ./nvim-macos-arm64.tar.gz  # May be needed to remove "unknown deveoper" warning
        tar -C /opt -xzf nvim-macos-arm64.tar.gz
        rm nvim-macos-arm64.tar.gz
        printf "Neovim nightly has been installed/updated\n"
    else
        printf "Run script as root to install/update neovim nightly\n"
    fi
fi

