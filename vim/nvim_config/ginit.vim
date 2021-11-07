" This file is only loaded by novim guis

" Enable 24-bit color for GUIs (suggested by falcon color scheme)
set termguicolors

" Configuration for neovim-gtk
if exists('g:GtkGuiLoaded')
  call rpcnotify(1, 'Gui', 'Font', 'Fira Code 11')
  call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
endif

" Configuration for neovide
if exists('g:neovide')
  let g:neovide_cursor_animation_length=0
  let g:neovide_cursor_trail_length=0
  let g:neovide_cursor_antialiasing=v:false
  let g:neovide_refresh_rate=60
  " Seems not to work in ginit.vim I have to the guifont in init.vim
  " At the moment neovide has no faulback font so I need DejaVu
  " for the cool unicode icons
  set guifont=firacode,DejaVu\ Sans\ Mono:h15
endif

