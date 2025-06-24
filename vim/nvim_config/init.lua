local home = vim.fn.expand('~') .. '/.config/nvim/nvim_config/'

dofile(home .. 'bootstrap_lazy.lua')

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","

dofile(home .. 'plugins.lua')

-- Setup lazy.nvim
require("lazy").setup({
  spec = load_plugins(),
  checker = { enabled = false }, -- automatically check for plugin updates
})

dofile(home .. 'rc.lua')
vim.cmd 'source ~/.config/nvim/nvim_config/rc.vim'

 dofile(home .. 'coc.lua')
 vim.cmd 'source ~/.config/nvim/nvim_config/tmp.vim'

if vim.g.neovide then
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_scroll_animation_far_lines = 0
    vim.g.neovide_scroll_animation_length = 0.00

    vim.o.guifont = "FiraCode Nerd Font:h12"
end
