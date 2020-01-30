# .dotfiles

This repository contains several different dotfiles. Many of them works under
any Unix/Linux system.

## How to use
1. Clone this repository.
2. Symlink the files that you want:
        
        # Do this for each file that you care about.
        [cloned dir] $ ln -s ${path/to/the/file} ~{HOME}/expected-file-name

        # Example:
        [cloned dir] $ ln -s $(pwd)/.gitconfig ~{HOME}/.gitconfig

## What to do after installing a new system

I've been testing different settings and these are the best ones for me and my
systems.

### Display

When using an external display, a good resolution for the laptop monitor is
1440x810 (16:9).

### Cinnamon settings

#### Clock custom date and time

For this custom date and time:

`•%n%a%n%e%n%b%n•%n%H%n%M%n%S%n•`

you get something like:

    •
    Mon
    27
    Jan
    •
    23
    54
    10
    •

#### Shortcuts

- Ctrl+shift+T --> Terminal
- Insert --> equivalent to ctrl+alt+up

