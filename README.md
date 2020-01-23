# .dotfiles

This repository contains several different dotfiles. Many of them works under any Unix/Linux system (assuming only `bash`).

## How to use
1. Clone this repository.
2. Symlink the files that you want:
        
        # Do this for each file that you care about.
        [cloned dir] $ ln -s ${path/to/the/file} ~{HOME}/expected-file-name

        # Example:
        [cloned dir] $ ln -s $(pwd)/.gitconfig ~{HOME}/.gitconfig