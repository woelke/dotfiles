---------------------------------------------------------------
---  General settings
---------------------------------------------------------------
vim.g.myOpenCmd = "xdg-open"
vim.g.mapleader = ","

vim.opt.directory = "~/.config/nvim/swap/" -- set swap directory

---------------------------------------------------------------
--- VIM user interface
---------------------------------------------------------------
require("catppuccin").setup({
    term_colors = true
})
vim.cmd.colorscheme "catppuccin-mocha"

vim.opt.number = true       -- print the line number in front of each line.
vim.opt.ignorecase = true   -- ignore case when searching
vim.opt.smartcase = true    -- when searching try to be smart about cases
vim.opt.showmatch = true    -- show matching brackets when text indicator is over them
vim.opt.expandtab = true    -- expand tabs with whitespaces"
vim.opt.tabstop = 2
vim.opt.softtabstop= -1     -- make 'softtabstop' follow 'shiftwidth'
vim.opt.shiftwidth = 0      -- make 'shiftwidth' follow 'tabstop'
vim.opt.mouse = "a"         -- enable the use of the mouse
vim.opt.hlsearch = true     -- highlights all search matches

---------------------------------------------------------------
--- lualine.nvim
---------------------------------------------------------------
local function current_buffer_num()
  return " " .. vim.fn.bufnr()
end


require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype', current_buffer_num},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {current_buffer_num},
    lualine_y = {'location'},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

---------------------------------------------------------------
--- nvim-bufdel
---------------------------------------------------------------

vim.keymap.set({'n', 'i'}, '<A-d>', '<cmd>BufDel<cr>')
vim.keymap.set({'n', 'i'}, '<A-S-d>', '<cmd>BufDel!<cr>')

