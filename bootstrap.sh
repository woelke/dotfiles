#!/bin/bash

set -eu -o pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
BIN_DIR="${HOME}/.local/bin/"

PATH_STR='${PATH}'
echo "export PATH=${BIN_DIR}:${PATH_STR}" >> "${HOME}/.profile"
echo "export DOTFILES_ROOT=${SCRIPT_DIR}" >> "${HOME}/.profile"

echo "export PATH=${BIN_DIR}:${PATH_STR}" >> "${HOME}/.zprofile"
echo "export DOTFILES_ROOT=${SCRIPT_DIR}" >> "${HOME}/.zprofile"


if [[ ! -e "${BIN_DIR}" ]]; then
    mkdir -p ${BIN_DIR}
fi
ln -fs "${SCRIPT_DIR}/dotfiles" ${BIN_DIR}

