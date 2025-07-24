return {
	{
		'stevearc/conform.nvim',
		event = 'BufWritePre',
		cmd = { 'ConformInfo' },
		keys = {
			{
				'gw',
				function()
					-- If you call conform.format when in visual mode, conform will perform a range format on the selected region.
					-- If you want it to leave visual mode afterwards (similar to the default gw or gq behavior), use this mapping:
					require('conform').format({ async = true }, function(err)
						if not err then
							local mode = vim.api.nvim_get_mode().mode
							if vim.startswith(string.lower(mode), 'v') then
								vim.api.nvim_feedkeys(
									vim.api.nvim_replace_termcodes('<Esc>', true, false, true),
									'n',
									true
								)
							end
						end
					end)
				end,
				desc = 'Format code',
				mode = { 'n', 'v' },
			},
		},
		init = function()
			if vim.fn.executable 'prettierd' then
				vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
					group = vim.api.nvim_create_augroup('RestartPrettierd', { clear = true }),
					pattern = '*prettier*',
					callback = function()
						vim.fn.system 'prettierd restart'
					end,
				})
			end
		end,
		opts = function()
			local prettier = { 'prettier', stop_after_first = true }
			return {
				formatters = {
					my_auto_indent = {
						format = function(_, ctx, _, callback)
							-- no range, use whole buffer otherwise use selection
							local cmd = ctx.range == nil and 'gg=G' or '='
							-- vim.cmd.normal { 'm`' .. cmd .. '``', bang = true }
							vim.cmd.normal { 'mqHmwgg=G`wzt`q', bang = true }
							callback()
						end,
					},
				},
				formatters_by_ft = {
					lua = { 'stylua' },
					-- Use a sub-list to run only the first available formatter
					javascript = prettier,
					javascriptreact = prettier,
					typescript = prettier,
					typescriptreact = prettier,
					css = prettier,
					html = prettier,
					markdown = prettier,
					mdx = prettier,
					astro = { 'prettier' },
					scss = prettier,
					yaml = prettier,
					json = prettier,
					jsonc = prettier,
					bash = { 'beautysh' },
					sh = { 'beautysh' },
					zsh = { 'beautysh' },
					fish = { 'fish_indent' },
				},
				default_format_opts = { lsp_format = 'fallback' },
				log_level = vim.log.levels.DEBUG,
				format_on_save = { timeout_ms = 2000 },
			}
		end,
	},
}
