#!/usr/bin/env bash
#
# io.elementary.terminal.sh - script for initilializing elementary terminal

# Check whether schema for elementary Terminal app is available
gsettings get io.elementary.terminal.settings encoding > /dev/null 2> /dev/null
[[ $? -ne 0 ]] && exit 1

gsettings set io.elementary.terminal.settings allow-bold true

gsettings set io.elementary.terminal.settings background '#<% color.background %>'
gsettings set io.elementary.terminal.settings foreground '#<% color.foreground %>'
gsettings set io.elementary.terminal.settings cursor-color '#<% color.brightforeground %>'

gsettings set io.elementary.terminal.settings palette '#<% color.black %>:#<% color.red %>:#<% color.green %>:#<% color.yellow %>:#<% color.blue %>:#<% color.magenta %>:#<% color.cyan %>:#<% color.white %>:#<% color.brightblack %>:#<% color.brightred %>:#<% color.brightgreen %>:#<% color.brightyellow %>:#<% color.brightblue %>:#<% color.brightmagenta %>:#<% color.brightcyan %>:#<% color.white %>'

gsettings set io.elementary.terminal.settings prefer-dark-style false

gsettings set io.elementary.terminal.settings font '<% font.monospace %> 14px'
gsettings set io.elementary.terminal.settings encoding 'utf-8'

gsettings set io.elementary.terminal.settings remember-tabs false
gsettings set io.elementary.terminal.settings follow-last-tab false

gsettings set io.elementary.terminal.settings natural-copy-paste true
gsettings set io.elementary.terminal.settings unsafe-paste-alert true

gsettings set io.elementary.terminal.settings audible-bell true
