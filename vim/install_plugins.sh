#!/bin/bash

set -eu -o pipefail

nvim_path="${HOME}/.config/nvim"

echo "dofile '${nvim_path}/nvim_config/install_rc.lua'" > ${nvim_path}/init.lua

nvim -c "call InstallMe()"

echo "dofile '${nvim_path}/nvim_config/init.lua' " > ${nvim_path}/init.lua
