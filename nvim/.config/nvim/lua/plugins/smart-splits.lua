return {
	{
		'mrjones2014/smart-splits.nvim',
		cond = vim.env.HERDR_ENV ~= '1',
		lazy = false,
		opts = { resize = { amount = 5 } },
		keys = {
			{
				'<C-h>',
				function()
					require('smart-splits').move_cursor_left()
				end,
				desc = 'move left',
			},
			{
				'<C-j>',
				function()
					require('smart-splits').move_cursor_down()
				end,
				desc = 'move down',
			},
			{
				'<C-k>',
				function()
					require('smart-splits').move_cursor_up()
				end,
				desc = 'move up',
			},
			{
				'<C-l>',
				function()
					require('smart-splits').move_cursor_right()
				end,
				desc = 'move right',
			},
			{
				'<S-Left>',
				function()
					require('smart-splits').resize_left()
				end,
				desc = 'resize left',
			},
			{
				'<S-Right>',
				function()
					require('smart-splits').resize_right()
				end,
				desc = 'resize right',
			},
			{
				'<S-Down>',
				function()
					require('smart-splits').resize_down()
				end,
				desc = 'resize down',
			},
			{
				'<S-Up>',
				function()
					require('smart-splits').resize_up()
				end,
				desc = 'resize up',
			},
		},
	},
	{
		'lmilojevicc/herdr-splits.nvim',
		cond = vim.env.HERDR_ENV == '1',
		event = 'VeryLazy',
		build = ':lua require("herdr-splits").sync_herdr()',
		opts = {
			neovim_amount = 5,
			auto_sync_herdr = true,
			resize_keys = {
				left = '<S-Left>',
				down = '<S-Down>',
				up = '<S-Up>',
				right = '<S-Right>',
			},
		},
		keys = {
			{
				'<C-h>',
				function()
					require('herdr-splits').move_cursor_left()
				end,
				desc = 'move left',
			},
			{
				'<C-j>',
				function()
					require('herdr-splits').move_cursor_down()
				end,
				desc = 'move down',
			},
			{
				'<C-k>',
				function()
					require('herdr-splits').move_cursor_up()
				end,
				desc = 'move up',
			},
			{
				'<C-l>',
				function()
					require('herdr-splits').move_cursor_right()
				end,
				desc = 'move right',
			},
			{
				'<S-Left>',
				function()
					require('herdr-splits').resize_left()
				end,
				desc = 'resize left',
			},
			{
				'<S-Right>',
				function()
					require('herdr-splits').resize_right()
				end,
				desc = 'resize right',
			},
			{
				'<S-Down>',
				function()
					require('herdr-splits').resize_down()
				end,
				desc = 'resize down',
			},
			{
				'<S-Up>',
				function()
					require('herdr-splits').resize_up()
				end,
				desc = 'resize up',
			},
		},
	},
}
