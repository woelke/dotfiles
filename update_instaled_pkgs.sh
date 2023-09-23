#!/bin/bash

set -eu -o pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

pacman -Qe > ${SCRIPT_DIR}/installed_pkgs/$(hostname)
