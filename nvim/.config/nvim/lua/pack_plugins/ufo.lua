Util.on_event('BufReadPost', function()
	vim.pack.add {
		'https://github.com/kevinhwang91/promise-async',
		{ src = 'https://github.com/kevinhwang91/nvim-ufo', version = 'ab3eb124062422d276fae49e0dd63b3ad1062cfc' },
	}

	vim.o.foldcolumn = '0' -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true

	require('ufo').setup()

	Util.keymap {
		'zR',
		function()
			require('ufo').openAllFolds()
		end,
		desc = 'Open all folds (UFO)',
	}

	Util.keymap {
		'zM',
		function()
			require('ufo').closeAllFolds()
		end,
		desc = 'Close all folds (UFO)',
	}
end)
