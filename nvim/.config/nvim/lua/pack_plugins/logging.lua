vim.schedule(function()
	vim.pack.add { 'https://github.com/chrisgrieser/nvim-chainsaw' }
	require('chainsaw').setup {}

	Util.keymap {
		'<S-l>',
		function()
			require('chainsaw').variableLog()
		end,
		desc = 'Log variable under cursor',
	}
end)
