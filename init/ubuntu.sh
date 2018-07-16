#!/usr/bin/env bash
#
# init/ubuntu.sh
#
# Init Ubuntu-based distro to sane setup

# Invocation
set -o nounset
set -o errexit

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
source "${__dir}/.invocation.sh"

[[ "${__distro}" != 'Ubuntu' ]] && exit 1

# Bootstrap
if [[ "$__mode" = 'bootstrap' ]]; then
  sudo apt -y purge firefox
fi

# Update/Upgrade
if [[ "${__mode}" = 'update' ]] || [[ "${__mode}" = 'bootstrap' ]]; then 
  sudo apt -y update && sudo apt -y upgrade
  sudo snap refresh
fi

# Install apps
sudo apt -y install git make build-essential wget curl stow unrar tmux \
                    keepassxc \
                    llvm xz-utils tk-dev gnupg2 deja-dup duplicity deluge \
                    tlp tlp-rdw mc \
                    python python3 python-dev python3-dev \
                    python-pip python3-pip \
                    libssl-dev zlib1g-dev libbz2-dev bzip2 \
                    libreadline-dev libsqlite3-dev \
                    libncurses5-dev libncursesw5-dev \
                    libappindicator1 libindicator7 \
                    virtualbox \
                    snapd

sudo snap install firefox vlc spotify \
                  gimp inkscape \
                  tuxguitar-vs jq communitheme

# pyenv
if ! [ -x "$(command -v pyenv)" ]; then
  # TODO: change to some package manager
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
fi

# keybase
if ! [ -x "$(command -v keybase)" ]; then
  cd /tmp
  curl -O https://prerelease.keybase.io/keybase_amd64.deb
  sudo dpkg -i keybase_amd64.deb
  sudo apt install -f
  rm /tmp/keybase_amd64.deb
fi
