#!/usr/bin/env bash
#
# init/111.snap.sh
#
# Install snap-based packages

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
if snap whoami | grep "email: -" > /dev/null; then
  sudo snap login
fi

# Update/Upgrade
if [[ "${__mode}" = 'update' ]] || [[ "${__mode}" = 'bootstrap' ]]; then 
  snap refresh
fi

# graphics
snap install gimp inkscape

# bitwarden
snap install bitwarden
snap install bw
