#!/usr/bin/env bash
#
# org.gnome.terminal.sh - script for initilializing gnome terminal

# Check whether schema for gnome Terminal app is available
gsettings get org.gnome.Terminal.ProfilesList default > /dev/null 2> /dev/null
[[ $? -ne 0 ]] && exit 1

profile=`gsettings get org.gnome.Terminal.ProfilesList default`
profile=${profile:1:-1}

dconf load "/org/gnome/terminal/legacy/profiles:/:$profile/" <<EOF
    [/]
    visible-name='mariuszlitwin'
    audible-bell=false
    foreground-color='#<% color.foreground %>'
    background-color='#<% color.background %>'
    cursor-foreground-color='#<% color.lforeground %>'
    palette=['#<% color.black %>', '#<% color.red %>', '#<% color.green %>', '#<% color.yellow %>', '#<% color.blue %>', '#<% color.magenta %>', '#<% color.cyan %>', '#<% color.white %>', '#<% color.lblack %>', '#<% color.lred %>', '#<% color.lgreen %>', '#<% color.lyellow %>', '#<% color.lblue %>', '#<% color.lmagenta %>', '#<% color.lcyan %>', '#<% color.white %>']
    use-theme-transparency=false
    use-theme-colors=false
    use-transparent-background=false
    background-transparency-percent=0
EOF
