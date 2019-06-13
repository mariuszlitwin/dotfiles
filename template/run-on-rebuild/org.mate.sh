#!/usr/bin/env bash
#
# org.mate.sh - script for initilializing MATE/GTK interfaces

# Check whether schema for MATE is available
gsettings get org.mate.desktop.interface gtk-theme > /dev/null 2> /dev/null
[[ $? -ne 0 ]] && exit 1

dconf write /org/mate/marco/general/theme "'Menta'"
dconf write /org/mate/desktop/interface/gtk-color-scheme "unset"
dconf write /org/mate/desktop/interface/gtk-theme "'Menta'"
dconf write /org/mate/desktop/interface/icon-theme "'menta'"
