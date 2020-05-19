#!/usr/bin/env bash
#
# Full provisioning for new systems.

arch_linux_install() {
    sudo pacman -S neovim python-pynvim xorg-xinput xsel
}

other_installs() {
    sudo snap install code --classic
    sudo snap install insomnia
    sudo snap install telegram-desktop
    # Homebrew for linux: https://docs.brew.sh/Homebrew-on-Linux
}

essential_stuff() {
    local tmp=$(mktemp)

    local stuff
    stuff=(
        # programs
        apt-transport-https
        build-essential
        ca-certificates
        curl
        git
        gnupg2
        python3-dev
        python3-pip
        cmake
        software-properties-common
        tmux
        tree
        xsel
        baobab
        ncdu
        ffmpeg
        file
        silversearcher-ag
        libpq-dev  # for postgres, particularly in python
        # fonts
        fonts-croscore
        fonts-crosextra-caladea
        fonts-crosextra-carlito
        fonts-firacode
        fonts-hack
        fonts-inconsolata
        fonts-liberation
        fonts-monoid
        fonts-source-code-pro
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
        # These first two should be first.
        setuptools
        wheel
        ipython
        sqlalchemy
        psycopg2
        pandas
        jupyterlab
        ipython-sql  # for sql magics in jupyter
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

install_docker() {
    sudo apt remove docker docker-engine docker.io containerd runc \
        && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - \
        && sudo apt-key fingerprint 0EBFCD88 \
        && sudo add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/debian \
            $(lsb_release -cs) \
            stable" \
        && sudo apt update \
        && sudo apt install docker-ce docker-ce-cli containerd.io \
        && sudo docker run hello-world
}

sudo apt update \
    && essential_stuff

