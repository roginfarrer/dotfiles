vim.pack.add {
	{ src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
}
local cp = require('catppuccin.palettes').get_palette()
local util = require 'catppuccin.utils.colors'

require('catppuccin').setup {
	no_italic = false,
	auto_integrations = true,
	-- integrations = {
	-- 	lsp_saga = true,
	-- 	treesitter = true,
	-- 	native_lsp = {
	-- 		enabled = true,
	-- 		virtual_text = {
	-- 			errors = { 'italic' },
	-- 			hints = { 'italic' },
	-- 			warnings = { 'italic' },
	-- 			information = { 'italic' },
	-- 		},
	-- 		underlines = {
	-- 			errors = { 'undercurl' },
	-- 			hints = { 'undercurl' },
	-- 			warnings = { 'undercurl' },
	-- 			information = { 'undercurl' },
	-- 		},
	-- 		inlay_hints = { background = true },
	-- 	},
	-- 	blink_cmp = true,
	-- 	dap = true,
	-- 	dap_ui = true,
	-- 	diffview = true,
	-- 	fidget = true,
	-- 	fzf = true,
	-- 	gitsigns = true,
	-- 	grug_far = true,
	-- 	headlines = true,
	-- 	illuminate = { enabled = true, lsp = true },
	-- 	indent_blankline = { enabled = false },
	-- 	lsp_trouble = true,
	-- 	markdown = true,
	-- 	markview = true,
	-- 	mason = true,
	-- 	mini = { enabled = true },
	-- 	navic = { enabled = false, custom_bg = cp.mantle },
	-- 	neogit = true,
	-- 	neotest = true,
	-- 	neotree = true,
	-- 	noice = true,
	-- 	notify = true,
	-- 	octo = true,
	-- 	render_markdown = true,
	-- 	ufo = true,
	-- 	which_key = true,
	-- 	snacks = true,
	-- },
	highlight_overrides = {
		mocha = {
			VertSplit = { fg = cp.black4 },
			-- aka horizontal split
			StatusLineNC = { fg = cp.black4 },
			InclineNormal = {
				fg = util.darken(cp.lavender, 0.3),
				bg = util.darken(cp.lavender, 0.8),
			},
			InclineNormalNC = {
				fg = util.darken(cp.lavender, 0.3),
				bg = util.darken(cp.lavender, 0.8),
			},
			DiffAdd = { bg = util.darken(cp.green, 0.2) },
			DiffDelete = { bg = util.darken(cp.red, 0.2) },
			DiffText = { bg = util.darken(cp.yellow, 0.3) },
			-- FzfLuaBorder = { bg = cp.crust, fg = cp.crust },
			-- -- FzfLuaHelpBorder = { bg = cp.crust, fg = cp.crust },
			-- FzfLuaPreviewBorder = { bg = cp.mantle, fg = cp.mantle },
			-- FzfLuaPreviewNormal = { bg = cp.mantle },
			-- FzfLuaScrollBorderEmpty = { bg = cp.base, fg = cp.base },
			-- FzfLuaScrollBorderFull = { bg = cp.base, fg = cp.base },
			-- FzfLuaScrollFloatEmpty = { bg = cp.base, fg = cp.lavender },
			-- FzfLuaScrollFloatFull = { bg = cp.base, fg = cp.lavender },
			DashboardHeader = { fg = cp.yellow },
		},
	},
}
