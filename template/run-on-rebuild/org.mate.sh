#!/usr/bin/env bash
#
# org.mate.sh - script for initilializing MATE

# Check whether schema for MATE is available
gsettings get org.mate.desktop.interface.font-name > /dev/null 2> /dev/null
[[ $? -ne 0 ]] && exit 1

dconf write /org/mate/desktop/interface/font-name "'<$ font.base %> 11'"
dconf write /org/mate/desktop/interface/document-font-name "'<$ font.base %> 11'"
dconf write /org/mate/caja/desktop/font "'<$ font.base %> 11'"
dconf write /org/mate/marco/general/titlebar-font "'<$ font.base %> 11'"
dconf write /org/mate/desktop/interface/monospace-font-name "'<$ font.monospace %> 13'"

dconf write /org/mate/desktop/background/color-shading-type "'solid'"
dconf write /org/mate/desktop/background/picture-filename "''"
dconf write /org/mate/desktop/background/picture-options "'wallpaper'"
dconf write /org/mate/desktop/background/primary-color "'#<% color.background %>'"
dconf write /org/mate/desktop/background/secondary-color "'#<% color.background %>'"