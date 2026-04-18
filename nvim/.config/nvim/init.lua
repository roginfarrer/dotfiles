-- vim.loader.enable()

local ok, lconfig = pcall(require, 'local-config')
if type(lconfig) == 'table' and lconfig.before then
	lconfig.before()
end

if vim.fn.has 'nvim-0.12.0' then
	require('vim._core.ui2').enable {
		enable = true,
		msg = { target = 'cmd' },
	}
end

require 'config.options'
require 'config.keymaps'
require 'config.lazy'
require 'config.autocmds'
require 'config.commands'
require 'config.filetype'
require 'config.gui'

if vim.fn.has 'nvim-0.12.0' then
	vim.cmd 'packadd nvim.undotree'
	require('util').keymap {
		'<leader>u',
		function()
			require('undotree').open()
		end,
		desc = 'Undotree',
	}
end

if not vim.g.vscode then
	local theme = require('last-color').recall() or 'catppuccin-mocha'
	vim.cmd.colorscheme(theme)
end

if type(lconfig) == 'table' and lconfig.after then
	lconfig.after()
end
