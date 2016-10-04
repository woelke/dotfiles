#!/usr/bin/vim 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vim_bundles.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general settings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible "be improved

let g:myOpenCmd = "gnome-open"
let g:mapleader = ","

set autoread "set to auto read when a file is changed from the outside


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=7 "Set 7 lines to the cursor - when moving vertically using j/k

colorscheme molokai
set shell=/bin/bash\ -i 
syntax on
set number "show line numbers
set ignorecase "Ignore case when searching
set smartcase "When searching try to be smart about cases
set showmatch "Show matching brackets when text indicator is over them
set expandtab "expand tabs with whitespaces"
set tabstop=2
set softtabstop=-1 " Make 'softtabstop' follow 'shiftwidth'
set shiftwidth=0 " Make 'shiftwidth' follow 'tabstop'
set mouse=a
hi Search ctermbg=7 "grey
set hlsearch
set autowriteall
set cryptmethod=blowfish

"speed up vim
set synmaxcol=2000
set ttyfast "you got a fast terminal
set lazyredraw " to avoid scrolling problems

"Disable nasty command mode
noremap <S-q> <nop>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => short keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W call My_sudo_write()
function! My_sudo_write() 
  "overrides the current file with the content of the current buffer without
  "and reloads the the file
  execute "write !sudo tee % > /dev/null"
  execute ":edit!"
endfunction 

noremap <leader><leader>h :set hlsearch! hlsearch?<CR>
noremap <leader><leader>l :set cursorline! cursorline?<CR> 
noremap <leader><leader>b :!bash<CR>
noremap <leader><leader>i :set cindent! cindent?<CR>

noremap <leader><leader>pp :hardcopy > this_file_is_for_printing_only.ps<CR> :!gtklp this_file_is_for_printing_only.ps<CR> :!rm this_file_is_for_printing_only.ps<CR>
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
  set cursorline "its to cpu CPU-intensive in latex files

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
  noremap <C-S-F5> :make ARGS=% run<CR> :copen<CR><C-W><S-J> :redraw!<CR>
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
" => spellcheck configurations 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader><leader>s :setlocal nospell<CR> 
noremap <leader><leader>se :setlocal spell<CR> :setlocal spelllang=en<CR>
noremap <leader><leader>sd :setlocal spell<CR> :setlocal spelllang=de<CR> 
noremap <leader><leader>sa :setlocal spell<CR> :setlocal spelllang=de,en<CR> 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Undo files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile            "Save undo's after file closes
set undodir=~/.vim/undo "where to save undo histories


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gui options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 2
let s:maxfontsize = 60 
function! AdjustFontSize(amount)
  if has("gui_gtk2")
      let fontname = substitute(&guifont, s:pattern, '\1', '')
      let cursize = substitute(&guifont, s:pattern, '\2', '')
      let newsize = cursize + a:amount
      if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
          let newfont = fontname . newsize
          let &guifont = newfont
      endif
  else
      echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! Gui_shortcuts()
  noremap <C-kPlus> :call AdjustFontSize(1)<CR>
  noremap <C-kMinus> :call AdjustFontSize(-1)<CR>
  noremap <C-kMultiply> :set guifont=Monospace\ 12<CR>

  " avoid escape
      "" moves
  inoremap <A-h> <ESC>
  inoremap <A-j> <ESC>j
  inoremap <A-k> <ESC>k
  inoremap <A-l> <ESC>l
  inoremap <A-b> <ESC>lb
  inoremap <A-w> <ESC>lw
  inoremap <A-e> <ESC>le
  inoremap <A-0> <ESC>0
  inoremap <A-$> <ESC>$
  inoremap <A-v> <ESC>lv
  inoremap <A-n> <ESC>n
  inoremap <A-S-n> <ESC><S-n>
  imap <A-f> <ESC>f
  noremap <A-h> h 
  noremap <A-j> j
  noremap <A-k> k
  noremap <A-l> l
  noremap <A-b> b
  noremap <A-w> w

      "" modifications
  inoremap <A-o> <ESC>o
  inoremap <A-S-o> <ESC><S-o>
  inoremap <A-x> <ESC>lx
  inoremap <A-S-d> <ESC>l<S-d>
  inoremap <A-d>w <ESC>ldw
  inoremap <A-u> <ESC>u
  inoremap <A-C-r> <ESC><C-r>
  inoremap <A-p> <ESC>p
  inoremap <A-S-p> <ESC><S-p>
  inoremap <A-S-a> <ESC><S-a>
