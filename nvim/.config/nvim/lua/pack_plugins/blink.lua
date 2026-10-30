Util.on_event('InsertEnter', function()
	vim.pack.add {
		'https://github.com/windwp/nvim-autopairs',
		{ src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' },
		'https://github.com/nvim-lua/plenary.nvim',
		'https://github.com/Kaiser-Yang/blink-cmp-git',
		'https://github.com/fang2hou/blink-copilot',
		'https://github.com/ribru17/blink-cmp-spell',
		-- snippets
		'https://github.com/rafamadriz/friendly-snippets',
		'https://github.com/nvim-mini/mini.snippets',
	}

	local gen_loader = require('mini.snippets').gen_loader
	require('mini.snippets').setup {
		snippets = {
			-- Load custom file with global snippets first (adjust for Windows)
			gen_loader.from_file '~/.config/nvim/snippets/global.json',

			-- Load snippets based on current language by reading files from
			-- "snippets/" subdirectories from 'runtimepath' directories.
			gen_loader.from_lang {
				lang_patterns = {
					markdown_inline = { 'markdown.json' },
					tsx = {
						'**/javascript.json',
						'**/typescript.json',
						'**/tsdoc.json',
					},
					typescript = {
						'**/javascript.json',
						'**/typescript.json',
						'**/tsdoc.json',
					},
				},
			},
			gen_loader.from_lang(),
		},
	}

	require('blink.cmp').setup {
		sources = {
			default = {
				'snippets',
				'copilot',
				'lsp',
				'path',
				'buffer',
				'spell',
			},
			providers = {
				copilot = {
					module = 'blink-copilot',
					name = 'copilot',
					score_offset = 100,
					async = true,
				},
				spell = {
					name = 'Spell',
					module = 'blink-cmp-spell',
				},
			},
		},
		signature = {
			enabled = true,
		},
		completion = {
			menu = {
				draw = {
					treesitter = { 'lsp' },
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
								return kind_icon
							end,
							-- Optionally, you may also use the highlights from mini.icons
							highlight = function(ctx)
								local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
								return hl
							end,
						},
					},
				},
			},
			documentation = {
				auto_show = true,
			},
		},
		keymap = {
			preset = 'default',
			['<Tab>'] = {
				function(cmp)
					if vim.b[vim.api.nvim_get_current_buf()].nes_state then
						cmp.hide()
						return (
							require('copilot-lsp.nes').apply_pending_nes()
							and require('copilot-lsp.nes').walk_cursor_end_edit()
						)
					end
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				'snippet_forward',
				'fallback',
			},
			-- ['<C-y>'] = { 'select_and_accept' },
			-- ['<Tab>'] = {
			-- 	-- function(cmp)
			-- 	-- 	if vim.b[vim.api.nvim_get_current_buf()].nes_state then
			-- 	-- 		cmp.hide()
			-- 	-- 		return (
			-- 	-- 			require('copilot-lsp.nes').apply_pending_nes()
			-- 	-- 			and require('copilot-lsp.nes').walk_cursor_end_edit()
			-- 	-- 		)
			-- 	-- 	end
			-- 	-- 	if cmp.snippet_active() then
			-- 	-- 		return cmp.accept()
			-- 	-- 	else
			-- 	-- 		return cmp.select_and_accept()
			-- 	-- 	end
			-- 	-- end,
			-- 	function() -- sidekick next edit suggestion
			-- 		return require('sidekick').nes_jump_or_apply()
			-- 	end,
			-- 	'snippet_forward',
			-- 	-- function ()
			-- 	--     return require('copilot')
			-- 	-- end
			-- 	'fallback',
			-- },
		},
		snippets = { preset = 'mini_snippets' },
		cmdline = {
			keymap = {
				-- recommended, as the default keymap will only show and select the next item
				['<Tab>'] = { 'show', 'accept' },
			},
			completion = {
				menu = {
					auto_show = function(ctx)
						return vim.fn.getcmdtype() == ':'
						-- enable for inputs as well, with:
						-- or vim.fn.getcmdtype() == '@'
					end,
				},
			},
		},
	}

	require('nvim-autopairs').setup {}
end)
