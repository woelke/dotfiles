" This file is only loaded by novim guis

" Enable 24-bit color for GUIs (suggested by falcon color scheme)
set termguicolors

" configuration for neovim-qt
if exists('g:GuiLoaded')
  " nvim-qt does not support colorscheme facon and Fira Code
  :colorscheme molokai
  :Guifont DejaVu Sans Mono:h12
endif

" Configuration for neovim-gtk
if exists('g:GtkGuiLoaded')
  call rpcnotify(1, 'Gui', 'Font', 'Fira Code 11')
  call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
endif
