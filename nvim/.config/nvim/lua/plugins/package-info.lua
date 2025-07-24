return {
	{
		'vuki656/package-info.nvim',
		opts = {},
		dependencies = { 'MunifTanjim/nui.nvim' },
		ft = 'json',
		keys = {
			{ '<leader>n', nil, group = 'package-info' },
			{ '<leader>ns', "<cmd>lua require('package-info').show()<cr>", desc = '(package-info) Display latest' },
			{
				'<leader>np',
				"<cmd>lua require('package-info').change_version()<cr>",
				desc = '(package-info) Change version',
			},
		},
	},
	-- {
	--   'mini.clue',
	--   optional = true,
	--   opts = function(_, opts)
	--     return vim.tbl_deep_extend('keep', opts, {
	--       clues = {
	--         { mode = 'n', keys = '<leader>n', desc = '+package-info' },
	--       },
	--     })
	--   end,
	-- },
}
