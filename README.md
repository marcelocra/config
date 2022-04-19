# dotfiles REVAMPED (abr22)

This repo contains many configuration files that I use. Use the navigation icon
(hamburguer menu to the left of the `README.md` file name) to browse.

## How to use

I would:

1.  Use `degit` to download the latest version of this repo
1.  Add it to a `dotfiles` repo in your own GitHub
1.  Symlink the files that you care about, like this:

Windows (PowerShell):

```powershell
[dotfiles dir] PS> New-Item `
-Path
"C:\Users\$env:USERNAME\AppData\Roaming\Sublime Text 3\Packages\User\Preferences.sublime-settings" `
-ItemType SymbolicLink `
-Value C:\Users\$env:USERNAME\dotfiles\Preferences.sublime-settings
```

Unix (Bash):

```bash
[dotfiles dir] $ ln -s $(pwd)/.gitconfig ~{HOME}/.gitconfig
```

## Files in the top level folder

These files work in both those systems.

### `.gitconfig`

Locations (most likely... need to review):

- Windows: C:\Users\$env:USERNAME\.gitconfig
- Linux: /home/$USER/.gitconfig

### `.gitignore`

I put this here because I tested (and am testing) with a number of different
ways to setup these dotfiles. Leaving it for now :).

### `Preferences.sublime-settings`

Say whatever you want, Sublime Text is the best **notepad.exe** there is. I use
it as such and this is my configuration file.

I don't use it as a full text editor, so no extensions and the like.

(Don't get me wrong, it is amazing. But these days I'm enjoing VSCode more.)

### TODO: document other files.

## `unix`

### `.fonts.conf`

Might give you a better font rendering under Debian/Ubuntu.

It is quite old, and since I'm not using them anymore, I would google this a bit
to check if they are still valid.

If they are, you might get some rendering that even resemble the Mac font
rendering :).

### `.tmux.conf` (need update)

Simplifies tmux's shortcuts a bit, in my view.

### `main.sh` (need update)

Contains a lot of the startup code that we normally put in `.bashrc`. I'm not
using this anymore since I migrated to `zsh` and don't even feel the need to
save my `.zshrc` here (usually I only change the theme).

### `startup.sh`

Uses a lot of sed shenanigans to properly configure mouses and keyboards in a
Debian/Ubuntu with desktop environment (i.e. not terminal-only).

## `windows`

### `Microsoft.PowerShell_profile.ps1`

PowerShell's .bashrc.

(Note: did you know that PowerShell works in Linux and Mac systems? I was
shocked when I discovered that. And it seems like a really interesting terminal,
with a non-alian scripting language (looking at you, bash).)

## `experimental_install_scripts`

I played a bit with automating the installation of this config files, but never
finished those scripts. Might finish some day, but until then I'm keeping the
ideas around, as they are interesting.

## `archive`

These files were relevant at some point, but are not anymore. I'm keeping them
only to have the references to previous stuff that I did, for copy/pasting.

WARNING: nothing here is expected to actually work.
