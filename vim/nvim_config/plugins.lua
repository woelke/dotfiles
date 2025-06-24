local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

-- Filesystem navigator
Plug 'preservim/nerdtree'
Plug 'aufgang001/vim-nerdtree_plugin_open'

-- Commenting of code
Plug 'preservim/nerdcommenter'

-- VSCode Intellisense engine
Plug('neoclide/coc.nvim', {['branch'] = 'release'})

-- Sematic highlighting
Plug 'jackguo380/vim-lsp-cxx-highlight'

-- Color schemes
Plug 'flazz/vim-colorschemes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'fenetikm/falcon'
Plug('catppuccin/nvim', {['as'] = 'catppuccin' })

-- A Neovim statusline written in Lua.
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons' -- Icons for status line


-- Simplifies and quickens motions
Plug 'Lokaltog/vim-easymotion'

-- Provides an visual undo tree which can be travered
Plug 'mbbill/undotree'

-- Allows distraction-free writing
Plug 'junegunn/goyo.vim'

-- A wiki for vim
Plug 'vimwiki/vimwiki'

-- Synatax highlighting pack
Plug 'sheerun/vim-polyglot'

-- Highlighting mcproxy config files
Plug 'mcproxy/vim-mcproxy_conf_highlighting'

-- My synconized spell files
Plug('aufgang001/vim-custom_spellfile', {['do'] = './install.sh nvim'})

-- Opens URLs in browser
Plug 'waiting-for-dev/www.vim'

-- Allows to rename tabs
Plug 'gcmt/taboo.vim'

-- Highlights trailing withespaces and can delete them
Plug 'ntpeters/vim-better-whitespace'

-- This plugin provides a start screen for Vim and Neovim.
Plug 'mhinz/vim-startify'

-- Latex live preview
Plug 'donRaphaco/neotex'

-- Vim start search without first jump
Plug 'linjiX/vim-star'

-- search engine
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

-- Preserver the layout of windows when deleteing buffers
Plug 'ojroques/nvim-bufdel'

vim.call('plug#end')
