if vim.env.HERDR_ENV == '1' then
	return
end

vim.schedule(function()
	vim.pack.add {
		'https://github.com/smart-splits-nvim/backend-tmux',
		{ src = 'https://github.com/smart-splits-nvim/smart-splits.nvim', version = vim.version.range '^3.0.0' },
	}

	require('smart-splits').setup {
		resize = { amount = 5 },
		move = { at_edge = 'wrap' },
		mux = {
			backend = 'smart-splits-backend-tmux',
		},
	}

	local keys = {
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
	}

	for _, map in ipairs(keys) do
		Util.keymap(map)
	end
end)
