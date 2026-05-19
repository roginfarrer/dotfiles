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
			{
				'<leader>u',
				function()
					local was_disabled = vim.b.disable_autoformat
					vim.cmd 'FormatDisable'
					vim.cmd 'write'
					if not was_disabled then
						vim.cmd 'FormatEnable'
					end
				end,
				desc = 'Save without formatting',
			},
		},
		init = function()
			vim.o.formatoptions = 'jcroqlnt' -- tcqj
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr({'timeout_ms': 2000})"
			vim.g.conform_disable_format_on_save_ft = { mustache = true }

			vim.api.nvim_create_user_command('FormatDisable', function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = 'Disable autoformat-on-save',
				bang = true,
			})
			vim.api.nvim_create_user_command('FormatEnable', function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = 'Re-enable autoformat-on-save',
			})
		end,
		opts = function()
			local prettier = { 'prettier', stop_after_first = true }
			local util = require 'conform.util'
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
					fracjson = {
						meta = {
							url = 'https://github.com/j-brooke/FracturedJson',
							description = 'Reformats a JSON document to make it highly human-readable.',
						},
						command = 'fracjson',
						args = function(_, ctx)
							local config = vim.fs.find(
								{ '.fracturedjson', '.fracturedjson.jsonc', '.fracturedjson.json' },
								{ upward = true, path = ctx.dirname }
							)[1]
							vim.print(config)
							if config then
								return { '--config', config }
							end
							return {}
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
					-- markdown = { 'djlint' },
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
				format_on_save = function(bufnr)
					local disable_filetypes = vim.g.conform_disable_format_on_save_ft or {}
					local format_on_save_disabled = vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat

					if format_on_save_disabled or disable_filetypes[vim.bo[bufnr].filetype] then
						return
					end

					return {
						timeout_ms = 2000,
						lsp_format = 'fallback',
					}
				end,
			}
		end,
	},
}
