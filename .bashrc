#!/usr/bin/env bash

# -----------------------------------------------------------
# These files are inside ~/.dotfiles to be tracked by git.
# -----------------------------------------------------------

source ~/.dotfiles/default_bashrc.sh
source ~/.dotfiles/custom_bashrc.sh

# ----------------------------------------------------
# Next files are not supposed to be tracked by git.
# ----------------------------------------------------

# All exports should be in this file.
source ~/.exports

# All particular system settings should be here.
source ~/.my_settings

