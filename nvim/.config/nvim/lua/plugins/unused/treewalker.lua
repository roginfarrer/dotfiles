return {
	{
		'aaronik/treewalker.nvim',
		enabled = false,
		cond = not vim.g.disable_treesitter,
		opts = {
			highlight = false,
		},
		keys = {
			{
				'H',
				'<cmd>Treewalker Up<cr>',
				mode = { 'n', 'o' },
			},
			{
				'J',
				'<cmd>Treewalker Right<cr>',
				mode = { 'n', 'o' },
			},
			{
				'K',
				'<cmd>Treewalker Left<cr>',
				mode = { 'n', 'o' },
			},
			{
				'L',
				'<cmd>Treewalker Down<cr>',
				mode = { 'n', 'o' },
			},
		},
	},
}
