vim.schedule(function()
	vim.pack.add { { src = 'https://github.com/OXY2DEV/markview.nvim', name = 'markview' } }

	local presets = require 'markview.presets'
	require('markview').setup {
		preview = { modes = { 'n' } },
		---@type markview.config.markdown | {}
		markdown = {
			-- list_items = {
			-- 	enable = false,
			-- 	marker_minus = {
			-- 		add_padding = false,
			-- 		text = '',
			-- 	},
			-- },
			headings = presets.headings.glow,
			tables = presets.tables.rounded,
			blockquotes = presets.block_quotes.obsidian,
		},
		---@type markview.config.markdown_inline | {}
		markdown_inline = {
			-- checkboxes = {
			-- 	enable = false,
			-- },
		},
	}
	require('markview.extras.editor').setup()
end)
