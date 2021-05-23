#!/usr/bin/env bash
#
# emenu.sh : script for spawning emoji picker
#
# Ref.: dotfiles/template/run-on-demand/emenu.sh

# Usage: bash emenu.sh

set -e

case "$1" in
  "copy")
    emoji=$(tee | awk -F"\t" '{print $1}' | tr -d \n)
    if [ ! -z "$emoji" ]; then
      echo -n "$emoji" | xclip -selection CLIPBOARD
      command -v notify-send > /dev/null && notify-send -t 600 "$emoji copied!"
    fi
    ;;
  "")
    cat ~/.emoji | bash <% system.utils_path %>/dmenu.sh "😀" | bash $0 copy
    ;;
esac
