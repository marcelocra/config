#!/usr/bin/env bash

#-------------------------------------------------------------------------------
# These files are tracked by git.
#-------------------------------------------------------------------------------

# Copy your .bashrc to the this file if you want to keep it. Currently it is the
# default provided by Debian.
source ~/.dotfiles/default_bashrc.sh

# This file contain functions, alias and other customizations.
source ~/.dotfiles/custom_bashrc.sh

#-------------------------------------------------------------------------------
# These files are not tracked by git.
#-------------------------------------------------------------------------------

# You can put stuff that are particular to this installation. For example,
# exports.
source ~/.personal_settings
