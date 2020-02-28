#!/usr/bin/env sh

# Settings.
# ---------

tmx() {
    # Try to create a new session.
    tmux new -s $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    fi

    echo "Trying to reuse session $1..."
    sleep 0.5
    # Try to load existing session.
    tmux attach-session -t $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        return 0
    fi

    # Something else happened.
    echo "An error happened. Couldn't load $1"
    return 1
}

run() {
    if [ -f './package-lock.json' ]; then
        npm run $1
        return
    fi
    if [ -f './yarn.lock' ]; then
        yarn $1
        return
    fi
}

# Exports.
# --------
# Add a number of paths to PATH.

# Snapcraft.
if [ -d "/snap/bin" ] ; then
    export PATH="${PATH}:/snap/bin"
fi

# My binaries.
if [ -d "$HOME/bin" ] ; then
    export PATH="${PATH}:${HOME}/bin"
fi

# Private binaries (and also pip3 package dir).
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR=nvim

# Node stuff.
#
# NVM should be loaded first, as other exports and commands will need a
# valid Node installation.
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Yarn global binaries.
if [ -d "$HOME/.config/yarn/global" ] ; then
    export PATH="${PATH}:`yarn global bin 2> /dev/null`"
fi

# Aliases.
# --------

alias tmux="TERM=xterm-256color tmux"

alias vi=nvim
alias vim=vi

alias inst="sudo apt install"
alias purge="sudo apt purge"

alias eg=egrep

alias pip=pip3
alias python=python3

alias l="ls -lFh"
alias ll="ls -lFha"

alias szsh="source ${HOME}/.zshrc"
alias sbash="source ${HOME}/.bashrc"

# Other scripts.
# --------------

source $HOME/projects/dotfiles/startup.sh

# Install fzf.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
