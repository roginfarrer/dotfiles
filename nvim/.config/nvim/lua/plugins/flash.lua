vim.schedule(function()
	vim.pack.add { 'https://github.com/folke/flash.nvim' }

	require('flash').setup {
		modes = { char = { enabled = false, jump = { autojump = true } } },
	}

	local keys = {
		{
			's',
			mode = { 'n', 'o', 'x' },
			function()
				require('flash').jump()
			end,
			desc = 'Flash',
		},
		{
			'S',
			mode = { 'n', 'o', 'x' },
			function()
				require('flash').treesitter()
			end,
			desc = 'Flash Treesitter',
		},
		{
			'r',
			mode = 'o',
			function()
				require('flash').remote()
			end,
			desc = 'Remote Flash',
		},
		{
			'R',
			mode = { 'o', 'x' },
			function()
				require('flash').treesitter_search()
			end,
			desc = 'Treesitter Search',
		},
		{
			'<c-s>',
			mode = { 'c' },
			function()
				require('flash').toggle()
			end,
			desc = 'Toggle Flash Search',
		},
	}

	for _, map in ipairs(keys) do
		Util.keymap(map)
	end
end)
