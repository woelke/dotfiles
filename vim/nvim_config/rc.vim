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

autocmd! BufEnter \v*.mywiki|*.tex|*.txt|README|*.md|COMMIT_EDITMSG|de.utf-8.add call Set_options_for_texting()
autocmd! BufEnter \v*.c|*.cpp|*.h|*.hpp call Set_options_for_cpp_coding()
autocmd! BufEnter \v*.rs call Set_options_for_rust_coding()
autocmd! BufEnter coc-settings.json call Set_options_for_coc_settings()
autocmd! BufLeave * call Cleanup_options()

function! Cleanup_options()
  noremap <F5> <Nop>
  noremap <F12> <Nop>
  noremap <A-b> <Nop>
  noremap <A-S-b> <Nop>
endfunction

function! Set_options_for_cpp_coding()
  set cursorline " its to CPU-intensive in latex files
  call Set_makefile_shortcut()
  set colorcolumn=80
endfunction

function! Set_options_for_rust_coding()
  set cursorline " its to CPU-intensive in latex files
  set colorcolumn=80
  noremap <A-b> :!cargo build<CR>
  noremap <A-f> :wall<CR>:silent !cargo fmt<CR>
  inoremap <A-f> <ESC>:wall<CR>:silent !cargo fmt<CR>
endfunction


function! Set_options_for_texting()
  setlocal spell spelllang=de,en_us

  call Set_makefile_shortcut()
endfunction

function! Set_options_for_coc_settings()
  " Restart CoC
  noremap <F5> :CocRestart<CR>
endfunction

function! Set_makefile_shortcut()
  noremap <A-b> :make!<CR> :copen<CR><C-W><S-J> :redraw!<CR>
  noremap <A-S-b> :make clean<CR> :copen<CR><C-W><S-J> :redraw!<CR>
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => In Terminal Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Escape the terminal
tnoremap <A-Esc> <C-\><C-n>

" A terimal is allways opened in insert mode
autocmd! TermOpen * startinsert

" A terimal is allways entered in insert mode but this can be deactivated per
" terminal
nnoremap <Leader>i :call ToggleTerminalInsertMode()<CR>
tnoremap <Leader>i <C-\><C-n>:call ToggleTerminalInsertMode()<CR>

let b:InTerminalInsertMode=1
augroup startinsert_group
   autocmd!
   autocmd! BufEnter term://* :call StartTerminalInsert()
augroup END

function! StartTerminalInsert()
   if !exists('b:InTerminalInsertMode')
      let b:InTerminalInsertMode=1
   endif

   if b:InTerminalInsertMode
      startinsert
   endif
endfunction

function! ToggleTerminalInsertMode()
   if b:InTerminalInsertMode
      let b:InTerminalInsertMode=0
   else
      let b:InTerminalInsertMode=1
      startinsert
   endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Inter window navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! DoLcdToCurrentPath()
  " source https://github.com/neovim/neovim/issues/4299
  let l:procid = matchstr(matchstr(bufname(""), '\(://.*/\)\@<=\(\d\+\):/'), '\(\d\+\)')
  if l:procid != ""
    let l:proc_cwd = resolve('/proc/'.l:procid.'/cwd')
    execute 'lcd '.l:proc_cwd
  endif
endfunction

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

" paste from clipboard
tnoremap <A-v> <C-\><C-n>"+pi
inoremap <A-v> <ESC>"+pi
nnoremap <A-v> "+pi
nnoremap <S-A-v> h"+pi

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
" => easy motion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable default mappings
let g:EasyMotion_do_mapping = 0

let g:EasyMotion_smartcase = 1
let g:EasyMotion_space_jump_first = 1

map f <Plug>(easymotion-bd-f)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => taboo.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:taboo_tab_format = "%N-%f "
let g:taboo_renamed_tab_format = "%N-%l "

