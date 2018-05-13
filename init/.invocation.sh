#!/usr/bin/env bash
#
# init/.invocation.sh
#
# Init some basic vars to use within distro inti scripts

# Invocation
set -o nounset
set -o errexit

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__distro=`bash ${__dir}/.get_distro.sh`
__mode="${1-default}"
