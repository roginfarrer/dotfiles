return {
	{
		'HawkinsT/pathfinder.nvim',
		opts = {
			remap_default_keys = false,
			tmux_mode = true,
		},
		keys = {
			{
				'gx',
				function()
					require('pathfinder').gx()
				end,
			},
			{
				'gf',
				function()
					require('pathfinder').gf()
				end,
			},
			{
				'gF',
				function()
					require('pathfinder').gF()
				end,
				desc = 'Go to file under cursor (with line #)',
			},
			{
				'<leader>h',
				function()
					require('pathfinder').hover_description()
				end,
				desc = 'Pathfinder: Hover',
			},
		},
	},
}
