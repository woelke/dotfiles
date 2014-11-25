#!/usr/bin/vim 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vim_bundles.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general settings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"be improved
set nocompatible  

let s:myOpenCmd = "gnome-open"

let mapleader = ","

" Set to auto read when a file is changed from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu "auto completion for vim commands

colorscheme molokai
set shell=/bin/bash\ -i 
syntax on
set number
set ignorecase "Ignore case when searching
set smartcase "When searching try to be smart about cases
set incsearch "Makes search act like search in modern browsers
set showmatch "Show matching brackets when text indicator is over them
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start " backspacing over autoindent, line breaks, start of insert
set expandtab "expand tabs with whitespaces"
set mouse=a
hi Search ctermbg=7 "grey
set cindent
set hlsearch
set autowriteall
set cryptmethod=blowfish

"speed up vim
set synmaxcol=2000
set ttyfast "u got a fast terminal
set lazyredraw " to avoid scrolling problems

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => short keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

noremap <leader><leader>h :set hlsearch! hlsearch?<CR>
noremap <leader><leader>l :set cursorline! cursorline?<CR> 
noremap <leader><leader>b :!bash<CR>
noremap <leader><leader>i :set cindent! cindent?<CR>

noremap <leader><leader>pp :hardcopy > this_file_is_for_printing_only.ps<CR> :!gtklp this_file_is_for_printing_only.ps<CR> :!rm this_file_is_for_printing_only.ps<CR>
noremap <leader><leader>pf :hardcopy > %.ps<CR> :!ps2pdf %".ps" %.pdf<CR> :!rm %.ps<CR> :!pdf %.pdf<CR>

noremap <F9> :q<CR> 
inoremap <F9> <ESC>:q<CR> 
noremap <F8> :wa<CR>
inoremap <F8> <ESC>:wa<CR>

autocmd! BufNewFile,BufRead \v*.mywiki|*.tex|README|*.md|COMMIT_EDITMSG|de.utf-8.add call Set_options_for_texting()
autocmd! BufNewFile,BufRead \v*.c|*.cpp|*.h|*.hpp call Set_options_for_coding()
autocmd! BufNewFile,BufRead,BufWritePost    \v.vimrc|*.vim call Set_options_for_vimrc()

function! Set_options_for_coding() 
    set cursorline "its to cpu CPU-intensive in latex files

    call Set_makefile_shortcut_F5()
    noremap <F6> :cnext<CR>
    noremap <F7> :cprevious<CR> 
    "noremap <F12> :ClangFormat<CR>
endfunction 

function! Set_options_for_texting()
    setlocal spell spelllang=de,en

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
    noremap <F5> :make<CR> :copen<CR> :redraw!<CR>
    noremap <S-F5> :make clean<CR> :copen<CR> :redraw!<CR>
    noremap <C-S-F5> :make ARGS=% run<CR> :copen<CR> :redraw!<CR>
endfunction 


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
let g:nerdtree_plugin_open_cmd = s:myOpenCmd 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => astyle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <F12> :w <CR> :silent !astyle --quiet --style=1tbs --indent=spaces=4 --pad-oper --pad-header --align-reference=type --add-brackets --convert-tabs % <CR> :e % <CR> :redraw! <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => clang-format
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:clang_format#detect_style_file = 1


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
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
let g:syntastic_cpp_compiler_options = '-std=c++11'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => youcompleteme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader><leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>

"let g:ycm_filetype_whitelist = { 'latex': 1 }
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1

let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '!'


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
noremap <leader><leader>d :Pyclewn<CR> :Cmapkeys<CR> :Cshell setsid lxterminal -e inferior_tty.py &<CR> :Cset environment TERM = xtermy<CR> :Cset inferior-tty /dev/pts/
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
let g:ctrlp_custom_ignore = {
  \ 'file': '\v\.(o|orig|swp)$'
  \ }

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
" => my scripts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"inverse return
inoremap <S-CR> <ESC>lDO<ESC>p0i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => test function 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Test()
echo "bobbobobobo"
endfunction 

"noremap <F4> :call TestFunction() <CR>
