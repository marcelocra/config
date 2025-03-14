#!/usr/bin/env bash
# Saves or installs all extensions for code and code-insiders. Assumes that
# both are installed.
# 
# In Windows it should be the following:
#   code --list-extensions | % { "code --install-extension $_" }

set -e

[ -z $1 ] && exit 1

EXTENSIONS_FILE="vscode-extensions.txt"

if [[ $1 == save ]]; then
  EXTENSIONS_LIST=$(mktemp)
  code --list-extensions | xargs -L 1 echo > $EXTENSIONS_LIST
  code-insiders --list-extensions | xargs -L 1 echo >> $EXTENSIONS_LIST # Note that this is an append.
  cat $EXTENSIONS_LIST | sort | uniq | tee $EXTENSIONS_FILE
fi

if [[ $1 == inst* ]]; then
  if [ ! -f $EXTENSIONS_FILE ]; then
    echo "You don't have an extensions file"
    exit 1
  fi

  if [[ -z $2 || $2 == code ]]; then
    echo '--------------------------------'
    echo '| Installing Code extensions...|'
    echo '--------------------------------'
    cat $EXTENSIONS_FILE | xargs -L 1 code --install-extension
    echo '... done!'
  fi
  if [[ -z $2 || $2 == codi ]]; then
    echo '-----------------------------------------'
    echo '| Installing Code Insiders extensions...|'
    echo '-----------------------------------------'
    cat $EXTENSIONS_FILE | xargs -L 1 code-insiders --install-extension
    echo '... done!'
  fi
fi

set +e
