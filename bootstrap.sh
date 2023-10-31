#!/bin/bash

set -eu -o pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "export DOTFILES_ROOT=${SCRIPT_DIR}" >> "${HOME}/.profile"
echo "export DOTFILES_ROOT=${SCRIPT_DIR}" >> "${HOME}/.zprofile"

pushd dotfiles_py
  pipx install --editable .
popd


