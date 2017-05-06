"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => test function and miscellaneous
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Test()
  "echom a:firstline . ':' . a:lastline
  echo "bobbobobobo"
endfunction 
"noremap <F4> :call TestFunction() <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CamelCase to snake_case
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Convert NameLikeThis to name_like_this in current line. 
noremap <leader><leader>c :s#\C\(\<\u[a-z0-9]\+\\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g<CR><S-v>gu
