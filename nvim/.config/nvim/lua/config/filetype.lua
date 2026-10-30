vim.filetype.add {
	filename = {
		['Brewfile'] = 'bash',
		['.eslintrc.json'] = 'jsonc',
	},
	pattern = {
		['tsconfig*.json'] = 'jsonc',
	},
}

Util.autocmd('FileType', {
	once = true,
	pattern = { 'handlebars', 'mustache' },
	callback = function()
		vim.pack.add { 'https://github.com/mustache/vim-mustache-handlebars' }
	end,
})
