return {
	{
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		build = ':TSUpdate',
		lazy = false,
		dependencies = {
			{ 'JoosepAlviste/nvim-ts-context-commentstring', opts = {} },
			{ 'windwp/nvim-ts-autotag', opts = {} },
		},
		opts = {},
		config = function(_, opts)
			local treesitter = require 'nvim-treesitter'
			treesitter.install { -- equivalent of ensure_installed
				'bash',
				'css',
				'diff',
				'fish',
				'git_config',
				'git_rebase',
				'gitattributes',
				'gitcommit',
				'gitignore',
				'html',
				'javascript',
				'json',
				'lua',
				'luadoc',
				'markdown',
				'markdown_inline',
				'regex',
				'scss',
				'tmux',
				'toml',
				'tsx',
				'typescript',
				'vim',
				'vimdoc',
				'yaml',
			}

			vim.treesitter.language.register('markdown', 'mdx')

			treesitter.setup(opts)

			local ts_config = require 'nvim-treesitter.config'
			-- Auto-install and start parsers for any buffer
			vim.api.nvim_create_autocmd({ 'FileType' }, {
				desc = 'Enable Treesitter',
				callback = function(event)
					local bufnr = event.buf
					local filetype = event.match

					-- Skip if no filetype
					if filetype == '' then
						return
					end

					local parser_name = vim.treesitter.language.get_lang(filetype)
					if not parser_name then
						vim.notify(
							vim.inspect('No treesitter parser found for filetype: ' .. filetype),
							vim.log.levels.WARN
						)
						return
					end

					-- Try to get existing parser
					if not vim.tbl_contains(ts_config.get_available(), parser_name) then
						return
					end

					local function ts_start(buf, parser)
						vim.treesitter.start(buf, parser)
						vim.bo[bufnr].syntax = 'on'
						vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- Use treesitter for indentation
					end

					-- Check if parser is already installed
					local already_installed = ts_config.get_installed 'parsers'
					if not vim.tbl_contains(already_installed, parser_name) then
						treesitter.arun(function()
							-- If not installed, install parser asynchronously and start treesitter
							vim.notify('Installing parser for ' .. parser_name, vim.log.levels.INFO)
							treesitter.install({ parser_name }):await(function()
								vim.print('Starting parser: ' .. parser_name)
								ts_start(bufnr, parser_name)
							end)
						end)
						return
					end

					-- Start treesitter for this buffer
					ts_start(bufnr, parser_name)
				end,
			})
		end,
	},

	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		enabled = true,
		branch = 'main',
		lazy = false,
		opts = {
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
			},
		},
		-- keys = function()
		-- 	local key_groups = {
		-- 		['f'] = 'function',
		-- 		['c'] = 'class',
		-- 		['a'] = 'parameter',
		-- 	}

		-- 	local function select(object, category)
		-- 		return function()
		-- 			require('nvim-treesitter-textobjects.select').select_textobject(object, category)
		-- 		end
		-- 	end

		-- 	local move_keys = {}
		-- 	local move_key_mode = { 'x', 'n', 'o' }

		-- 	for key, group in pairs(key_groups) do
		-- 		local scope = '@' .. group .. '.outer'
		-- 		table.insert(move_keys, {
		-- 			']' .. key,
		-- 			function()
		-- 				require('nvim-treesitter-textobjects.move').goto_next_start(scope, 'textobjects')
		-- 			end,
		-- 			mode = move_key_mode,
		-- 			desc = 'Goto start of next ' .. group,
		-- 		})
		-- 		table.insert(move_keys, {
		-- 			']' .. string.upper(key),
		-- 			function()
		-- 				require('nvim-treesitter-textobjects.move').goto_next_end(scope, 'textobjects')
		-- 			end,
		-- 			mode = move_key_mode,
		-- 			desc = 'Goto end of next ' .. group,
		-- 		})
		-- 		table.insert(move_keys, {
		-- 			'[' .. key,
		-- 			function()
		-- 				require('nvim-treesitter-textobjects.move').goto_previous_start(scope, 'textobjects')
		-- 			end,
		-- 			mode = move_key_mode,
		-- 			desc = 'Goto start of previous ' .. group,
		-- 		})
		-- 		table.insert(move_keys, {
		-- 			'[' .. string.upper(key),
		-- 			function()
		-- 				require('nvim-treesitter-textobjects.move').goto_previous_end(scope, 'textobjects')
		-- 			end,
		-- 			mode = move_key_mode,
		-- 			desc = 'Goto end of previous ' .. group,
		-- 		})
		-- 	end

		-- 	return vim.tbl_deep_extend('keep', move_keys, {
		-- 		-- Select
		-- 		{
		-- 			'af',
		-- 			select('@function.outer', 'textobjects'),
		-- 			desc = 'Select outer function',
		-- 			mode = { 'x', 'o' },
		-- 		},
		-- 		{
		-- 			'if',
		-- 			select('@function.inner', 'textobjects'),
		-- 			desc = 'Select inner function',
		-- 			mode = { 'x', 'o' },
		-- 		},
		-- 		{
		-- 			'ac',
		-- 			select('@class.outer', 'textobjects'),
		-- 			desc = 'Select outer class',
		-- 			mode = { 'x', 'o' },
		-- 		},
		-- 		{
		-- 			'ic',
		-- 			select('@class.inner', 'textobjects'),
		-- 			desc = 'Select inner class',
		-- 			mode = { 'x', 'o' },
		-- 		},
		-- 	})
		-- end,
	},

	{
		'Wansmer/treesj',
		enabled = false,
		cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
		keys = {
			{
				'J',
				function()
					require('treesj').toggle()
				end,
				desc = 'toggle treesj',
			},
		},
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		opts = { use_default_keymaps = false },
	},

	{
		'danymat/neogen',
		dependencies = 'nvim-treesitter/nvim-treesitter',
		cmd = 'Neogen',
		opts = { snippet_engine = 'luasnip' },
	},
}
