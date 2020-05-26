#!/usr/bin/env bash

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

move_to_trash() {
  local trash_dir
  trash_dir="${HOME}/.trash"

  if [ ! -d "${trash_dir}" ]; then
    echo "Trash directory doesn't exist. Creating..."
    mkdir "${trash_dir}"
    echo "Created!"
  fi

  local new_dir_name
  new_dir_name="${trash_dir}/$(date +%Y-%m-%d_%H-%M-%S)/"
  mkdir "${new_dir_name}"

  echo "Moving to: ${new_dir_name}"
  mv "$@" ${new_dir_name}
  echo 'Done!'
}

# Exports.
# --------
# Add a number of paths to PATH.

# Snapcraft.
setup_exports() {
    export ANDROID_SDK_ROOT="$HOME/tools/Android/Sdk"
    export EDITOR=nvim
    export PIPENV_VENV_IN_PROJECT=1
    export DENO_INSTALL="${HOME}/.deno"

    local curr_paths
    curr_paths=(
        "/snap/bin"
        "$HOME/bin"
        "$HOME/.local/bin"
        "$HOME/tools/flutter/bin"
        "/home/linuxbrew/.linuxbrew/bin"
        "/usr/local/go/bin"
        "${DENO_INSTALL}/bin"
    )

    for curr_path in ${curr_paths[@]}; do
        if [[ ! "$PATH" == *${curr_path}* ]] ; then
            if [ -d "$curr_path" ] ; then
                export PATH="${PATH}:${curr_path}"
            fi
        fi
    done

    # ------------------------------------------------------------------------
    # Node stuff.
    # ------------------------------------------------------------------------

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
}

setup_exports

# Aliases.
# --------

alias tmux="TERM=xterm-256color tmux"

alias inst="sudo apt install"
alias purge="sudo apt purge"

alias eg=egrep

alias pip=pip3
alias python=python3

alias l="ls -lFh --block-size=MB"
alias ll="l -a"

alias szsh="source ${HOME}/.zshrc"
alias sbash="source ${HOME}/.bashrc"

alias really-rm="/bin/rm"
alias rm="move_to_trash"

alias code="code-insiders"

# Other scripts.
# --------------

source $HOME/projects/dotfiles/startup.sh

# Install fzf.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
