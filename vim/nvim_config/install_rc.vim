" This rc is required in the installation process
" to download all plugins
" Other configuration files are loaded later as many
" commands require installed plugins
source ~/.config/nvim/nvim_config/plugins.vim
function! InstallMe()
    :PlugInstall
    :PlugUpdate
    :qa!
endfunction
