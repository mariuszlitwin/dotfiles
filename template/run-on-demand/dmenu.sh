#!/usr/bin/env bash
#
# dmenu.sh : script for starting various app menus in consistent way
#
# Ref.: dotfiles/template/run-on-demand/dmenu.sh

# Usage: bash dmenu.sh <prompt>

prompt=$1; shift
in=$(cat)

echo "$in" | <% system.bin_path %>/rofi -dmenu \
             -p "$prompt" \
             -font "<% font.base %> 14" \
             -color-window "#<% color.background %>, #<% color.foreground %>, #<% color.foreground %>" \
             -color-normal "#<% color.background %>, #<% color.foreground %>, #<% color.background %>, #<% color.lbackground %>, #<% color.foreground %>" \
             -color-active "#<% color.background %>, #<% color.foreground %>, #<% color.background %>, #<% color.primary_bg %>, #<% color.primary_fg %>" \
             -color-urgent "#<% color.background %>, #<% color.foreground %>, #<% color.background %>, #<% color.danger_bg %>, #<% color.danger_fg %>" \
             $@
