vim.g['test#javascript#runner'] = 'jest'
vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'vert'
vim.cmd([[
	let test#strategy = 'neoterm'
]])
