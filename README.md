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

`•%n%a%n%d%n%b%n•%n%H%n%M%n%S%n•`

you get something like:

    •
    Mon
    01
    Jan
    •
    23
    54
    10
    •

Note: you might need to ajust the spacing (e.g. adding space to to left of the
bullet icons, etc).

#### Shortcuts

- Ctrl+shift+T --> Terminal
- Insert --> equivalent to ctrl+alt+up

#### Font selection

- Default font: Roboto Regular 10
- Desktop font: Roboto Regular 10
- Document font: Roboto Regular 10
- Monospace font: Roboto Mono Regular 10
- Window title font: Roboto Black 11

### Font rendering

Please, use the `.fonts.conf` file in this folder! It will give you amazing
results that might even resemble the Mac font rendering :).

### Icon set

Manjaro and Linux Mint both comes with a very nice set of icons and theme.
Debian doesn't. To replicate Manjaro cursor theme and Mint icon set in Debian
install:

- Cursors: breeze-cursor-theme
- Icons: mint-x-icons, mint-y-icons, mint-themes (must be last)
