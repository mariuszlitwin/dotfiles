#!/usr/bin/env bash
#
# emenu.sh : script for managing power-related stuff
#
# Ref.: dotfiles/template/run-on-demand/pmenu.sh

# Usage: bash emenu.sh

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
    "$shutdown") i3-nagbar -t warning -m "Shutdown?" -b "Yup" poweroff;;
    "$restart") i3-nagbar -t warning -m "Restart?" -b "Yup" reboot;;
    "$lock") bash <% system.utils_path %>/runner.sh lockscreen;;
    "$suspend") i3-nagbar -t warning -m "Suspend?" -b "Yup" "systemctl suspend";;
    "$logout") i3-nagbar -t warning -m "Logout?" -b "Yup" "mate-session-save --logout";;
    *) exit 1 ;;
esac

