local home = vim.fn.expand('~')

dofile(home .. '/.config/nvim/nvim_config/plugins.lua')
vim.cmd 'source ~/.config/nvim/nvim_config/rc.vim'

dofile(home .. '/.config/nvim/nvim_config/coc.lua')
vim.cmd 'source ~/.config/nvim/nvim_config/tmp.vim'

if vim.g.neovide then
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false

    vim.o.guifont = "Fira Code:h10"

    --vim.g.neovide_refresh_rate= 60
    --vim.g.neovide_profiler = true
end
