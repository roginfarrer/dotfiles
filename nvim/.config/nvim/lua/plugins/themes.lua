vim.pack.add {
	Util.gh('catppuccin/nvim', { name = 'catppuccin' }),
	Util.gh('rose-pine/neovim', { name = 'rose-pine' }),
}

require('rose-pine').setup {}

require('catppuccin').setup {
	lsp_styles = {
		underlines = {
			errors = { 'undercurl' },
			hints = { 'undercurl' },
			warnings = { 'undercurl' },
			information = { 'undercurl' },
			ok = { 'undercurl' },
		},
		inlay_hints = { background = true },
	},
	highlight_overrides = {
		mocha = function(colors)
			-- local util = require 'catppuccin.utils.colors'
			return {
				WinSeparator = { fg = colors.surface2 },
				-- aka horizontal split
				-- StatusLineNC = { fg = colors.surface2 },
				-- InclineNormal = {
				-- 	fg = util.darken(colors.lavender, 0.3),
				-- 	bg = util.darken(colors.lavender, 0.8),
				-- },
				-- InclineNormalNC = {
				-- 	fg = util.darken(colors.lavender, 0.3),
				-- 	bg = util.darken(colors.lavender, 0.8),
				-- },
				-- DiffAdd = { bg = util.darken(colors.green, 0.2) },
				-- DiffDelete = { bg = util.darken(colors.red, 0.2) },
				-- DiffText = { bg = util.darken(colors.yellow, 0.3) },
				-- FzfLuaBorder = { bg = colors.crust, fg = colors.crust },
				-- -- FzfLuaHelpBorder = { bg = colors.crust, fg = colors.crust },
				-- FzfLuaPreviewBorder = { bg = colors.mantle, fg = colors.mantle },
				-- FzfLuaPreviewNormal = { bg = colors.mantle },
				-- FzfLuaScrollBorderEmpty = { bg = colors.base, fg = colors.base },
				-- FzfLuaScrollBorderFull = { bg = colors.base, fg = colors.base },
				-- FzfLuaScrollFloatEmpty = { bg = colors.base, fg = colors.lavender },
				-- FzfLuaScrollFloatFull = { bg = colors.base, fg = colors.lavender },
				DashboardHeader = { fg = colors.yellow },
			}
		end,
	},
}
