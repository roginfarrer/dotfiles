vim.loader.enable()

pcall(require, 'local-config')
require 'config.options'
require 'config.keymaps'
require 'config.lazy'
require 'config.autocmds'
require 'config.filetype'
-- require 'ui.winbar'
vim.cmd [[colorscheme catppuccin]]
