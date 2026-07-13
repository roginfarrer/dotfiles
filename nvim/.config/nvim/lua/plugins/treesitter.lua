local languages = {
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
	'json5',
	'lua',
	'luadoc',
	'markdown',
	'markdown_inline',
	'regex',
	'scss',
	'styled',
	'tmux',
	'toml',
	'tsx',
	'typescript',
	'vim',
	'vimdoc',
	'yaml',
	'jsdoc',
}

local function jsdoc_word_wrap(text, max_width)
	if max_width <= 0 then
		max_width = 1
	end
	local result = {}
	local current = ''
	for word in text:gmatch '%S+' do
		local candidate = current == '' and word or (current .. ' ' .. word)
		if #candidate > max_width and current ~= '' then
			result[#result + 1] = current
			current = word
		else
			current = candidate
		end
	end
	if current ~= '' then
		result[#result + 1] = current
	end
	return result
end

local function jsdoc_fallback(tsnode)
	local text = vim.treesitter.get_node_text(tsnode, 0)
	local start_row, start_col, end_row, end_col = tsnode:range()
	local buf = vim.api.nvim_get_current_buf()
	local indent = string.rep(' ', start_col)
	local new_lines

	if not text:match '\n' then
		local content = text:match '^/%*%*%s*(.-)%s*%*/$'
		if not content or content == '' then
			return
		end
		local wrapped = jsdoc_word_wrap(content, 80 - start_col - 3)
		new_lines = { '/**' }
		for _, line in ipairs(wrapped) do
			new_lines[#new_lines + 1] = indent .. ' * ' .. line
		end
		new_lines[#new_lines + 1] = indent .. ' */'
	else
		local parts = {}
		for i, line in ipairs(vim.split(text, '\n')) do
			if i == 1 then
				local c = line:match '^/%*%*%s+(.-)%s*$'
				if c and c ~= '' then
					parts[#parts + 1] = c
				end
			elseif line:match '%*/' then
				-- closing */ line, skip
			else
				local c = line:match '^%s*%*%s*(.-)%s*$'
				if c and c ~= '' then
					parts[#parts + 1] = c
				end
			end
		end
		new_lines = { '/** ' .. table.concat(parts, ' ') .. ' */' }
	end

	vim.api.nvim_buf_set_text(buf, start_row, start_col, end_row, end_col, new_lines)
end

local jsdoc_comment_preset = {
	both = {
		enable = function(tsnode)
			return vim.treesitter.get_node_text(tsnode, 0):match '^/%*%*' ~= nil
		end,
		fallback = jsdoc_fallback,
	},
}

return {
	{
		'nvim-treesitter/nvim-treesitter',
		-- The repo was archived :\
		commit = '4916d6592ede8c07973490d9322f187e07dfefac',
		-- branch = 'main',
		build = ':TSUpdate',
		lazy = false,
		dependencies = {
			{ 'JoosepAlviste/nvim-ts-context-commentstring', opts = {} },
			{ 'windwp/nvim-ts-autotag', opts = {} },
			{ 'nvim-treesitter/nvim-treesitter-context', opts = {} },
		},
		opts = {},
		config = function(_, opts)
			local treesitter = require 'nvim-treesitter'
			vim.treesitter.language.register('glimmer', 'mustache')
			vim.treesitter.language.register('glimmer', 'hbs')

			treesitter.install(languages)
			treesitter.setup(opts)

			---@param buf integer
			---@param language string
			local function treesitter_try_attach(buf, language)
				-- Check if a parser exists and load it
				if not vim.treesitter.language.add(language) then
					return
				end
				-- Enable syntax highlighting and other treesitter features
				vim.treesitter.start(buf, language)

				-- Enable treesitter based folds
				-- For more info on folds see `:help folds`
				-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
				-- vim.wo.foldmethod = 'expr'

				-- Check if treesitter indentation is available for this language, and if so enable it
				-- in case there is no indent query, the indentexpr will fallback to the vim's built in one
				local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

				-- Enable treesitter based indentation
				if has_indent_query then
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end

			local available_parsers = require('nvim-treesitter').get_available()
			vim.api.nvim_create_autocmd('FileType', {
				callback = function(args)
					local buf, filetype = args.buf, args.match

					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end

					local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

					if vim.tbl_contains(installed_parsers, language) then
						-- Enable the parser if it is already installed
						treesitter_try_attach(buf, language)
					elseif vim.tbl_contains(available_parsers, language) then
						-- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
						require('nvim-treesitter').install(language):await(function()
							treesitter_try_attach(buf, language)
						end)
					else
						-- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
						treesitter_try_attach(buf, language)
					end
				end,
			})

			-- vim.api.nvim_create_autocmd('FileType', {
			-- 	group = vim.api.nvim_create_augroup('treesitter.setup', {}),
			-- 	callback = function(args)
			-- 		local buf = args.buf
			-- 		local filetype = args.match

			-- 		-- Avoid running on buffers that do not
			-- 		-- correspond to a language (like oil.nvim buffers), this implementation
			-- 		-- checks if a parser exists for the current language
			-- 		local language = vim.treesitter.language.get_lang(filetype) or filetype
			-- 		if not vim.treesitter.language.add(language) then
			-- 			return
			-- 		end

			-- 		-- Enalbes tree-sitting folding
			-- 		-- vim.wo.foldmethod = 'expr'
			-- 		-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

			-- 		-- Enables highlighting
			-- 		vim.treesitter.start(buf, language)

			-- 		-- Enables tree-sitter indentation
			-- 		-- Disabled since it's not very good
			-- 		-- vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			-- 	end,
			-- })
		end,
	},

	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		branch = 'main',
		lazy = false,
		opts = {
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
			},
		},
	},

	{
		'Wansmer/treesj',
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
		opts = {
			use_default_keymaps = false,
			max_join_length = 1000,
			langs = {
				-- javascript = { comment = jsdoc_comment_preset },
				-- typescript = { comment = jsdoc_comment_preset },
				-- tsx = { comment = jsdoc_comment_preset },
				-- jsx = { comment = jsdoc_comment_preset },
				jsdoc = { comment = jsdoc_comment_preset },
			},
		},
	},

	{
		'danymat/neogen',
		dependencies = 'nvim-treesitter/nvim-treesitter',
		cmd = 'Neogen',
		opts = { snippet_engine = 'luasnip' },
	},
}
