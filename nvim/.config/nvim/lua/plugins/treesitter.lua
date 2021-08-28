require('nvim-treesitter.configs').setup({
	ensure_installed = {
		'javascript',
		'typescript',
		'tsx',
		'css',
		'bash',
		'yaml',
		'json',
		'lua',
		'toml',
		'regex',
		'php',
		'graphql',
	},
	indent = {
		enable = true,
	},
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	context_commentstring = {
		enable = true,
	},
})
