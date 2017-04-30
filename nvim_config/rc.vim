"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:myOpenCmd = "gnome-open"
let g:mapleader = ","


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme molokai
set scrolloff=7     " keep 7 lines above and below the cursor.
set number          " show line numbers
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

" disable nasty command mode
noremap <S-q> <nop>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => short keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" :W saves the file even with sudo privileges
command! W call My_sudo_write()
function! My_sudo_write() 
  "overrides the current file with the content of the current buffer
  "and reloads the the file
  execute "write !sudo tee % > /dev/null"
  execute ":edit!"
endfunction 

" toggles search highlighting
noremap <leader><leader>h :set hlsearch! hlsearch?<CR>

" creates a pdf of the current buffer
noremap <leader><leader>pf :hardcopy > %.ps<CR> :!ps2pdf %".ps" %.pdf<CR> :!rm %.ps<CR> :execute system(g:myOpenCmd." ".expand("%").".pdf")<CR>

noremap <F9> :quit<CR> 
noremap <S-F9> :quit!<CR> 
inoremap <F9> <ESC>:quit<CR> 
inoremap <S-F9> <ESC>:quit!<CR> 
noremap <F8> :wall<CR>
inoremap <F8> <ESC>:wall<CR>

autocmd! BufNewFile,BufRead \v*.mywiki|*.tex|*.txt|README|*.md|COMMIT_EDITMSG|de.utf-8.add call Set_options_for_texting()
autocmd! BufNewFile,BufRead \v*.c|*.cpp|*.h|*.hpp call Set_options_for_cpp_coding()
autocmd! BufNewFile,BufRead,BufWritePost    \v.vimrc|*.vim call Set_options_for_vimrc()

function! Set_options_for_cpp_coding() 
  set cursorline " its to CPU-intensive in latex files
  call Set_makefile_shortcut_F5()
  noremap <F6> :cnext<CR>
  noremap <F7> :cprevious<CR> 
  set colorcolumn=80
  noremap <F12> :ClangFormat<CR>
endfunction 

function! Set_options_for_texting()
  setlocal spell spelllang=de,en_us

  call Set_makefile_shortcut_F5()

  "next wrong word
  noremap <F6> ]s 
    
  "previous wrong word
  "h is a bugfix: I had a problem with a latex file and the keybinding
  "]s. It jumps to the second letter of the next wrong written word, which blocks the backword jump .. for whatever reason
  noremap <F7> h[s 
endfunction

function! Set_options_for_vimrc() 
  "reload the vimrc file
  noremap <F5> :source %<CR>
endfunction 

function! Set_makefile_shortcut_F5() 
  noremap <F5> :make!<CR> :copen<CR><C-W><S-J> :redraw!<CR>
  noremap <S-F5> :make clean<CR> :copen<CR><C-W><S-J> :redraw!<CR>
endfunction 

"special character
inoremap @o ö
inoremap @u ü
inoremap @a ä
inoremap @O Ö
inoremap @U Ü
inoremap @A Ä
inoremap @s ß


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Undotree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undodir=~/.config/nvim/undo "where to save undo histories
set undofile            "Save undo's after file closes


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeIgnore=['\.o$', '\~$', '\.orig$', '\.aux$','\.fls$', '\.out$','\.toc$','\.log$','\.fdb_latexmk$', '\.idx$', '\.ilg$', '\.ing$', '\.ind$']

" opens nerdtree automatically on vim start if no files were specified
autocmd! vimenter
autocmd vimenter * if !argc() | NERDTree | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerdtree plugin open
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:nerdtree_plugin_open_cmd = g:myOpenCmd 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => clang-format
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clang_format_path = "clang-format-3.8"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDCustomDelimiters = {
  \ 'mcproxy': { 'left': '#' }
  \}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => youcompleteme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>yj :YcmCompleter GoToDefinitionElseDeclaration<CR>
noremap <leader>yf :YcmCompleter FixIt<CR>
noremap <leader>yd :YcmCompleter GetDoc<CR>
noremap <leader>yp :YcmCompleter GetParent<CR>
noremap <leader>yt :YcmCompleter GetType<CR>

let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '!'

"prevents ycm from asking to load a config file
let g:ycm_confirm_extra_conf = 0

"let g:ycm_python_binary_path = '/usr/bin/python3.5'
"let g:ycm_python_binary_path = '/usr/bin/python'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ligthline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2 " the windows will always have a status line


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => easy motion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable default mappings
let g:EasyMotion_do_mapping = 0 

let g:EasyMotion_smartcase = 1
let g:EasyMotion_space_jump_first = 1

map f <Plug>(easymotion-bd-f)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map Goyo toggle to <Leader> + spacebar
let g:goyo_width = 120
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 1

noremap <leader>z :Goyo<CR>  


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimwiki 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let wiki = {}
let wiki.path = '~/Dropbox/MyWiki/'
let wiki.path_html = '~/Dropbox/MyWiki/'

let wiki.auto_export = 0 
let wiki.ext = '.mywiki'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'shell': 'sh', 'sshconfig': 'sshconfig', 'gitconfig': 'gitconfig'}
let g:vimwiki_list = [wiki]

let g:vimwiki_ext2syntax = {'.mywiki': 'default'} 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => www
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:www_engines = {
  \ 'dict' : 'http://www.dict.cc/?s=',
  \ 'cpp' : 'http://en.cppreference.com/mwiki/index.php?search=',
\}

let g:www_shortcut_engines = {
  \ 'google': ['Wgoogle', '<leader>wg'],
  \ 'dict': ['Wdict', '<leader>wd'],
  \ 'cpp': ['Wcpp', '<leader>wc'],
\}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<C-p>'

let g:ctrlp_custom_ignore = {
  \ 'file': '\v\.(o|cxx)$'
  \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ack.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"use ag instead of ack (because it is faster)
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap <Leader>a :Ack!<Space>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => my scripts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"inverse return
inoremap <S-CR> <ESC>lDO<ESC>p0i
