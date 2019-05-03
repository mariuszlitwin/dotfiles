#!/usr/bin/env bash
#
# init/000.always.sh
#
# Run some basic init thingies

# Invocation
set -o nounset
set -o errexit

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
source "${__dir}/.invocation.sh"

# pyenv
if ! [ -x "$(command -v pyenv)" ]; then
  # TODO: change to some package manager
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
fi
