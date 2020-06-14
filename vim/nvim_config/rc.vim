"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:myOpenCmd = "xdg-open"
let g:mapleader = ","
" swap directory
set directory=~/.config/nvim/swap/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme falcon
highlight ColorColumn ctermbg=0 guibg=#3e3e40 " Colored columns are dark grey.
" TODO how to use a terminal in a terminal
"set scrolloff=7     " Keep 7 lines above and below the cursor.
set number          " Print the line number in front of each line.
set relativenumber  " Show line numbers relative to the current line.
set ignorecase      " ignore case when searching
set smartcase       " when searching try to be smart about cases
set showmatch       " show matching brackets when text indicator is over them
set expandtab       " expand tabs with whitespaces"
set tabstop=2
set softtabstop=-1  " make 'softtabstop' follow 'shiftwidth'
set shiftwidth=0    " make 'shiftwidth' follow 'tabstop'
set mouse=a         " enable the use of the mouse
set hlsearch        " highlights all search matches

" disable the nasty command mode
noremap <S-q> <nop>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" :W saves the file even with sudo privileges
command! W call My_sudo_write()
function! My_sudo_write()
  "overrides the current file with the content of the current buffer
  "and reloads the the file
  execute "write !sudo tee % > /dev/null"
  execute ":edit!"
endfunction

" Toggles search highlighting
noremap <Leader><Leader>h :set hlsearch! hlsearch?<CR>
" Quit a buffer
noremap <A-q> :quit<CR>
noremap <A-S-q> :quit!<CR>
inoremap <A-q> <ESC>:quit<CR>
inoremap <A-S-q> <ESC>:quit!<CR>
tnoremap <A-q> <C-\><C-n>:quit<CR>
" Save a buffer
noremap <A-w> :wall<CR>
inoremap <A-w> <ESC>:wall<CR>

autocmd! BufNewFile,BufRead \v*.mywiki|*.tex|*.txt|README|*.md|COMMIT_EDITMSG|de.utf-8.add call Set_options_for_texting()
autocmd! BufNewFile,BufRead \v*.c|*.cpp|*.h|*.hpp call Set_options_for_cpp_coding()
autocmd! BufNewFile,BufRead,BufWritePost    \v.vimrc|*.vim call Set_options_for_vimrc()

" TODO this might be outdated fix me
function! Set_options_for_cpp_coding()
  set cursorline " its to CPU-intensive in latex files
  call Set_makefile_shortcut()
  noremap <F6> :cnext<CR>
  noremap <F7> :cprevious<CR>
  set colorcolumn=80
  noremap <F12> :ClangFormat<CR>
endfunction

