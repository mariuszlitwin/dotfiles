#!/usr/bin/env bash
#
# init/112.flatpak.sh
#
# Install apt-based packages

# Invocation
set -o nounset
set -o errexit

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
source "${__dir}/.invocation.sh"

which snap > /dev/null 2> /dev/null
[[ $? -ne 0 ]] && exit 1

# Initial login
if [[ "${__mode}" = 'bootstrap' ]]; then 
  sudo snap login
fi

# Update/Upgrade
if [[ "${__mode}" = 'update' ]] || [[ "${__mode}" = 'bootstrap' ]]; then 
  snap refresh
fi

# bitwarden
snap install bitwarden
snap install bw
