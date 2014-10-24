#!/usr/bin/vim 

call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> My Bundles:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"filesystem navigator 
Plug 'scrooloose/nerdtree'

"syntax checking plugin
Plug 'scrooloose/syntastic' 

"commenting of code
Plug 'scrooloose/nerdcommenter' 

"code-completion engine
Plug 'Valloric/YouCompleteMe', {'do': './install.sh --clang-completer'} 

"highlighting schemes
Plug 'flazz/vim-colorschemes'

"translate words or phrases with goolge translater
Plug 'maksimr/vim-translator' 

"search for a word or a phrase on google
Plug 'szw/vim-g'

Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'mbbill/undotree'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/DrawIt'
Plug 'kien/tabman.vim'
Plug 'rhysd/vim-clang-format'
Plug 'aufgang001/vim-nerdtree_plugin_open'
Plug 'markgandolfo/nerdtree-fetch.vim'
Plug 'myusuf3/numbers.vim'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'

"synatax highlighting pack
Plug 'sheerun/vim-polyglot'

"highlighting mcproxy config files
Plug 'mcproxy/vim-mcproxy_conf_highlighting'

"list all TODOs in your project
Plug 'vim-scripts/TaskList.vim'

"my synconized spell files
Plug 'aufgang001/vim-custom_spellfile', {'do': './install.sh'} 


"currently not working, we should wait a while
"Plug 'XadillaX/json-formatter.vim'

"this looks cool
"http://www.vim.org/scripts/script.php?script_id=4957#1.0.3

"http://vimawesome.com/

"http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/

"the clean vimrc
"http://usevim.com/2012/05/09/clean-vimrc/

"mybe better than vimwiki
"https://github.com/Rykka/riv.vim

"the better shell
"http://code.hootsuite.com/vimshell/

"language detection
"https://github.com/daaugusto/spelllangidentifier

"ToDO
"write an mcproxy script hihlighter
"https://github.com/bbchung/clighter
"book
"http://learnvimscriptthehardway.stevelosh.com/

"maybe better plugin manager
"https://github.com/junegunn/vim-plug

"an other formater
"https://github.com/Chiel92/vim-autoformat

"unit.vim 
"It would be great to use @Shougo Unite.vim plugin (A wonderful plugin) which (easily) replace cltrp / ack / and NERDtree.

"https://github.com/amix/vimrc ==> bääääm boooom bäsch get das up
"FredKSchott/CoVim
" non github repos
"Plug 'git://git.wincent.com/command-t.git'

" git repos on your local machine (ie. when working on your own plugin)
"Plug 'file:///Users/gmarik/path/to/plugin'

" check this out https://github.com/spf13/spf13-vim
" https://github.com/skwp/dotfiles
"
" maybe a better vimplugin
" http://www.vim.org/scripts/script.php?script_id=3508#1.3.13

"F5 auto make file 
"johnsyweb/vim-makeshift


" an autosave plugin
" https://github.com/907th/vim-auto-save
" 
" old plugins
"Plug 'mhinz/vim-startify' 




call plug#end()
