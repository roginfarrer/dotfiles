return {
	{
		'mikavilpas/yazi.nvim',
		dependencies = {
			{ 'nvim-lua/plenary.nvim', lazy = true },
		},
		cmd = { 'Yazi' },
		keys = {
			{ '<C-t>', '<cmd>Yazi<cr>', desc = 'Yazi', mode = { 'n', 'v' } },
		},
	},
}
