#!/usr/bin/env bash
# Run the following command to save the list of extensions from one machine.
#   Unix:
#       code-insiders --list-extensions | xargs -L 1 echo code-insiders --install-extension
#   Windows:
#       code-insiders --list-extensions | % { "code-insiders --install-extension $_" }
# Then put it here.

set -e

code-insiders --install-extension arcticicestudio.nord-visual-studio-code
code-insiders --install-extension CoenraadS.bracket-pair-colorizer-2
code-insiders --install-extension Dart-Code.flutter
code-insiders --install-extension dbaeumer.vscode-eslint
code-insiders --install-extension eamodio.gitlens
code-insiders --install-extension esbenp.prettier-vscode
code-insiders --install-extension ms-azuretools.vscode-docker
code-insiders --install-extension msjsdiag.debugger-for-chrome
code-insiders --install-extension ms-python.python
code-insiders --install-extension ms-vscode.Go
code-insiders --install-extension ms-vscode.sublime-keybindings
code-insiders --install-extension vscodevim.vim
code-insiders --install-extension zhuangtongfa.material-theme

set +e
