vim.api.nvim_create_user_command('LspInfo', '<cmd>checkhealth vim.lsp', { desc = ':checkhealth vim.lsp' })

vim.api.nvim_create_user_command('LspLog', function()
	local log_path = vim.lsp.log.get_filename()
	if vim.fn.filereadable(log_path) == 1 then
		vim.cmd('edit ' .. log_path)
	else
		vim.notify('LSP log file not found: ' .. log_path, vim.log.levels.ERROR)
	end
end, { desc = 'Open LSP log file' })
