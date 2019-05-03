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

snap install firefox
snap install --edge sqlitebrowser