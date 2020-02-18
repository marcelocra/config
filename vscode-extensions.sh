#!/usr/bin/env bash
# Run the following command to save the list of extensions from one machine.
#   Unix:
#       code --list-extensions | xargs -L 1 echo code --install-extension
#   Windows:
#       code --list-extensions | % { "code --install-extension $_" }
# Then put it here.

set -e

code --install-extension arcticicestudio.nord-visual-studio-code
code --install-extension CoenraadS.bracket-pair-colorizer-2
code --install-extension dbaeumer.vscode-eslint
code --install-extension eamodio.gitlens
code --install-extension esbenp.prettier-vscode
code --install-extension ms-azuretools.vscode-docker
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension ms-python.python
code --install-extension ms-vscode.Go
code --install-extension ms-vscode.sublime-keybindings
code --install-extension vscodevim.vim
code --install-extension zhuangtongfa.material-theme

set +e
