-- vim.loader.enable()

local ok, lconfig = pcall(require, 'local-config')
if type(lconfig) == 'table' and lconfig.before then
	lconfig.before()
end

require 'config.options'
require 'config.keymaps'
require 'config.lazy'
require 'config.autocmds'
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
	-- require 'ui.winbar'
	-- vim.cmd.colorscheme 'rose-pine'
	-- vim.cmd.colorscheme 'tokyonight'
	-- vim.cmd.colorscheme 'github_dark'
	vim.cmd.colorscheme 'catppuccin-mocha'
	-- vim.cmd.colorscheme 'nordic'
	-- vim.cmd [[colorscheme catppuccin]]
	-- vim.cmd.colorscheme 'tokyonight-day'
	-- vim.cmd [[colorscheme github_light]]
end

if type(lconfig) == 'table' and lconfig.after then
	lconfig.after()
end

-- Enable the new experimental command-line features.
-- require('vim._extui').enable {}