endfunction

if has("gui_running") 
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  set guioptions-=l  "remove left-hand scroll bar
  set guifont=Monospace\ 12
  set guioptions+=c  "remove left-hand scroll bar
  set winaltkeys=no
  call Gui_shortcuts()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeIgnore=['\.o$', '\~$', '\.orig$', '\.aux$','\.fls$', '\.out$','\.toc$','\.log$','\.fdb_latexmk$', '\.idx$', '\.ilg$', '\.ing$', '\.ind$']

"open a NERDTree automatically when vim starts up if no files were specified
autocmd! vimenter
autocmd vimenter * if !argc() | NERDTree | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NerdtreePluginOpen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:nerdtree_plugin_open_cmd = g:myOpenCmd 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => astyle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"noremap <F12> :w <CR> :silent !astyle --quiet --style=1tbs --indent=spaces=4 --pad-oper --pad-header --align-reference=type --add-brackets --convert-tabs % <CR> :e % <CR> :redraw! <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => clang-format
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clang_format_path = "clang-format-3.8"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on

let g:NERDCustomDelimiters = {
  \ 'mcproxy': { 'left': '#' }
  \}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '!'
"let g:syntastic_cpp_compiler_options = '-std=c++11'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => youcompleteme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader><leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
noremap <leader><leader>d :YcmCompleter GetDoc<CR>

"let g:ycm_filetype_whitelist = { 'latex': 1 }
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '!'

"let g:ycm_python_binary_path = '/usr/bin/python3.5'
"let g:ycm_python_binary_path = '/usr/bin/python'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ultrasnipts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

"let g:UltiSnipsSnippetDirectories  = ["snips"]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gnu debugger
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"noremap <leader><leader>d :Pyclewn<CR> :Cmapkeys<CR> :Cshell setsid lxterminal -e inferior_tty.py &<CR> :Cset environment TERM = xtermy<CR> :Cset inferior-tty /dev/pts/
            "lxterminal is the lubuntu terminal instead of it you can use
            "xterm ...
            "next commands: enter the terminal number
            "               Cfile <binary>
            "               Cstart
            "to debug stl containter see .gdbinit or http://www.yolinux.com/TUTORIALS/GDB-Commands.html#STLDEREF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ligthline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2


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

function! s:goyo_before()
  "call NumbersToggle()
  
  call NumbersDisable()
  set nonumber
  set norelativenumber
endfunction

function! s:goyo_after()
  call NumbersEnable()
  set number
  set relativenumber
endfunction

let g:goyo_callbacks = [function('s:goyo_before'), function('s:goyo_after')]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:ctrlp_custom_ignore = {
  "\ 'file': '\v\.(o|orig|swp)$'
  "\ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimwiki 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let wiki = {}
let wiki.path = '~/Dropbox/MyWiki/'
let wiki.path_html = '~/Dropbox/MyWiki/'

"let wiki.template_path = '~/Dropbox/MyDB/.html/vimwiki-assets'
"let wiki.template_default = 'default'
"let wiki.template_ext = '.html'

let wiki.auto_export = 0 
let wiki.ext = '.mywiki'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'shell': 'sh', 'sshconfig': 'sshconfig', 'gitconfig': 'gitconfig'}
let g:vimwiki_list = [wiki]


let g:vimwiki_ext2syntax = {'.mywiki': 'default'} 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => www  (https://github.com/waiting-for-dev/www.vim)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:www_urls = {
  \ 'd?' : 'http://www.dict.cc/?s=',
  \ 'g?' : 'https://www.google.com/search?q=',
  \ 'c?' : 'http://en.cppreference.com/w/cpp/io/',
  \ 'te?' : 'https://translate.google.de/#en/de/',
  \ 'td?' : 'https://translate.google.de/#de/en/',
  \ }


let g:www_default_search_engine = 'g?'

"dict.cc
vnoremap <leader>wd :call www#www#open_reference('d?'.@*)<CR>
nnoremap <leader>wd :call www#www#open_reference('d?'.expand("<cWORD>"))<CR>

