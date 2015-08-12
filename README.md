# .dotfiles

## How to use
1. Clone this repository to ~/.dotfiles.
2. Check which files you want to use by commenting the unwanted ones in the `dotfiles` array in `~/.dotfiles/install_dotfiles`.

    Example (in case you don't want the .inputrc):

        {% highlight bash %}
        dotfiles=(
            .bashrc
            .gitconfig
            #.inputrc
            .profile
            .tmux.conf
            .fonts.conf
        )
        {% endhighlight %}

3. Run the installation script `~/.dotfiles/install_dotfiles`.
4. Relaunch your terminal or run `. ~/.bashrc`.

Bonus: if you are doing this right after a fresh Debian install, you might want to take a look at the `install_essential_software` script. It just lists a bunch of packages that you normally need after a fresh install (like `curl` and `git`) and install all of them at once.
