#!/bin/bash
##### Install / update script for dotfiles #####
# TODO: Maybe fix the HACK (rm -rf then mv) by using cp -r

# Check OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    bash ./mac/install.sh
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    bash ./arch/install.sh
else
    printf "OS not supported. Exiting...\n"
    exit 1
fi

# Remove dotfiles directory
# rm -rf ~/.dotfiles
