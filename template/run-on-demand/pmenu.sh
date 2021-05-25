#!/usr/bin/env bash
#
# emenu.sh : script for managing power-related stuff
#
# Ref.: dotfiles/template/run-on-demand/pmenu.sh

# Usage: bash pmenu.sh

set -e

shutdown="⏻ shutdown"
restart="↺ restart"
lock="⚿ lock"
sleep="⏾ sleep"
logout="⎗ logout"

chosen=$(echo "$shutdown
$restart
$lock
$sleep
$logout" | bash <% system.utils_path %>/dmenu.sh " POWER" -theme $HOME/.config/rofi/sidebar.rasi)

case "$chosen" in
    "$shutdown") bash <% system.utils_path %>/prompt.sh "Shutdown?" && poweroff;;
    "$restart") bash <% system.utils_path %>/prompt.sh "Restart?" && reboot;;
    "$lock") bash <% system.utils_path %>/runner.sh lockscreen;;
    "$suspend") bash <% system.utils_path %>/prompt.sh "Suspend?" && systemctl suspend;;
    "$logout") bash <% system.utils_path %>/prompt.sh "Logout?" && mate-session-save --logout;;
    *) exit 1 ;;
esac

