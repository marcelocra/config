# .dotfiles

## How to use
1. Clone this repository to ~/.dotfiles.
2. Check which files you want to use by commenting the unwanted ones in the `dotfiles` array in `~/.dotfiles/install_dotfiles`.

Example (in case you don't want the .inputrc):
```bash
dotfiles=(
    .bashrc
    .gitconfig
    #.inputrc
    .profile
    .tmux.conf
    .fonts.conf
)
```

3. Run the installation script `~/.dotfiles/install_dotfiles`.
4. Relaunch your terminal or run `. ~/.bashrc`.
