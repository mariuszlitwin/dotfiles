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

# Unbind some keyboard shortcuts to allow tmux work it's magic
dconf write /org/mate/terminal/keybindings/zoom-in "'<Ctrl>+'"
dconf write /org/mate/terminal/keybindings/move-tab-right "'<Ctrl>underscore'"

dconf write /org/mate/terminal/keybindings/move-tab-left "'disabled'"
dconf write /org/mate/terminal/keybindings/move-tab-right "'disabled'"
dconf write /org/mate/terminal/keybindings/new-tab "'disabled'"
dconf write /org/mate/terminal/keybindings/close-tab "'disabled'"
dconf write /org/mate/terminal/keybindings/next-tab "'disabled'"
dconf write /org/mate/terminal/keybindings/prev-tab "'disabled'"
dconf write /org/mate/terminal/keybindings/next-profile "'disabled'"
dconf write /org/mate/terminal/keybindings/prev-profile "'disabled'"
dconf write /org/mate/terminal/keybindings/new-window "'disabled'"
dconf write /org/mate/terminal/keybindings/close-window "'disabled'"
dconf write /org/mate/terminal/keybindings/switch-to-tab-1 "'disabled'"
dconf write /org/mate/terminal/keybindings/switch-to-tab-2 "'disabled'"
dconf write /org/mate/terminal/keybindings/switch-to-tab-3 "'disabled'"
dconf write /org/mate/terminal/keybindings/switch-to-tab-4 "'disabled'"
dconf write /org/mate/terminal/keybindings/switch-to-tab-5 "'disabled'"
dconf write /org/mate/terminal/keybindings/switch-to-tab-6 "'disabled'"
dconf write /org/mate/terminal/keybindings/switch-to-tab-7 "'disabled'"
dconf write /org/mate/terminal/keybindings/switch-to-tab-8 "'disabled'"
dconf write /org/mate/terminal/keybindings/switch-to-tab-9 "'disabled'"
dconf write /org/mate/terminal/keybindings/switch-to-tab-10 "'disabled'"
