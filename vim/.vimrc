" .vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vim_bundles.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general settings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

" Set to auto read when a file is changed from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

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
set expandtab
set mouse=a
hi Search ctermbg=7 "grey
set cindent
set hlsearch
set autowriteall
set cryptmethod=blowfish


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

function! OpenUrlUnderCursor()
execute "normal BvEy"
let url=matchstr(@0, '[a-z]*:\/\/[^ >,;]*')
if url != ""
    "silent exec "!open -a ".path." '".url."'" | redraw! 
    silent exec "!xdg-open  '".url."'"  | redraw! 
    echo "opened ".url
else
    echo "No URL under cursor."
endif
endfunction
noremap <leader><leader>w :call OpenUrlUnderCursor()<CR>

noremap <leader><leader>pp :hardcopy > this_file_is_for_printing_only.ps<CR> :!gtklp this_file_is_for_printing_only.ps<CR> :!rm this_file_is_for_printing_only.ps<CR>
noremap <leader><leader>pf :hardcopy > %.ps<CR> :!ps2pdf %".ps" %.pdf<CR> :!rm %.ps<CR> :!pdf %.pdf<CR>

noremap <F9> :q<CR> 
inoremap <F9> <ESC>:q<CR> 
noremap <F8> :wa<CR>
inoremap <F8> <ESC>:wa<CR>

autocmd! BufNewFile,BufRead \v*.md|*.tex|README|*.md|COMMIT_EDITMSG call Set_options_for_texting()
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
    
    setlocal spell spelllang=en_us

    noremap <leader><leader>s :setlocal spell! spelllang=en_us<CR>
    call Set_makefile_shortcut_F5()

    "next wrong word
    noremap <F6> ]s 
    
    "previous wrong word
    noremap <F7> [s 
endfunction

function! Set_options_for_vimrc() 
    "reload the vimrc file
    noremap <F5> :source %<CR>
endfunction 

function! Set_makefile_shortcut_F5() 
    noremap <F5> :make<CR> :copen<CR> :redraw!<CR>
endfunction 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Undo files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undofile            "Save undo's after file closes
set undodir=~/.vim/undo "where to save undo histories


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gui options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=l  "remove left-hand scroll bar
set guifont=Monospace\ 12


let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 2
let s:maxfontsize = 60 
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
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

noremap <C-kPlus> :call AdjustFontSize(1)<CR>
noremap <C-kMinus> :call AdjustFontSize(-1)<CR>
noremap <C-kMultiply> :set guifont=Monospace\ 12<CR>
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
let g:nerdtree_plugin_open_cmd = 'gnome-open'

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
" => vim-translator
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goog_user_conf = { 'langpair': 'en|de', 'v_key': 'T' }


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

noremap <Leader>z :Goyo<CR>  

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
" => Fugitive 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>

"same as: git checkout %
nnoremap <silent> <leader>gr :Gread<CR>

"same as: git add %
nnoremap <silent> <leader>gw :Gwrite<CR> 

nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gi :Git add -p %<CR>

"small tool to indicate git dffs
nnoremap <silent> <leader>gg :SignifyToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-signify 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_disable_by_default = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => my scripts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"inverse return
inoremap <S-CR> <ESC>lDO<ESC>p0i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => test function 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! TestFunction()

    let i = 0

    while i < 10
        echo i . getline(i)
        let i += 1
    endwhile




endfunction 

noremap <F4> :call TestFunction() <CR>
