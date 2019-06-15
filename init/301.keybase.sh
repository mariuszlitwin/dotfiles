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

which keybase || return 1

# Download Keybase
curl https://prerelease.keybase.io/keybase_amd64.deb \
     -o /tmp/keybase_amd64.deb
curl https://prerelease.keybase.io/keybase_amd64.deb.sig \
     -o /tmp/keybase_amd64.deb.sig
curl https://keybase.io/docs/server_security/code_signing_key.asc \
    -o /tmp/keybase.asc
gpg --import /tmp/keybase.asc

# Verify signature
gpg --verify /tmp/keybase_amd64.deb.sig /tmp/keybase_amd64.deb || exit 1

# Install Keybase
sudo dpkg -i /tmp/keybase_amd64.deb
