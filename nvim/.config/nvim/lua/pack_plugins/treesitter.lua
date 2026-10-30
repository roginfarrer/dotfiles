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
	'toml',
	'tsx',
	'typescript',
	'vim',
	'vimdoc',
	'yaml',
	'jsdoc',
}

Util.on_plugin_update('nvim-treesitter', function()
	vim.cmd 'TSUpdate'
end)

vim.pack.add {
	Util.gh 'nvim-treesitter/nvim-treesitter',
	Util.gh 'nvim-treesitter/nvim-treesitter-textobjects',
	Util.gh 'nvim-mini/mini.ai',
	Util.gh 'Wansmer/treesj',
	Util.gh 'axelvc/template-string.nvim',
}

local treesitter = require 'nvim-treesitter'
vim.treesitter.language.register('glimmer', 'mustache')
vim.treesitter.language.register('glimmer', 'hbs')

treesitter.install(languages)
treesitter.setup()

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

require('nvim-treesitter-textobjects').setup {
	move = {
		enable = true,
		set_jumps = true, -- whether to set jumps in the jumplist
	},
}

local ai = require 'mini.ai'
require('mini.ai').setup {
	search_method = 'cover',
	custom_textobjects = {
		o = ai.gen_spec.treesitter { -- code block
			a = { '@block.outer', '@conditional.outer', '@loop.outer' },
			i = { '@block.inner', '@conditional.inner', '@loop.inner' },
		},
		f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
		c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' }, -- class
		t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
		d = { '%f[%d]%d+' }, -- digits
		e = { -- Word with case
			{
				'%u[%l%d]+%f[^%l%d]',
				'%f[%S][%l%d]+%f[^%l%d]',
				'%f[%P][%l%d]+%f[^%l%d]',
				'^[%l%d]+%f[^%l%d]',
			},
			'^().*()$',
		},
		-- g = LazyVim.mini.ai_buffer, -- buffer
		u = ai.gen_spec.function_call(), -- u for "Usage"
		U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function name
	},
}

require('treesj').setup {
	use_default_keymaps = false,
	max_join_length = 1000,
}
Util.keymap {
	'J',
	function()
		require('treesj').toggle()
	end,
	desc = 'toggle treesj',
}
