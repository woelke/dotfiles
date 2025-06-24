fnction load_plugins() return {

-- Color schemes
{
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  name = 'catppuccin' ,
},

-- Commenting of code
{ 'preservim/nerdcommenter' },

-- Preserver the layout of windows when deleteing buffers
{ 'ojroques/nvim-bufdel' },

-- Search engine
{ 'junegunn/fzf' },
{ 'junegunn/fzf.vim' },

-- Vim start search without first jump
{ 'linjiX/vim-star' },

-- Provides a start screen for Vim and Neovim.
{
  'mhinz/vim-startify',
  lazy = false,
},

-- Highlights trailing withespaces and can delete them
{ 'ntpeters/vim-better-whitespace' },

-- Allows to rename tabs
{ 'gcmt/taboo.vim' },

-- Opens URLs in browser
{ 'waiting-for-dev/www.vim' },

-- A wiki for vim
{ 'vimwiki/vimwiki' },

-- A visual undo tree which can be travered
{ 'mbbill/undotree' },

-- Simplifies and quickens motions
{ 'Lokaltog/vim-easymotion' },

-- A Neovim statusline written in Lua.
{
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' }
},

-- VSCode Intellisense engine
{
  'neoclide/coc.nvim',
  branch = 'release',
},

-- Filesystem navigator
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false, -- neo-tree will lazily load itself
},

} end
