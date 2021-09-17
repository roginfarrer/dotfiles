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
	-- incremental_selection = {
	-- 	enable = true,
	-- 	keymaps = {
	-- 		init_selection = 'gnn',
	-- 		node_incremental = 'grn',
	-- 		scope_incremental = 'grc',
	-- 		node_decremental = 'grm',
	-- 	},
	-- },
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
				['ac'] = '@conditional.outer',
				['as'] = '@statement.outer',

				['ib'] = '@block.inner',
				['if'] = '@function.inner',
				['ic'] = '@conditional.inner',
				['is'] = '@statement.outer',
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
