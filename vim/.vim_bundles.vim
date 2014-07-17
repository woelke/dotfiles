"vundle
set nocompatible               " be improved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"let Vundle manage Vundle
"required! 
Bundle 'gmarik/vundle'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> My Bundles:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"filesystem navigator 
Bundle 'scrooloose/nerdtree'

"syntax checking plugin
Bundle 'scrooloose/syntastic' 

"commenting of code
Bundle 'scrooloose/nerdcommenter' 

"code-completion engine
Bundle 'Valloric/YouCompleteMe' 

"snippet completion
Bundle 'SirVer/ultisnips' 

"summary of snippets
Bundle 'honza/vim-snippets.git'

"highlighting schemes
Bundle 'flazz/vim-colorschemes' 

"git intergration
Bundle 'tpope/vim-fugitive'

"unobtrusive git diff indicator
Bundle 'mhinz/vim-signify'

Bundle 'maksimr/vim-translator' 
Bundle 'Raimondi/delimitMate'
Bundle 'itchyny/lightline.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'mbbill/undotree'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/DrawIt'
Bundle 'kien/tabman.vim'
Bundle 'rhysd/vim-clang-format'
Bundle 'aufgang001/vim-nerdtree_plugin_open'
Bundle 'myusuf3/numbers.vim'
Bundle 'Yggdroot/indentLine'
Bundle 'junegunn/goyo.vim'
Bundle 'vimwiki/vimwiki'

"synatax highlighting pack
Bundle 'sheerun/vim-polyglot'

"highlighting mcproxy config files
Bundle 'mcproxy/vim-mcproxy_conf_highlighting'

"list all TODOs in your project
Bundle 'vim-scripts/TaskList.vim'

Bundle 'mattn/flappyvird-vim'

"http://vimawesome.com/

"the clean vimrc
"http://usevim.com/2012/05/09/clean-vimrc/

"the better shell
"http://code.hootsuite.com/vimshell/

"ToDO
"write an mcproxy script hihlighter
"https://github.com/bbchung/clighter
"book
"http://learnvimscriptthehardway.stevelosh.com/

"an other formater
"https://github.com/Chiel92/vim-autoformat

"unit.vim 
"It would be great to use @Shougo Unite.vim plugin (A wonderful plugin) which (easily) replace cltrp / ack / and NERDtree.

"https://github.com/amix/vimrc ==> bääääm boooom bäsch get das up
"FredKSchott/CoVim
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'

" git repos on your local machine (ie. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'

" check this out https://github.com/spf13/spf13-vim
" https://github.com/skwp/dotfiles

" old plugins
"Bundle 'mhinz/vim-startify' 

