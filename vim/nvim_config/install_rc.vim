source ~/.config/nvim/nvim_config/plugins.vim
function! InstallMe() 
    :PlugInstall
    :PlugUpdate
    :qa!    
endfunction 
