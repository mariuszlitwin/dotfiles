#!/usr/bin/env bash
#
# init/801.keybase.sh
#
# Setup Keychron keyboard

# Invocation
set -o nounset
set -o errexit

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
source "${__dir}/.invocation.sh"

cat <<EOF | sudo tee /etc/modprobe.d/hid_apple.conf > /dev/null
options hid_apple fnmode=2
options hid_apple swap_opt_cmd=1
EOF
