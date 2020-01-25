#!/usr/bin/env bash

sudo apt update \
    && sudo apt install -y \
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
        fonts-liberation
