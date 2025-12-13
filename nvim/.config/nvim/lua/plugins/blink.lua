return {
	{
		'saghen/blink.cmp',
		events = 'InsertEnter',
		-- optional: provides snippets for the snippet source
		dependencies = {
			{
				'Kaiser-Yang/blink-cmp-git',
				dependencies = { 'nvim-lua/plenary.nvim' },
			},
			'fang2hou/blink-copilot',
			'ribru17/blink-cmp-spell',
			{
				'nvim-mini/mini.snippets',
				version = false,
				dependencies = { 'rafamadriz/friendly-snippets' },
				config = function()
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
				end,
			},
		},
		-- use a release tag to download pre-built binaries
		version = '1.*',
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		opts = {
			sources = {
				default = {
					'copilot',
					'lsp',
					'path',
					'snippets',
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
			completion = {
				menu = {
					draw = {
						treesitter = { 'lsp' },
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
		},
	},
}
