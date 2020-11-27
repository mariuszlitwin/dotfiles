#!/usr/bin/env bash
#
# init/101.apt.sh
#
# Install apt-based packages

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

# Install apps
sudo apt -y install vim git make build-essential wget curl stow unrar tmux \
                    llvm xz-utils tk-dev gnupg2 \
                    tlp tlp-rdw mc \
                    python3 python3-dev python3-pip pythonpy \
                    libssl-dev zlib1g-dev libbz2-dev bzip2 \
                    libreadline-dev libsqlite3-dev \
                    libncurses5-dev libncursesw5-dev \
                    libappindicator1 libindicator7 \
                    gconf-service \
                    virtualbox docker.io \
                    xclip scrot \
                    snapd flatpak \
                    openssl opensc-pkcs11 libengine-pkcs11-openssl \
                    yubikey-manager
