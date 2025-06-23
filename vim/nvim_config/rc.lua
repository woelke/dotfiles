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

