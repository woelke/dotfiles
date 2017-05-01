" install plugin manager
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> My Neovim Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" an universal set of defaults that (hopefully) everyone can agree on
"Plug 'tpope/vim-sensible' ":checkhealth says its not needed 01.05.17, will
"try

" multi threading extention (usefull in nvim??)
"Plug 'shougo/vimproc.vim', {'do': 'make'} 

" filesystem navigator
Plug 'scrooloose/nerdtree'
Plug 'aufgang001/vim-nerdtree_plugin_open'

" commenting of code
Plug 'scrooloose/nerdcommenter' 

"code-completion engine
function! BuildYCM(info)
    if a:info.status != 'unchanged'
        !./install.py --clang-completer
    endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

" clang-formater wrapper
Plug 'aufgang001/vim-clang-format-py'

" highlighting schemes
Plug 'flazz/vim-colorschemes'
"Plug 'NLKNguyen/papercolor-theme'

" displaying thin vertical lines at each indentation level
Plug 'Yggdroot/indentLine'

" intelligently toggling line numbers
Plug 'myusuf3/numbers.vim'

" provides automatic closing of quotes, parenthesis, brackets, etc.
Plug 'Raimondi/delimitMate'

" a light and configurable statusline/tabline
Plug 'itchyny/lightline.vim'

" simplifies and quickens motions
Plug 'Lokaltog/vim-easymotion'

" Provides an visual undo tree which can be travered
Plug 'mbbill/undotree'

" allows distraction-free writing
Plug 'junegunn/goyo.vim'

" a wiki for vim
Plug 'vimwiki/vimwiki'

" synatax highlighting pack
Plug 'sheerun/vim-polyglot'

"highlighting mcproxy config files
 Plug 'mcproxy/vim-mcproxy_conf_highlighting'

" my synconized spell files
Plug 'aufgang001/vim-custom_spellfile', {'do': './install.sh nvim'} 

" opens URLs in browser
Plug 'waiting-for-dev/www.vim'

" search and open files
Plug 'ctrlpvim/ctrlp.vim'

"in file search
Plug 'mileszs/ack.vim'

"delete, change and add surroundings in pairs
Plug 'tpope/vim-surround'

" Initialize plugin system
call plug#end()