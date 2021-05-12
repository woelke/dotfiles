" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> My Neovim Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filesystem navigator
Plug 'preservim/nerdtree'
Plug 'aufgang001/vim-nerdtree_plugin_open'

" Commenting of code
Plug 'preservim/nerdcommenter'

" VSCode Intellisense engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Code formating e.g. C++
Plug 'rhysd/vim-clang-format'

" Sematic highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Color schemes
Plug 'flazz/vim-colorschemes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'fenetikm/falcon'

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

" Vim start search without first jump
Plug 'linjiX/vim-star'

" search engine
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Search and open files (TODO remove me when fzf is working)
Plug 'ctrlpvim/ctrlp.vim'

" Initialize plugin system
call plug#end()
