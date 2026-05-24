return {
	{
		'mikavilpas/yazi.nvim',
		version = '*',
		dependencies = {
			{ 'nvim-lua/plenary.nvim', lazy = true },
		},
		cmd = { 'Yazi' },
		keys = {
			{ '<C-t>', '<cmd>Yazi<cr>', desc = 'Yazi', mode = { 'n', 'v' } },
		},
		---@type YaziConfig | {}
		opts = {},
	},
}
