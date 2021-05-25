#!/usr/bin/env bash
#
# emenu.sh : script for spawning emoji picker
#
# Ref.: dotfiles/template/run-on-demand/emenu.sh

# Usage: bash emenu.sh

set -e

case "$1" in
  "list")
    echo "$(TZ=UTC date --rfc-3339=seconds)	now
$(TZ=UTC date --rfc-3339=ns)	exactly now
$(TZ=UTC date --rfc-3339=date)	today
¯\_(ツ)_/¯	shrug
( ͡° ͜ʖ ͡°)	lenny face
(╯°□°)╯︵ ┻━┻	flipping table
ä	ae
ä	a umlaut
ö	oe
ö	o umlaut                                                                    
ü	ue
ü	u umlaut                                                                    
Ä	Ae
Ä	A umlaut                                                                    
Ö	Oe
Ö	O umlaut                                                                    
Ü	Ue
Ü	U umlaut                                                                    
ß	ss
ß	scharfes S"
	  [ -f ~/.emoji ] && cat ~/.emoji
    [ -f ~/emoji.sh ] && bash ~/emoji.sh
    ;;
  "copy")
    emoji=$(tee | awk -F"\t" '{print $1}' | tr -d \n)
    if [ ! -z "$emoji" ]; then
      echo -n "$emoji" | xclip -selection CLIPBOARD
      command -v notify-send > /dev/null && notify-send -t 600 "$emoji copied!"
    fi
    ;;
  "")
    bash $0 list | bash <% system.utils_path %>/dmenu.sh " EMOJI" -theme $HOME/.config/rofi/sidebar.rasi | bash $0 copy
    ;;
esac