function! Set_options_for_texting()
  setlocal spell spelllang=de,en_us

  call Set_makefile_shortcut()

  " Next wrong word
  noremap <F6> ]s

  " Previous wrong word
  " h is a bugfix: I had a problem with a latex file and the keybinding
  " ]s. It jumps to the second letter of the next wrong written word, which blocks the backword jump .. for whatever reason
  noremap <F7> h[s
endfunction

function! Set_options_for_vimrc()
  " Reload the vimrc file
  noremap <F5> :source %<CR>
endfunction

function! Set_makefile_shortcut()
  noremap <A-b> :make!<CR> :copen<CR><C-W><S-J> :redraw!<CR>
  noremap <A-S-b> :make clean<CR> :copen<CR><C-W><S-J> :redraw!<CR>
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neovim terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! DoLcdToCurrentPath()
  " source https://github.com/neovim/neovim/issues/4299
  let l:procid = matchstr(bufname(""), '\(://.*/\)\@<=\(\d\+\)')
  if l:procid != ""
    let l:proc_cwd = resolve('/proc/'.l:procid.'/cwd')
    execute 'lcd '.l:proc_cwd
  endif
endfunction

" a terimal is allways entered in insert mode
autocmd! TermOpen * startinsert
autocmd! BufEnter term://* startinsert

" ESC in terminal
tnoremap <A-Esc> <C-\><C-n>
" Move left, right, up, down
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l
inoremap <A-h> <ESC><C-w>h
inoremap <A-j> <ESC><C-w>j
inoremap <A-k> <ESC><C-w>k
inoremap <A-l> <ESC><C-w>l
" Open terminal in a new tab, horizontal split and vertical split
" enew | call termopen('...') | startinsert
nnoremap <A-t> :call DoLcdToCurrentPath()<CR>:tabe<CR>:terminal<CR>
nnoremap <A-o> :call DoLcdToCurrentPath()<CR>:new<CR>:terminal<CR>
nnoremap <A-e> :call DoLcdToCurrentPath()<CR>:vnew<CR>:terminal<CR>
inoremap <A-t> <ESC>:tabe<CR>:terminal<CR>
inoremap <A-o> <ESC>:new<CR>:terminal<CR>
inoremap <A-e> <ESC>:vnew<CR>:terminal<CR>
tnoremap <A-t> <C-\><C-n>:call DoLcdToCurrentPath()<CR>:tabe<CR>:terminal<CR>
tnoremap <A-o> <C-\><C-n>:call DoLcdToCurrentPath()<CR>:new<CR>:terminal<CR>
tnoremap <A-e> <C-\><C-n>:call DoLcdToCurrentPath()<CR>:vnew<CR>:terminal<CR>
" Paste buffer to command line
" temporary fix for https://github.com/equalsraf/neovim-qt/issues/215
tnoremap <A-v> <C-\><C-n>"+pi

" Operations on Tabs
nnoremap <A-n> :+tabnext<CR>
inoremap <A-n> <ESC>:+tabnext<CR>
tnoremap <A-n> <C-\><C-n>:+tabnext<CR>
nnoremap <A-p> :-tabnext<CR>
inoremap <A-p> <ESC>:-tabnext<CR>
tnoremap <A-p> <C-\><C-n>:-tabnext<CR>

nnoremap <A-S-n> :+tabmove<CR>
inoremap <A-S-n> <ESC>:+tabmove<CR>
tnoremap <A-S-n> <C-\><C-n>:+tabmove<CR>
nnoremap <A-S-p> :-tabmove<CR>
inoremap <A-S-p> <ESC>:-tabmove<CR>
tnoremap <A-S-p> <C-\><C-n>:-tabmove<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Undotree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set undodir=~/.config/nvim/undo "where to save undo histories
set undofile            "Save undo's after file closes


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerdtree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeIgnore=['\.o$', '\~$', '\.orig$', '\.aux$','\.fls$', '\.out$','\.toc$','\.log$','\.fdb_latexmk$', '\.idx$', '\.ilg$', '\.ing$', '\.ind$']

nnoremap <Leader>n :NERDTreeFind<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerdtree plugin open
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:nerdtree_plugin_open_cmd = g:myOpenCmd


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerdcommenter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDCustomDelimiters = {
  \ 'mcproxy': { 'left': '#' },
  \ 'json': { 'left': '//' }
  \}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2 " the windows will always have a status line
" Hides the mode information like INSERT or VISUAL in the bottom line
set noshowmode

let g:lightline = {
\ 'colorscheme': 'falcon',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'component_function': {
\   'cocstatus': 'coc#status'
\ },
\ }

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()



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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimwiki
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimwiki_ext2syntax = {'.mywiki': 'default'}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => www
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:www_engines = {
  \ 'dict' : 'http://www.dict.cc/?s=',
  \ 'cpp' : 'http://en.cppreference.com/mwiki/index.php?search=',
\}

let g:www_shortcut_engines = {
  \ 'google': ['Wgoogle', '<Leader>wg'],
  \ 'dict': ['Wdict', '<Leader>wd'],
  \ 'cpp': ['Wcpp', '<Leader>wc'],
\}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CtrlP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<C-p>'

let g:ctrlp_custom_ignore = {
  \ 'file': '\v\.(o|cxx|d)$'
  \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => taboo.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:taboo_tab_format = "%N-%f "
let g:taboo_renamed_tab_format = "%N-%l "


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => falcon colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:falcon_lightline = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => my scripts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" inverse return
inoremap <S-CR> <CR><ESC>ddkPi
" creates a pdf of the current buffer
noremap <Leader><Leader>pf :hardcopy > %.ps<CR> :!ps2pdf %".ps" %.pdf<CR> :!rm %.ps<CR> :execute system(g:myOpenCmd." ".expand("%").".pdf")<CR>
" a quick terminal session
"function! NewNeovimSession()
  "execute "terminal"
  "execute "vnew"
  "execute "terminal"
"endfunction
