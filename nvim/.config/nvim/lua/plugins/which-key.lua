return {
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		enabled = true,
		opts = {
			preset = 'helix',
			replace = { ['<leader>'] = 'SPC', ['<tab>'] = 'TAB' },
			spec = {
				{
					mode = { 'n', 'v' },
					{ '<leader><tab>', group = 'tabs' },
					{ '<leader>f', group = 'find' },
					{ '<leader>g', group = 'git' },
					{ '<leader>gh', group = 'hunk' },
					{ '<leader>x', group = 'trouble' },
					{ '<leader>s', group = 'search' },
					{ '<leader>j', group = 'join/split' },
					{ '<leader>d', group = 'debug' },
					{ '<leader>t', group = 'test' },
					{ '<leader>o', group = 'obsidian' },
					{ '<leader>y', group = 'clipboard' },
				},
			},
			icons = { rules = false },
		},
	},
}
