#!/usr/bin/env bash

function main() {
    local essential_softwares=(
        #---------------------------------------------------------------------------
        # Dev.
        #---------------------------------------------------------------------------

        curl
        git
        tmux
        vim-gtk

        # Makes it easier for programs that interact with the command line,
        # such as Clojure REPL.
        rlwrap

        #---------------------------------------------------------------------------
        # Utility.
        #---------------------------------------------------------------------------

        # Shows a tree of all inner directories and files.
        tree

        # Allows tmux to properly deal with the clipboard.
        xsel

        # Allows easy control of audio output devices. Install if necessary.
        #pavucontrol
    )

    for essential_software in ${essential_softwares[@]}; do
        echo "Installing ${essential_software}..."
        sudo apt-get install ${essential_software}
        echo
    done
}

main
