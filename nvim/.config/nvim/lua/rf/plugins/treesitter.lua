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
		'vim',
		'swift',
		'kotlin',
		'svelte',
		'vue',
		'scss',
	},
	indent = { enable = true },
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	context_commentstring = { enable = true },
	autopairs = {
		enable = true,
	},
	textobjects = {
		swap = {
			enable = true,
			swap_next = {
				['<leader>a'] = '@parameter.inner',
			},
			swap_previous = {
				['<leader>A'] = '@parameter.inner',
			},
		},
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				['ab'] = '@block.outer',
				['af'] = '@function.outer',
				['aC'] = '@conditional.outer',
				['ac'] = '@comment.outer',
				['as'] = '@statement.outer',
				['am'] = '@call.outer',

				['ib'] = '@block.inner',
				['if'] = '@function.inner',
				['iC'] = '@conditional.inner',
				['ic'] = '@comment.inner',
				['is'] = '@statement.inner',
				['im'] = '@call.inner',
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				[']m'] = '@function.outer',
				[']]'] = '@class.outer',
			},
			goto_next_end = {
				[']M'] = '@function.outer',
				[']['] = '@class.outer',
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
				['[['] = '@class.outer',
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
				['[]'] = '@class.outer',
			},
		},
	},
})
