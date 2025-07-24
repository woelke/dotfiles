--------------------------------------------------------------
--- General settings
---------------------------------------------------------------
vim.g.myOpenCmd = "xdg-open"

vim.opt.directory = "~/.config/nvim/swap/" -- set swap directory


--------------------------------------------------------------
--- Common functions
---------------------------------------------------------------
local function GetCwdFromCurrentTerminal()
  local bufname = vim.api.nvim_buf_get_name(0)

  local procid = bufname:match("://.-/(%d+):/")

  if procid then
    local proc_cwd = vim.fn.resolve(('/proc/%s/cwd'):format(procid))
    return proc_cwd
  end

  return nil
end

function GetSelectedText()
-- Yank current visual selection into the 'v' register
    -- Note that this makes no effort to preserve this register
    vim.cmd('noau normal! "vy"')
    return vim.fn.getreg('v')
end


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
--- shortcuts
---------------------------------------------------------------


---------------------------------------------------------------
--- lualine.nvim
---------------------------------------------------------------
local function current_buffer_num()
  return " " .. vim.fn.bufnr()
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'material',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = { 'neo-tree'},
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


---------------------------------------------------------------
--- neo-tree
---------------------------------------------------------------
require("neo-tree").setup({
  filesystem = {
    window = {
      mappings = {
        ["E"] = "system_open",
      },
    },
  },
  commands = {
    system_open = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      vim.fn.jobstart({ "xdg-open", path }, { detach = true })

      -- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
      local p
      local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
      if lastSlashIndex then
        p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
      else
        p = path -- If no slash found, return original path
          end
      vim.cmd("silent !start explorer " .. p)
        end,
  },
})

vim.keymap.set('n', '<leader>t', function()
  require('neo-tree.command').execute({
    position = 'left',
    reveal = true,
    dir = vim.fn.getcwd(),
  })
end)


---------------------------------------------------------------
--- fzf-lua
---------------------------------------------------------------
require('fzf-lua').setup({
    keymap = { } -- disable crazy default keymappings
})

vim.keymap.set('n', '<C-\\>', function()
  require('fzf-lua').files({
    cwd = vim.fn.getcwd(),
  })
end)

vim.keymap.set('t', '<C-\\>', function()
  require('fzf-lua').files({
    cwd = GetCwdFromCurrentTerminal(),
  })
end)


---------------------------------------------------------------
--- www
---------------------------------------------------------------
vim.g.www_engines = {
  kagi = 'https://kagi.com/search?q=',
  dict = 'https://www.dict.cc/?s=',
}

local function CreateWwwBindings(engine, mapping)
  vim.keymap.set('v', mapping, function()
      local selected_text = GetSelectedText()
      vim.cmd('Wsearch ' .. engine .. ' '.. selected_text)
  end, { desc = "kagi search selected text" })


  vim.keymap.set('n', mapping, function()
      local selected_text = vim.fn.expand("<cword>")
      vim.cmd('Wsearch ' .. engine .. ' '.. selected_text)
  end, { desc = "kagi search selected text" })
end

CreateWwwBindings('kagi', '<Leader>wg')
CreateWwwBindings('dict', '<Leader>wd')


---------------------------------------------------------------
--- vim star search
---------------------------------------------------------------
vim.keymap.set({'v', 'n'}, '*', '<Plug>(star-*)', { silent = true })


---------------------------------------------------------------
--- vim-better-whitespace
---------------------------------------------------------------
-- disable withespace info for terminals + keep the default filters
do
    local default_blacklist = {'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive'}
    local my_blacklist = {
        '', -- for the terminal
    }

    vim.g.better_whitespace_filetypes_blacklist = vim.list_extend(default_blacklist, my_blacklist)
end


---------------------------------------------------------------
--- my scripts
---------------------------------------------------------------

-- inverse return
vim.keymap.set('i', '<S-CR>', '<CR><ESC>ddkPi')


