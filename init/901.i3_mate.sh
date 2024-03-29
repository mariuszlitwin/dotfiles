#!/usr/bin/env bash
#
# init/901.i3_mate.sh
#
# Build i3 + MATE killer combination

# Invocation
set -o nounset
set -o errexit

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
source "${__dir}/.invocation.sh"

[[ "${__distro}" != 'elementary' && "${__distro}" != 'ubuntu' &&
   "${__distro}" != 'debian' ]] && exit 1

# Update/Upgrade
if [[ "${__mode}" = 'update' ]] || [[ "${__mode}" = 'bootstrap' ]]; then
  sudo apt -y update && sudo apt -y upgrade
fi

# Install i3
sudo apt -y install i3 rofi

# Install MATE applet(s)
sudo apt -y install mate-applet-appmenu
sudo apt -y install mate-indicator-applet
sudo apt -y install mate-tweak

# Install emoji font
sudo apt -y install fonts-noto-color-emoji fonts-roboto

# Install fancy theme
sudo apt -y install materia-gtk-theme

# Load panel layout to /usr/share/mate-panel/layouts
sudo cp ${__dir}/../blob/usr/share/mate-panel/layouts/i3-tweak.* \
        /usr/share/mate-panel/layouts/
mate-panel --layout i3-tweak
mate-panel --reset --replace

# Download Ubuntu MATE themes
mkdir -pv ${HOME}/.themes
mkdir -pv ${HOME}/.icons
mkdir -pv ${HOME}/.fonts
mkdir -pv ${HOME}/.local/share/gtksourceview-2.0/styles
mkdir -pv ${HOME}/.local/share/gtksourceview-3.0/styles

if [ ! -d "${HOME}/build/ubuntu-mate-artwork" ]; then
  git clone --depth 1 \
            https://github.com/ubuntu-mate/ubuntu-mate-artwork.git \
            ${HOME}/build/ubuntu-mate-artwork
else
  cd ${HOME}/build/ubuntu-mate-artwork && git pull origin
fi

if [ -f "${HOME}/build/ubuntu-font.zip" ]; then
  rm "${HOME}/build/ubuntu-font.zip"
fi
curl https://assets.ubuntu.com/v1/fad7939b-ubuntu-font-family-0.83.zip \
     -o "${HOME}/build/ubuntu-font.zip"

unzip -oj "${HOME}/build/ubuntu-font.zip" *.ttf \
      -d ${HOME}/.fonts

fc-cache -f -v

cp -r ${HOME}/build/ubuntu-mate-artwork/usr/share/themes/* \
      ${HOME}/.themes/
cp -r ${HOME}/build/ubuntu-mate-artwork/usr/share/icons/* \
      ${HOME}/.icons/
cp -r ${HOME}/build/ubuntu-mate-artwork/usr/share/gtksourceview-2.0/styles/* \
      ${HOME}/.local/share/gtksourceview-2.0/styles
cp -r ${HOME}/build/ubuntu-mate-artwork/usr/share/gtksourceview-3.0/styles/* \
      ${HOME}/.local/share/gtksourceview-3.0/styles

# Configure MATE
dconf write /org/mate/desktop/session/required-components/windowmanager "'i3'"
dconf write /org/mate/desktop/session/required-components-list "['windowmanager', 'panel', 'dock']"
dconf write /org/mate/desktop/background/show-desktop-icons "false"
dconf write /org/mate/panel/general/default-layout "'i3-tweak'"

dconf write /org/mate/marco/general/theme "'Materia-dark-compact'"
dconf write /org/mate/desktop/interface/gtk-theme "'Materia-dark-compact'"
dconf write /org/mate/desktop/interface/icon-theme "'Ambiant-MATE'"
