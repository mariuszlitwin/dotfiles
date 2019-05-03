#!/usr/bin/env bash
#
# init/apt.sh
#
# Install apt-based packages

# Invocation
set -o nounset
set -o errexit

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
source "${__dir}/.invocation.sh"

which flatpak > /dev/null 2> /dev/null
[[ $? -ne 0 ]] && exit 1

# Add repos
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-add --if-not-exists nuvola https://dl.tiliado.eu/flatpak/nuvola.flatpakrepo

# Update/Upgrade
flatpak update

# Tidal
flatpak install -y nuvola eu.tiliado.NuvolaAppTidal
