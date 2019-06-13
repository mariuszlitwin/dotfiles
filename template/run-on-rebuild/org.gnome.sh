#!/usr/bin/env bash
#
# org.gnome.desktop.interface.sh - script for initilializing Gnome/GTK interfaces

# Check whether schema for Gnome is available
gsettings get org.gnome.desktop.interface clock-format > /dev/null 2> /dev/null
[[ $? -ne 0 ]] && exit 1

gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true

gsettings get org.gnome.shell disable-user-extensions > /dev/null 2> /dev/null
[[ $? -ne 0 ]] && exit 1

gsettings set org.gnome.shell disable-user-extensions true

gsettings get org.gnome.shell.extensions.dash-to-dock activate-single-window > /dev/null 2> /dev/null
[[ $? -ne 0 ]] && exit 1

gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
