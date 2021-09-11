_G.dump = function(...)
	print(vim.inspect(...))
end

-- Given a plugin name, returns a boolean if plugin is loaded
_G.isPackageLoaded = function(package)
	return packer_plugins[package] and packer_plugins[package].loaded
end

local M = {}

M.functions = {}

function M.execute(id)
	local func = M.functions[id]
	if not func then
		error('Function doest not exist: ' .. id)
	end
	return func()
end

local function map(mode, key, cmd, opts, defaults)
	opts = vim.tbl_deep_extend(
		'force',
		{ silent = true },
		defaults or {},
		opts or {}
	)

	if type(cmd) == 'function' then
		table.insert(M.functions, cmd)
		if opts.expr then
			cmd = ([[luaeval('require("utils").execute(%d)')]]):format(#M.functions)
		else
			cmd = ("<cmd>lua require('utils').execute(%d)<cr>"):format(#M.functions)
		end
	end
	if opts.buffer ~= nil then
		local buffer = opts.buffer
		opts.buffer = nil
		return vim.api.nvim_buf_set_keymap(buffer, mode, key, cmd, opts)
	else
		return vim.api.nvim_set_keymap(mode, key, cmd, opts)
	end
end

function M.map(mode, key, cmd, opt, defaults)
	return map(mode, key, cmd, opt, defaults)
end

function M.nmap(key, cmd, opts)
	return map('n', key, cmd, opts)
end
function M.vmap(key, cmd, opts)
	return map('v', key, cmd, opts)
end
function M.xmap(key, cmd, opts)
	return map('x', key, cmd, opts)
end
function M.imap(key, cmd, opts)
	return map('i', key, cmd, opts)
end
function M.omap(key, cmd, opts)
	return map('o', key, cmd, opts)
end
function M.smap(key, cmd, opts)
	return map('s', key, cmd, opts)
end
function M.tmap(key, cmd, opts)
	return map('t', key, cmd, opts)
end

function M.nnoremap(key, cmd, opts)
	return map('n', key, cmd, opts, { noremap = true })
end
function M.vnoremap(key, cmd, opts)
	return map('v', key, cmd, opts, { noremap = true })
end
function M.xnoremap(key, cmd, opts)
	return map('x', key, cmd, opts, { noremap = true })
end
function M.inoremap(key, cmd, opts)
	return map('i', key, cmd, opts, { noremap = true })
end
function M.onoremap(key, cmd, opts)
	return map('o', key, cmd, opts, { noremap = true })
end
function M.snoremap(key, cmd, opts)
	return map('s', key, cmd, opts, { noremap = true })
end
function M.tnoremap(key, cmd, opts)
	return map('t', key, cmd, opts, { noremap = true })
end

return M
