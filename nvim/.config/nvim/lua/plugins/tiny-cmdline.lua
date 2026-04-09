return {
	{
		'rachartier/tiny-cmdline.nvim',
		event = 'VeryLazy',
		config = function()
			vim.o.cmdheight = 0
			require('tiny-cmdline').setup {
				border = nil,
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
