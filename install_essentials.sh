#!/usr/bin/env bash

sudo apt update \
    && sudo apt install -y \
        build-essential \
        curl \
        git \
        tmux \
        tree \
        xsel \
    && sudo apt install -y \
        fonts-firacode \
        fonts-monoid \
        fonts-source-code-pro \
        fonts-hack \
        fonts-liberation \
        fonts-inconsolata \
        fonts-croscore \
        fonts-crosextra-caladea \
        fonts-crosextra-carlito \
    && sudo apt install -y \
        python3-dev \
        python3-pip \
        pip install setuptools wheel ipython

