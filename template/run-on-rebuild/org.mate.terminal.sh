#!/usr/bin/env bash
#
# org.mate.terminal.sh - script for initilializing MATE terminal

# Check whether schema for MATE Terminal app is available
gsettings get org.mate.terminal.global default-profile > /dev/null 2> /dev/null
[[ $? -ne 0 ]] && exit 1

dconf write /org/mate/terminal/profiles/default/use-theme-colors false

dconf write /org/mate/terminal/profiles/default/allow-bold true

dconf write /org/mate/terminal/profiles/default/background-color "'#<% color.background %>'"
dconf write /org/mate/terminal/profiles/default/foreground-color "'#<% color.foreground %>'"

dconf write /org/mate/terminal/profiles/default/palette "'#<% color.black %>:#<% color.red %>:#<% color.green %>:#<% color.yellow %>:#<% color.blue %>:#<% color.magenta %>:#<% color.cyan %>:#<% color.white %>:#<% color.lblack %>:#<% color.lred %>:#<% color.lgreen %>:#<% color.lyellow %>:#<% color.lblue %>:#<% color.lmagenta %>:#<% color.lcyan %>:#<% color.white %>'"
