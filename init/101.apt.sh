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

[[ "${__distro}" != 'elementary' && "${__distro}" != 'ubuntu' ]] && exit 1

# Update/Upgrade
if [[ "${__mode}" = 'update' ]] || [[ "${__mode}" = 'bootstrap' ]]; then 
  sudo apt -y update && sudo apt -y upgrade
fi

# Install apps
sudo apt -y install git make build-essential wget curl stow unrar tmux \
                    llvm xz-utils tk-dev gnupg2 \
                    tlp tlp-rdw mc \
                    python python3 python-dev python3-dev \
                    python-pip python3-pip \
                    libssl-dev zlib1g-dev libbz2-dev bzip2 \
                    libreadline-dev libsqlite3-dev \
                    libncurses5-dev libncursesw5-dev \
                    libappindicator1 libindicator7 \
                    fonts-hack-ttf dconf-editor \
                    snapd flatpak

