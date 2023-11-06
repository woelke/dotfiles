#!/bin/bash

set -eu -o pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
BIN_DIR="${HOME}/.local/bin"

PATH_STR='${PATH}'
echo "export PATH=${BIN_DIR}:${PATH_STR}" >> "${HOME}/.profile"
echo "export DOTFILES_ROOT=${SCRIPT_DIR}" >> "${HOME}/.profile"

echo "export PATH=${BIN_DIR}:${PATH_STR}" >> "${HOME}/.yprofile"
echo "export DOTFILES_ROOT=${SCRIPT_DIR}" >> "${HOME}/.zprofile"

pushd dotfiles_py
  pipx install --editable .
popd


