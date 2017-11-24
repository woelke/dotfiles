" Specify a directory for plugins
call plug#begin('~/.config/nvim/sec_plugged')
Plug 'scrooloose/nerdtree'
" Initialize plugin system
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=7     " keep 7 lines above and below the cursor.
set relativenumber  " show line numbers relative to the current line
set ignorecase      " ignore case when searching
set smartcase       " when searching try to be smart about cases
set showmatch       " show matching brackets when text indicator is over them
set expandtab       " expand tabs with whitespaces"
set tabstop=2
set softtabstop=-1  " make 'softtabstop' follow 'shiftwidth'
set shiftwidth=0    " make 'shiftwidth' follow 'tabstop'
set mouse=a         " enable the use of the mouse
set hlsearch        " highlights all search matches
set autowriteall    " saves all files on some events like :suspend"

" disable the nasty command mode
noremap <S-q> <nop>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quit a buffer
noremap <F9> :quit<CR> 
noremap <S-F9> :quit!<CR> 
inoremap <F9> <ESC>:quit<CR> 
inoremap <S-F9> <ESC>:quit!<CR> 
" save a buffer
noremap <F8> :wall<CR>
inoremap <F8> <ESC>:wall<CR>

" move left, right, up, down
noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l
inoremap <A-h> <ESC><C-w>h
inoremap <A-j> <ESC><C-w>j
inoremap <A-k> <ESC><C-w>k
inoremap <A-l> <ESC><C-w>l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" opens nerdtree automatically on vim start if no files were specified
autocmd! vimenter
autocmd vimenter * if !argc() | NERDTree | endif
