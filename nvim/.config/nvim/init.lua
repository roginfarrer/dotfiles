-- Some handy toggles for trying to setups
vim.g.use_nvim_lsp = true

_G.global = {}

-- Safely require it, in case it doesn't exist
pcall(require, 'local-config')

require('pluginList')
