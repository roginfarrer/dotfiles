vim.o.cmdheight = 0

vim.pack.add {
	'https://github.com/rachartier/tiny-cmdline.nvim',
}

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

Util.on_event('CmdlineEnter', function()
	vim.pack.add {
		'https://github.com/smjonas/live-command.nvim',
		'https://github.com/tpope/vim-abolish',
		'https://github.com/smjonas/inc-rename.nvim',
	}

	require('inc_rename').setup {}

	require('live-command').setup {
		commands = {
			Norm = { cmd = 'norm' },
		},
	}
end)
