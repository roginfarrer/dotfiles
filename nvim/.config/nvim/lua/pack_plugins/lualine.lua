vim.schedule(function()
	vim.pack.add { 'https://github.com/nvim-lualine/lualine.nvim' }

	-- PERF: we don't need this lualine require madness 🤷
	local lualine_require = require 'lualine_require'
	lualine_require.require = require

	local icons = require('util.icons').lazy

	require('lualine').setup {
		options = {
			theme = 'auto',
			component_separators = '',
			section_separators = { left = '', right = '' },
			icons_enabled = true,
			globalstatus = true,
			disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'snacks_dashboard' } },
		},
		sections = {
			lualine_a = { { 'mode', separator = { left = '' }, padding = { right = 1 } } },

			lualine_b = {
				{ 'branch' },
			},
			lualine_c = {
				{ 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
				{ 'filename', symbols = { modified = '', readonly = '', unnamed = '', newfile = '' } },
			},
			lualine_x = {
				{
					function()
						local reg = vim.fn.reg_recording()
						if reg == '' then
							return '' -- not recording
						end
						return 'recording to ' .. reg
					end,
				},
				{
					function()
						return '  ' .. require('dap').status()
					end,
					cond = function()
						return package.loaded['dap'] and require('dap').status() ~= ''
					end,
					-- color = Util.ui.fg("Debug"),
				},
			},
			lualine_y = {
				{
					'diagnostics',
					symbols = {
						error = icons.diagnostics.Error,
						warn = icons.diagnostics.Warn,
						info = icons.diagnostics.Info,
						hint = icons.diagnostics.Hint,
					},
				},
				{
					'diff',
					symbols = {
						added = icons.git.added,
						modified = icons.git.modified,
						removed = icons.git.removed,
					},
				},
			},
			lualine_z = {
				{
					-- lsp_client_names,
					'lsp_status',
					separator = { right = '' },
					padding = { left = 1 },
				},
			},
		},
		extensions = { 'fzf', 'oil', 'trouble', 'quickfix', 'nvim-dap-ui', 'mason' },
		-- inactive_winbar = {
		-- 	lualine_a = { { 'filename', path = 1 } },
		-- },
	}
end)
