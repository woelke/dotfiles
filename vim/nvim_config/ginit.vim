" This file is only loaded by novim guis
 
" configuration for neovim-qt
if exists('g:GuiLoaded')
  :Guifont DejaVu Sans Mono:h12
endif

" Configuration for neovim-gtk
if exists('g:GtkGuiLoaded')
  call rpcnotify(1, 'Gui', 'Font', 'DejaVu Sans Mono 12')
  call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
endif
