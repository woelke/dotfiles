" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> My Neovim Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filesystem navigator
Plug 'scrooloose/nerdtree'
Plug 'aufgang001/vim-nerdtree_plugin_open'

" Commenting of code
Plug 'scrooloose/nerdcommenter'

" Code-completion engine
function! BuildYCM(info)
    if a:info.status != 'unchanged'
        !./install.py --clang-completer
    endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

" Clang-formater wrapper
Plug 'aufgang001/vim-clang-format-py'

" Highlighting schemes
Plug 'flazz/vim-colorschemes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'fenetikm/falcon'

" Displaying thin vertical lines at each indentation level
Plug 'Yggdroot/indentLine'

" Provides automatic closing of quotes, parenthesis, brackets, etc.
Plug 'Raimondi/delimitMate'

" A light and configurable statusline/tabline
Plug 'itchyny/lightline.vim'

" Simplifies and quickens motions
Plug 'Lokaltog/vim-easymotion'

" Provides an visual undo tree which can be travered
Plug 'mbbill/undotree'

" Allows distraction-free writing
Plug 'junegunn/goyo.vim'

" A wiki for vim
Plug 'vimwiki/vimwiki'

" Synatax highlighting pack
Plug 'sheerun/vim-polyglot'

" Highlighting mcproxy config files
 Plug 'mcproxy/vim-mcproxy_conf_highlighting'

" My synconized spell files
Plug 'aufgang001/vim-custom_spellfile', {'do': './install.sh nvim'}

" Opens URLs in browser
Plug 'waiting-for-dev/www.vim'

" Search and open files
Plug 'ctrlpvim/ctrlp.vim'

" In file search wrapper
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }

" Delete, change and add surroundings in pairs
Plug 'tpope/vim-surround'

" Allows to rename tabs
Plug 'gcmt/taboo.vim'

" Highlights trailing withespaces and can delete them
Plug 'ntpeters/vim-better-whitespace'

" This plugin provides a start screen for Vim and Neovim.
Plug 'mhinz/vim-startify'

" Latex live preview
Plug 'donRaphaco/neotex'

" Initialize plugin system
call plug#end()
