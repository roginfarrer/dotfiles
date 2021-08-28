-- Some handy toggles for trying to setups
vim.g.use_nvim_lsp = true

_G.global = {}

pcall(require, 'local-config')

require('pluginList')
require('settings')
require('autocmds')
require('keybindings')

if vim.g.use_nvim_lsp then
	require('plugins.lsp')
end
