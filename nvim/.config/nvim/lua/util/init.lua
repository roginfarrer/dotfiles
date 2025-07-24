local M = {}

---@param ... any
M.dump = function(...)
	print(vim.inspect(...))
end

---@class KeymapUtil
---@field [1] string lhs
---@field [2] string|fun():string? rhs
---@field mode? string|string[]
---@field desc? string
---@field noremap? boolean
---@field remap? boolean
---@field expr? boolean
---@field nowait? boolean
---@field silent? boolean

---@param v KeymapUtil
M.keymap = function(v)
	local lhs = v[1]
	local rhs = v[2]

	vim.keymap.set(v.mode or 'n', lhs, rhs, {
		desc = v.desc,
		noremap = v.noremap == nil and true or v.noremap,
		remap = v.remap,
		expr = v.expr,
		nowait = v.nowait,
		silent = v.silent == nil and true or v.silent,
	})
end

M.is_apple_silicon = require('jit').arch == 'arm64'

---@param str string
M.termcodes = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---@param event any
---@param opts vim.api.keyset.create_autocmd
M.autocmd = function(event, opts)
	if opts.group then
		vim.api.nvim_create_autocmd(
			event,
			vim.tbl_extend(
				'force',
				opts,
				{ group = vim.api.nvim_create_augroup('rogin_' .. opts.group, { clear = true }) }
			)
		)
	else
		vim.api.nvim_create_autocmd(event, opts)
	end
end

---@param plugin string
M.has = function(plugin)
	return require('lazy.core.config').spec.plugins[plugin] ~= nil
end

---@param name string
---@param fn fun(name:string)
function M.on_plugin_load(name, fn)
	local Config = require 'lazy.core.config'
	if Config.plugins[name] and Config.plugins[name]._.loaded then
		fn(name)
	else
		vim.api.nvim_create_autocmd('User', {
			pattern = 'LazyLoad',
			callback = function(event)
				if event.data == name then
					fn(name)
					return true
				end
			end,
		})
	end
end

M.makeRelativePath = function(targetPath, basePath)
	-- Normalize the paths by removing trailing slashes
	targetPath = targetPath:gsub('[/\\]+$', '')
	basePath = basePath:gsub('[/\\]+$', '')

	-- Split the paths into components
	local targetComponents = {}
	for component in targetPath:gmatch '[^/\\]+' do
		table.insert(targetComponents, component)
	end

	local baseComponents = {}
	for component in basePath:gmatch '[^/\\]+' do
		table.insert(baseComponents, component)
	end

	-- Remove common components
	local i = 1
	while i <= #targetComponents and i <= #baseComponents and targetComponents[i] == baseComponents[i] do
		i = i + 1
	end

	-- Calculate the number of upward directories needed
	local upwardDirs = #baseComponents - i + 1
	local relativePath = {}

	for j = 1, upwardDirs do
		table.insert(relativePath, '..')
	end

	-- Add the remaining target components
	for j = i, #targetComponents do
		table.insert(relativePath, targetComponents[j])
	end

	return table.concat(relativePath, '/')
end

return M
