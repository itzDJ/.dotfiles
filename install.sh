#!/bin/bash
##### Install / update script for dotfiles #####
# TODO: Maybe fix the HACK (rm -rf then mv) by using cp -r

# Check OS
if [[ "$(uname)" == "Darwin" ]]; then
    printf "MacOS detected...\n"
    bash <(curl https://raw.githubusercontent.com/itzDJ/.dotfiles/main/mac/install.sh)
elif [[ "$(uname)" == "Linux" ]]; then
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        if [[ "$ID" == "debian" ]]; then
            printf "Debian detected...\n"
            bash <(curl https://raw.githubusercontent.com/itzDJ/.dotfiles/main/debian/install.sh)
        elif [[ "$ID" == "arch" ]]; then
            printf "Arch detected...\n"
            bash <(curl https://raw.githubusercontent.com/itzDJ/.dotfiles/main/arch/install.sh)
        else
            printf "Linux distribution not recognized: $ID"
        fi
    else
        printf "/etc/os-release not found. Cannot determine distribution."
    fi
else
    printf "OS not supported. Exiting...\n"
    exit 1
fi

# Remove dotfiles directory
rm -rf ~/.dotfiles
