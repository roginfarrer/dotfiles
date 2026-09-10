return {
	{
		'chrisgrieser/nvim-chainsaw',
		event = 'VeryLazy',
		opts = {}, -- required even if left empty
		keys = {
			{
				'<S-l>',
				function()
					require('chainsaw').variableLog()
				end,
				desc = 'Log variable under cursor',
			},
		},
	},
}
