#!/usr/bin/env bash

essential_softwares=(
    curl
    git
    # Allows easy control of audio output devices. Install if necessary.
    #pavucontrol
    # Makes it easier for programs that interact with the command line,
    # such as Clojure's REPL.
    rlwrap
    tmux
    # Shows a tree of all inner directories and files.
    tree
    vim-gtk
    # Allows tmux to properly deal with the clipboard.
    xsel
)

for essential_software in ${essential_softwares[@]}; do
    echo "Installing $essential_software..."
    sudo apt-get install -y $essential_software
    echo
done
