return {
	{
		'smjonas/live-command.nvim',
		event = 'CmdlineEnter',
		opts = {
			commands = {
				Norm = { cmd = 'norm' },
			},
		},
		config = function(_, opts)
			require('live-command').setup(opts)
		end,
	},
	{ 'tpope/vim-abolish', event = 'CmdlineEnter' },
	{ 'smjonas/inc-rename.nvim', opts = {} },
}
