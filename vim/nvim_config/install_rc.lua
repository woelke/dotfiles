--[[ This rc is required in the installation process
to download all plugins
Other configuration files are loaded later as many
commands require installed plugins ]]

-- TODO can this file be removed?

dofile(home .. 'bootstrap_lazy.lua')
dofile(vim.fn.expand('~') .. '/.config/nvim/nvim_config/plugins.lua')

-- Setup lazy.nvim
require("lazy").setup({
  spec = load_plugins(),
  checker = { enabled = false }, -- automatically check for plugin updates
})

vim.cmd [[
  function! InstallMe()
      :PlugInstall
      :PlugUpdate
      :qa!
  endfunction
]]
