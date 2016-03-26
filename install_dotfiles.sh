#!/usr/bin/env bash

# Backup all existing files before creating the new symlinks.
dotfiles=(
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

old_dotfiles=~/.old_dotfiles

# If backups already exists, they should be addressed first, removing or
# renaming the backup folder ($old_dotfiles).
if [ -d $old_dotfiles ]; then
    echo "First, deal with the existing backup of your old dotfiles"
    echo "The backup is located at $old_dotfiles (rename or remove that folder)"
    exit 1
else
    echo "Backups for existing files will be put in $old_dotfiles"
    mkdir $old_dotfiles
fi

for dotfile in ${dotfiles[@]}; do
    if [ -f ~/$dotfile ]; then
        echo "Replacing existing ~/$dotfile"
        mv ~/$dotfile $old_dotfiles/$dotfile.bak
    else
        echo "Creating ~/$dotfile"
    fi
    ln -s ~/.dotfiles/$dotfile ~/$dotfile
done

# All exports used in ~/.bashrc should be placed in the ~/.exports file.
if [ ! -f ~/.exports ]; then
    echo '#!/usr/bin/env bash' > ~/.exports
    echo '' >> ~/.exports
fi

# All settings specific to a system should be in the ~/.my_settings file.
# Careful: this one is not versioned by git.
if [ ! -f ~/.my_settings ]; then
    echo '#!/usr/bin/env bash' > ~/.my_settings
    echo '' >> ~/.my_settings
fi