"google.de
vnoremap <leader>wg :call www#www#open_reference('g?'.@*)<CR>
nnoremap <leader>wg :call www#www#open_reference('g?'.expand("<cWORD>"))<CR>

"cppreference.com
vnoremap <leader>wc :call www#www#open_reference('c?'.@*)<CR>
nnoremap <leader>wc :call www#www#open_reference('c?'.expand("<cWORD>"))<CR>

"google translater
vnoremap <leader>wte :call www#www#open_reference('te?'.@*)<CR>
nnoremap <leader>wte :call www#www#open_reference('te?'.expand("<cWORD>"))<CR>
vnoremap <leader>wtd :call www#www#open_reference('td?'.@*)<CR>
nnoremap <leader>wtd :call www#www#open_reference('td?'.expand("<cWORD>"))<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Unite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap - :Unite -toggle -start-insert<CR>
noremap <C-p> :Unite -start-insert file_rec/async<CR>
inoremap <C-p> <ESC>:Unite -start-insert file_mru file_rec/async<CR>

"mru (most recently used) 
let g:neomru#file_mru_path=$HOME.'/.vim/unite_mru.txt'
let g:neomru#file_mru_limit=5000 
    "restrict the files to the current project or the current directory
call unite#custom#source('neomru/file', 'matchers', ['matcher_project_files', 'matcher_fuzzy'])

"history yank
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit = 1000 "default 100
let g:unite_source_history_yank_file=$HOME.'/.vim/unite_yankring.txt'
let g:unite_source_history_yank_save_clipboard = 1

"file recursive search
let g:unite_source_rec_max_cache_files = 0
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 200)
call unite#filters#matcher_default#use(['matcher_fuzzy'])

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  nmap <buffer> <ESC> <Plug>(unite_exit)

  nmap <buffer> <F9> <Plug>(unite_exit)
  imap <buffer> <F9> <Plug>(unite_exit)

  nmap <buffer> <F5> <Plug>(unite_redraw)
  imap <buffer> <F5> <Plug>(unite_redraw)

  imap <buffer> <A-f> <Plug>(unite_quick_match_default_action)

  "CTRL-P like commands
  imap <buffer><expr> <C-c> unite#do_action('choose') 
  nmap <buffer><expr> <C-c> unite#do_action('choose') 

  imap <buffer><expr> <C-t> unite#do_action('tabopen') 
  nmap <buffer><expr> <C-t> unite#do_action('taboopen') 

  imap <buffer><expr> <C-r> unite#do_action('switch') 
  nmap <buffer><expr> <C-r> unite#do_action('switch') 

  imap <buffer><expr> <C-s> unite#do_action('split') 
  nmap <buffer><expr> <C-s> unite#do_action('split') 

  imap <buffer><expr> <C-o> unite#do_action('right') 
  nmap <buffer><expr> <C-o> unite#do_action('right') 
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-wholelinecolor
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:wholelinecolor_leader = g:mapleader
let g:wholelinecolor_next = '<nop>'
let g:wholelinecolor_prev = '<nop>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vlc remote control
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Vlc()
  let g:qdbus_path= "/usr/lib/x86_64-linux-gnu/qt4/bin/"
  let g:qdbus_vlc_cmd = "qdbus org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player."
  let g:vlc_cmd = g:qdbus_path.g:qdbus_vlc_cmd

  "/usr/lib/x86_64-linux-gnu/qt4/bin/qdbusviewer
  "qdbus org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
  noremap <C-v> :execute system(qdbus_path."qdbusviewer&")<CR>
  noremap <Space> :execute system(vlc_cmd."PlayPause")<CR>
endfunction 

let g:myOpenCmd = "gnome-open"
noremap <leader><leader>pf :hardcopy > %.ps<CR> :!ps2pdf %".ps" %.pdf<CR> :!rm %.ps<CR> :execute system(g:myOpenCmd." ".expand("%").".pdf")<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => my scripts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"inverse return
inoremap <S-CR> <ESC>lDO<ESC>p0i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => test function 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Test() range
  "echom a:firstline . ':' . a:lastline
  echo "bobbobobobo"
endfunction 

"noremap <F4> :call TestFunction() <CR>
