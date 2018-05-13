#!/usr/bin/env bash
#
# init/.get_distro.sh
#
# Quick script to determine distro in place

# Invocation
set -o nounset
set -o errexit

if [[ -r '/etc/lsb-release' ]]; then
    . /etc/lsb-release
    [[ "$DISTRIB_ID" ]] && n="$DISTRIB_ID"
elif [[ -r '/etc/release' ]]; then
    n=`head -1 /etc/release | sed 's/ *\([[^0-9]]*\) [0-9].*/\1/'`
elif [[ -r '/etc/debian_version' ]]; then
    n='Debian'
elif [[ -r '/etc/redhat-release' ]]; then
    n='Red Hat'
fi
[[ "${n:-}" = '' ]] && \echo "ERROR: Could not determine the distro name" >&2 && \exit 1
echo ${n:-}
