if vim.env.HERDR_ENV ~= '1' then
	return
end

vim.schedule(function()
	Util.on_plugin_update('herdr-splits', function()
		require('herdr-splits').sync_herdr()
	end)

	vim.pack.add {
		'https://github.com/lmilojevicc/herdr-splits.nvim',
	}

	require('herdr-splits').setup {
		neovim_amount = 5,
		auto_sync_herdr = true,
		resize_keys = {
			left = '<S-Left>',
			down = '<S-Down>',
			up = '<S-Up>',
			right = '<S-Right>',
		},
	}

	local keys = {
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
	}

	for _, map in ipairs(keys) do
		Util.keymap(map)
	end
end)
