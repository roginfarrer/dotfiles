require('gitsigns').setup({
	signs = {
		add = { hl = 'GitGutterAdd', text = '│' },
		change = { hl = 'GitGutterChange', text = '│' },
		delete = { hl = 'GitGutterDelete', text = '_' },
		topdelete = { hl = 'GitGutterDelete', text = '‾' },
		changedelete = { hl = 'GitGutterChangeDelete', text = '~' },
	},
})
