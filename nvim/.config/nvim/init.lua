vim.loader.enable()

pcall(require, 'local-config')
require 'config.options'
require 'config.keymaps'
require 'config.lazy'
require 'config.autocmds'
require 'config.filetype'
require 'config.gui'
-- require 'ui.winbar'
vim.cmd.colorscheme 'rose-pine'
-- vim.cmd [[colorscheme catppuccin]]
-- vim.cmd [[colorscheme catppuccin]]
-- vim.cmd [[colorscheme tokyonight-day]]
-- vim.cmd [[colorscheme github_light]]
