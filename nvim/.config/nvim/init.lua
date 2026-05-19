-- vim.loader.enable()

local ok, lconfig = pcall(require, 'local-config')
if type(lconfig) == 'table' and lconfig.before then
	lconfig.before()
end

if vim.fn.has 'nvim-0.12.0' then
	require('vim._core.ui2').enable {
		enable = true,
		msg = {
			targets = {
				[''] = 'msg',
				empty = 'cmd',
				bufwrite = 'msg',
				confirm = 'cmd',
				emsg = 'pager',
				echo = 'msg',
				echomsg = 'msg',
				echoerr = 'pager',
				completion = 'cmd',
				list_cmd = 'pager',
				lua_error = 'pager',
				lua_print = 'msg',
				progress = 'pager',
				rpc_error = 'pager',
				quickfix = 'msg',
				search_cmd = 'cmd',
				search_count = 'cmd',
				shell_cmd = 'pager',
				shell_err = 'pager',
				shell_out = 'pager',
				shell_ret = 'msg',
				undo = 'msg',
				verbose = 'pager',
				wildlist = 'cmd',
				wmsg = 'msg',
				typed_cmd = 'cmd',
			},
		},
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
		'<leader>xu',
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
