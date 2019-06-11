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

[[ "${__distro}" != 'elementary' && "${__distro}" != 'ubuntu' ]] && exit 1
[[ "${__desktop}" != 'MATE' ]] && exit 1

# Update/Upgrade
if [[ "${__mode}" = 'update' ]] || [[ "${__mode}" = 'bootstrap' ]]; then
  sudo apt -y update && sudo apt -y upgrade
fi

# Install i3
sudo apt -y install i3

# Install MATE applet(s)
sudo apt -y install mate-applet-appmenu
sudo apt -y install mate-tweak

# Install xsecurelock requirements
sudo apt -y install apache2-utils autotools-dev binutils gcc libc6-dev \
                    libpam-dev libx11-dev libxcomposite-dev libxext-dev \
                    libxfixes-dev libxft-dev libxmuu-dev libxrandr-dev \
                    libxss-dev make mplayer mpv pamtester pkg-config \
                    x11proto-core-dev xscreensaver autoconf

# Install xsecurelock
if ! [ -x "$(command -v xsecurelock)" ]; then
  rm -rf /home/${USER}/build/xsecurelock
  git clone --depth 1 \
            https://github.com/google/xsecurelock.git \
            /home/${USER}/build/xsecurelock
  cd /home/${USER}/build/xsecurelock/ && sh autogen.sh
  /home/${USER}/build/xsecurelock/configure --with-pam-service-name=common-auth
  make -C /home/${USER}/build/xsecurelock
  sudo make -C /home/${USER}/build/xsecurelock install
fi

sudo cp ${__dir}/../blob/usr/share/mate-panel/layouts/i3-tweak.* \
        /usr/share/mate-panel/layouts/

# Configure MATE
dconf write /org/mate/desktop/session/required-components/windowmanager "'i3'"
dconf write /org/mate/desktop/session/required-components-list "['windowmanager', 'panel']"
dconf write /org/mate/desktop/background/show-desktop-icons "false"
dconf write /org/mate/panel/general/default-layout "'i3-tweak'"
