return {
	{ 'LazyVim/LazyVim' },
	{ 'nvim-lua/plenary.nvim', lazy = true },
	{ 'MunifTanjim/nui.nvim', lazy = true },
	{
		'brenoprata10/nvim-highlight-colors',
		event = 'VeryLazy',
		opts = { enable_named_colors = false, enable_tailwind = true, render = 'background', virtual_symbol = '•' },
	},
	{ 'zeioth/garbage-day.nvim', enabled = false, event = 'VeryLazy', opts = {} },

	-- Automatically between template literal and strings when needed
	{
		'axelvc/template-string.nvim',
		opts = { remove_template_string = true },
		event = 'InsertEnter',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},

	-- Auto pairs
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = {},
	},

	{
		'echasnovski/mini.bracketed',
		enabled = false,
		event = 'BufReadPost',
		version = '*',
		opts = {},
		config = function(_, opts)
			local bracketed = require 'mini.bracketed'
			bracketed.setup(opts)
		end,
	},

	-- Extends the a & i text objects, this adds the ability to select
	-- arguments, function calls, text within quotes and brackets, and to
	-- repeat those selections to select an outer text object.
	{
		'nvim-mini/mini.ai',
		event = 'VeryLazy',
		opts = function()
			local ai = require 'mini.ai'
			return {
				n_lines = 500,
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
		end,
		config = function(_, opts)
			require('mini.ai').setup(opts)
			require('util').on_plugin_load('which-key.nvim', function()
				vim.schedule(function()
					-- All of this is taken from LazyVim
					-- A bit annoying that we need to manually add keymap descriptions :(
					local objects = {
						{ ' ', desc = 'whitespace' },
						{ '"', desc = '" string' },
						{ "'", desc = "' string" },
						{ '(', desc = '() block' },
						{ ')', desc = '() block with ws' },
						{ '<', desc = '<> block' },
						{ '>', desc = '<> block with ws' },
						{ '?', desc = 'user prompt' },
						{ 'U', desc = 'use/call without dot' },
						{ '[', desc = '[] block' },
						{ ']', desc = '[] block with ws' },
						{ '_', desc = 'underscore' },
						{ '`', desc = '` string' },
						{ 'a', desc = 'argument' },
						{ 'b', desc = ')]} block' },
						{ 'c', desc = 'class' },
						{ 'd', desc = 'digit(s)' },
						{ 'e', desc = 'CamelCase / snake_case' },
						{ 'f', desc = 'function' },
						{ 'g', desc = 'entire file' },
						{ 'i', desc = 'indent' },
						{ 'o', desc = 'block, conditional, loop' },
						{ 'q', desc = 'quote `"\'' },
						{ 't', desc = 'tag' },
						{ 'u', desc = 'use/call' },
						{ '{', desc = '{} block' },
						{ '}', desc = '{} with ws' },
					}

					---@type wk.Spec[]
					local ret = { mode = { 'o', 'x' } }
					---@type table<string, string>
					local mappings = vim.tbl_extend('force', {}, {
						around = 'a',
						inside = 'i',
						around_next = 'an',
						inside_next = 'in',
						around_last = 'al',
						inside_last = 'il',
					})
					mappings.goto_left = nil
					mappings.goto_right = nil

					for name, prefix in pairs(mappings) do
						name = name:gsub('^around_', ''):gsub('^inside_', '')
						ret[#ret + 1] = { prefix, group = name }
						for _, obj in ipairs(objects) do
							local desc = obj.desc
							if prefix:sub(1, 1) == 'i' then
								desc = desc:gsub(' with ws', '')
							end
							ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
						end
					end
					require('which-key').add(ret, { notify = false })
				end)
			end)
		end,
	},

	-- { 'luukvbaal/statuscol.nvim', opts = {} },
}
