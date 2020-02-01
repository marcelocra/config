#!/usr/bin/env bash

essential_stuff() {
    local tmp=$(mktemp)

    local stuff
    stuff=(
        # programs
        build-essential
        curl
        git
        tmux
        tree
        xsel
        python3-dev
        python3-pip
        # fonts
        fonts-firacode
        fonts-monoid
        fonts-hack
        fonts-source-code-pro
        fonts-liberation
        fonts-inconsolata
        fonts-croscore
        fonts-crosextra-caladea
        fonts-crosextra-carlito
    )

    echo 'Installing programs and fonts...' | tee -a $tmp

    for i in ${stuff[@]}; do
        echo "Installing $i..." | tee -a $tmp
        sudo apt install -y $i >> $tmp 2>&1
        if [ $? -ne 0 ]; then
            echo "Failed to install $i" | tee -a $tmp
        fi
    done

    echo 'Installing Python packages...' | tee -a $tmp
    local python_pkgs
    python_pkgs=(
        setuptools
        wheel
        ipython  # should be last
    )

    for i in ${python_pkgs[@]}; do
        echo "Installing $i..." | tee -a $tmp
        pip3 install $i >> $tmp 2>&1
        if [ $? -ne 0 ]; then
            echo "Failed to install $i" | tee -a $tmp
        fi
    done

    while true; do
        read -p "Want to see the logs? (y/n) " yn 
        case $yn in
            [Yy]* ) cat $tmp; exit;;
            [Nn]* ) exit;;
            * ) echo 'Please answer yes or no.';;
        esac
    done
}

sudo apt update \
    && essential_stuff

