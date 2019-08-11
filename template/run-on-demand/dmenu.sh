#!/usr/bin/env bash
#
# dmenu.sh : script for starting various app menus in consistent way
#
# Ref.: dotfiles/template/run-on-demand/dmenu.sh

# Usage: bash dmenu.sh <prompt>

prompt=$1; shift
in=$(cat)

echo "$in" | <% system.binpath %>/dmenu -i -b -l 12 \
                                        -nf '#<% color.foreground %>' \
                                        -nb '#<% color.background %>' \
                                        -sb '#<% color.primary-bg %>' \
                                        -sf '#<% color.primary-fg %>' \
                                        -fn '<% font.base %>:pixelsize=14' \
                                        -p "$prompt " $@
