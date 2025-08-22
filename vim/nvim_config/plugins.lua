function load_plugins() return {

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

-- Vim start search without first jump
{ 'linjiX/vim-star' },

-- Highlights trailing withespaces and can delete them
{ 'ntpeters/vim-better-whitespace' },

-- Allows to rename tabs
{ 'gcmt/taboo.vim' },

-- Opens URLs in browser
{ 'waiting-for-dev/www.vim' },

-- A visual undo tree which can be travered
{ 'mbbill/undotree' },

-- Simplifies and quickens motions
{
    'smoka7/hop.nvim',
    version = "*",
    opts = {
        keys = 'etovxqpdygfblzhckisuran'
    }
},


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
    {
      "s1n7ax/nvim-window-picker", -- for open_with_window_picker keymaps
      version = "2.*",
      config = function()
        require("window-picker").setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { "quickfix" },
            },
          },
        })
      end,
    },
  },
  lazy = false, -- neo-tree will lazily load itself
},


-- Provides a start screen
{
  "goolord/alpha-nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local startify = require("alpha.themes.startify")
    startify.file_icons.provider = "devicons"
    require("alpha").setup(
      startify.config
    )
  end,
},

-- Plugin to improve viewing Markdown files in Neovim
{
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  config = function()
      require('render-markdown').setup({})
  end,
},

-- Search engine
{
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {}
},

-- Dynamic font scaling to modern neovim GUI clients
{ "tenxsoydev/size-matters.nvim" },

} end
