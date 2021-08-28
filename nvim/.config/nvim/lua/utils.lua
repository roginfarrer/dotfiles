local api = vim.api
local vimp = require('vimp')

local get_map_options = function(custom_options)
	local options = { noremap = true, silent = true }
	if custom_options then
		options = vim.tbl_extend('force', options, custom_options)
	end
	return options
end

local M = {}

M.map = function(mode, target, source, opts)
	api.nvim_set_keymap(mode, target, source, get_map_options(opts))
end

M.buf_map = function(mode, target, source, opts, bufnr)
	api.nvim_buf_set_keymap(bufnr, mode, target, source, get_map_options(opts))
end

M.command = function(name, fn)
	vim.cmd(string.format('command! %s %s', name, fn))
end

M.lua_command = function(name, fn)
	M.command(name, 'lua ' .. fn)
end

M.nnoremap = vimp.nnoremap
M.nmap = vimp.nmap
M.inoremap = vimp.inoremap
M.vnoremap = vimp.vnoremap
M.xnoremap = vimp.xnoremap
M.xmap = vimp.xmap
M.tnoremap = vimp.tnoremap

vimp.always_override = true

return M
