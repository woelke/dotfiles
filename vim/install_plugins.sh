#!/bin/bash

set -eu -o pipefail

nvim_path="${HOME}/.config/nvim"

echo "source ${nvim_path}/nvim_config/install_rc.vim" > ${nvim_path}/init.vim

nvim -c "call InstallMe()"

echo "source ${nvim_path}/nvim_config/init.vim" > ${nvim_path}/init.vim
echo "source ${nvim_path}/nvim_config/ginit.vim" > ${nvim_path}/ginit.vim