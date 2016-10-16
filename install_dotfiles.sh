#!/usr/bin/env bash

function create_new_dotfiles() {
    local old_dotfiles="$1"

    # Backup all existing files before creating the new symlinks.
    local dotfiles=(
        .Xresources
        .bashrc
        .fonts.conf
        .gitconfig
        .inputrc
        .profile
        .screenrc
        .tmux.conf
        .ycm_extra_conf.py
    )
    echo "Backups for existing files will be put in $old_dotfiles"
    mkdir $old_dotfiles
    for dotfile in ${dotfiles[@]}; do
        # For an existing file, move it to the backup folder before creating the
        # symlink.
        if [ -f ~/$dotfile ]; then
            echo "Replacing existing ~/$dotfile"
            mv ~/$dotfile $old_dotfiles/$dotfile.bak
        else
            echo "Creating ~/$dotfile"
        fi
        ln -s ~/.dotfiles/$dotfile ~/$dotfile
    done

}

function create_personal_settings_file() {
    # All personal settings used in ~/.bashrc should be placed in the
    # ~/.personal_settings file. Create an empty one, if it doesn't exist yet.
    if [ ! -f ~/.personal_settings ]; then
        echo '#!/usr/bin/env bash' > ~/.personal_settings
        echo '' >> ~/.personal_settings
    fi
}

function main() {
    # If backups already exists, they should be addressed first, removing or
    # renaming the backup folder ($old_dotfiles).
    local old_dotfiles=~/.old_dotfiles
    if [ -d $old_dotfiles ]; then
        echo "First, deal with the existing backup of your old dotfiles"
        echo "The backup is located at $old_dotfiles (rename or remove that folder)"
        exit 1
    fi

    create_new_dotfiles "$old_dotfiles"
    create_personal_settings_file
}

main
