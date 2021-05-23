#!/usr/bin/env bash
#
# rofi.sh : script for spawning riced rofi
#
# Ref.: dotfiles/template/run-on-demand/rofi.sh

# Usage: bash rofi.sh

<% system.bin_path %>/rofi \
             -font "<% font.base %> 14" \
             -color-window "#<% color.background %>, #<% color.foreground %>, #<% color.foreground %>" \
             -color-normal "#<% color.background %>, #<% color.foreground %>, #<% color.background %>, #<% color.lbackground %>, #<% color.foreground %>" \
             -color-active "#<% color.background %>, #<% color.foreground %>, #<% color.background %>, #<% color.primary_bg %>, #<% color.primary_fg %>" \
             -color-urgent "#<% color.background %>, #<% color.foreground %>, #<% color.background %>, #<% color.danger_bg %>, #<% color.danger_fg %>" \
             $@
