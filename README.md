# .dotfiles

## How to use
1. Clone this repository to ~/.dotfiles.
2. Check which files you want to use by comment the unwanted ones in the `dotfiles` array in `~/.dotfiles/install_dotfiles`.

    dotfiles=(
        .bashrc
        .gitconfig
        .inputrc
        .profile
        .tmux.conf
        .fonts.conf
    )

   - `ln -s ~/.dotfiles/.gitconfig ~/.gitconfig`
   - `ln -s ~/.dotfiles/.bashrc ~/.bashrc`
3. Run the installation script `~/.dotfiles/install_dotfiles`.
3. Relaunch your terminal or run `. ~/.bashrc`.
