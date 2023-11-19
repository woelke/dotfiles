--[[ This rc is required in the installation process
to download all plugins
Other configuration files are loaded later as many
commands require installed plugins ]]

dofile(vim.fn.expand('~') .. '/.config/nvim/nvim_config/plugins.lua')

vim.cmd [[
  function! InstallMe()
      :PlugInstall
      :PlugUpdate
      :qa!
  endfunction
]]
