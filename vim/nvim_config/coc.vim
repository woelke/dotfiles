" Installed extensions
let g:coc_global_extensions = [
   \ 'coc-json',
   \ "coc-python",
   \ "coc-lists",
   \ "coc-pairs",
   \ "coc-clangd",
   \ "coc-vimtex"
   \ ]

" Extension Info
"coc-lists provides grep/rg via CocList

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" TODO: Untested
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" TODO: Untested
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
"if exists('*complete_info')
  "inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
  "inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif

nmap <silent> <Leader>fd <Plug>(coc-definition)
nmap <silent> <Leader>fi <Plug>(coc-implementation)
nmap <silent> <Leader>ft <Plug>(coc-type-definition)
nmap <silent> <Leader>fr <Plug>(coc-references)
nmap <silent> <Leader>fR :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" TODO seems not to work properly
" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <Leader>fn <Plug>(coc-rename)

" Formatting selected code.
"vmap <Leader>cf  <Plug>(coc-format-selected)
"nmap <Leader>cf  :call CocAction('format')<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
"vmap <Leader>ca  <Plug>(coc-codeaction-selected)<CR>
"nmap <Leader>caa  <Plug>(coc-codeaction-selected)<CR>
" TODO: Untested
"nmap <Leader>cqf  <Plug>(coc-fix-current)

" TODO: not realy working
" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"vmap ix <Plug>(coc-funcobj-i)
"vmap ax <Plug>(coc-funcobj-a)


" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <Leader>fa  :<C-u>CocList diagnostics<CR>
" Find symbol of current document.
"nnoremap <silent> <Leader>co  :<C-u>CocList outline<CR>
" Search workspace symbols.
"nnoremap <silent> <Leader>cs  :<C-u>CocList -I symbols<CR>
" Search workspace symbols.
"nnoremap <silent> <Leader>fg :<C-u>CocList grep<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc-json
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType json syntax match Comment +\/\/.\+$+

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => coc-clangd
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>fs :CocCommand clangd.switchSourceHeader<CR>
nnoremap <Leader>fT :CocCommand clangd.symbolInfo<CR>

