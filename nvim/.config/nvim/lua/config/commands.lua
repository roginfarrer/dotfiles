vim.api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = ':checkhealth vim.lsp' })

vim.api.nvim_create_user_command('LspLog', function()
	local log_path = vim.lsp.log.get_filename()
	if vim.fn.filereadable(log_path) == 1 then
		vim.cmd('edit ' .. log_path)
	else
		vim.notify('LSP log file not found: ' .. log_path, vim.log.levels.ERROR)
	end
end, { desc = 'Open LSP log file' })

vim.api.nvim_create_user_command('Restart', function()
	if vim.fn.has 'nvim-0.12' == 0 then
		return vim.notify('`restart()` requires Neovim>=0.12', vim.log.levels.ERROR)
	end

	-- Compute session to write and restore
	local _, filename = vim.loop.fs_mkstemp 'restart_session_XXXXXX'
	local this_session = vim.fs.abspath(filename)
	local del_session = this_session

	-- Write session
	local session_arg = vim.fn.fnameescape(this_session)
	vim.cmd('mksession! ' .. session_arg)

	-- Restart Neovim and execute Lua commands to restore necessary session
	local after = {
		'vim.cmd("source ' .. session_arg .. '")',
		-- Restore 'termguicolors' manually since it is not (yet) autodetected
		'vim.o.termguicolors = ' .. tostring(vim.o.termguicolors),
		'vim.notify("Restarted session")',
	}
	if del_session ~= nil then
		table.insert(after, 2, 'pcall(vim.fs.rm, ' .. vim.inspect(this_session) .. ')')
		table.insert(after, 3, 'vim.v.this_session = ""')
	end
	local ok, msg = pcall(vim.cmd, 'restart lua ' .. table.concat(after, ';'))

	-- Ensure cleanup in case of an error restarting (like a modified buffer)
	if ok then
		return
	end
	if del_session then
		pcall(vim.fs.rm, this_session)
		vim.v.this_session = ''
	end
	vim.notify(msg, vim.log.levels.ERROR)
end, { desc = 'Restart with session' })
