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

	{
		'rachartier/tiny-cmdline.nvim',
		event = 'VeryLazy',
		init = function()
			vim.o.cmdheight = 0
			---@class TinyCmdlineConfig
			vim.g.tiny_cmdline = {
				border = nil,
				width = {
					min = 40,
					max = 60,
					value = '50%',
				},
				on_reposition = require('tiny-cmdline').adapters.blink,
				-- Window position ("N%" = fraction of available space, integer = absolute columns/rows)
				position = {
					x = '50%', -- horizontal: "0%" = left, "50%" = center, "100%" = right
					y = '10%', -- vertical:   "0%" = top,  "50%" = center, "100%" = bottom
				},
			}
		end,
	},
}
