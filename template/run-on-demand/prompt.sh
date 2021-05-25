#!/usr/bin/env bash
#
# emenu.sh : script for yes/no prompt
#
# Ref.: dotfiles/template/run-on-demand/prompt.sh

# Usage: bash prompt.sh

set -e

yes="✓ yes"
no="× no"

chosen=$(echo "$yes
$no" | bash <% system.utils_path %>/dmenu.sh $1 -theme $HOME/.config/rofi/prompt.rasi)

case "$chosen" in
    "$yes") true;;
    "$no") false;;
    *) false;;
esac

