return {
	{
		'folke/sidekick.nvim',
		-- lazy = false,
		enabled = true,
		opts = {
			nes = {
				enabled = false,
			},
			servers = {
				copilot = {},
			},
			-- add any options here
			cli = {
				mux = {
					backend = 'tmux',
					enabled = true,
				},
			},
			-- debug = true,
		},
		specs = {
			{
				'which-key.nvim',
				optional = true,
				init = function()
					require('which-key').add {
						{ '<leader>a', group = 'ai' },
					}
				end,
			},
		},
		keys = {
			{
				'<tab>',
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if not require('sidekick').nes_jump_or_apply() then
						return '<Tab>' -- fallback to normal tab
					end
				end,
				expr = true,
				desc = 'Goto/Apply Next Edit Suggestion',
			},
			{
				'<c-.>',
				function()
					require('sidekick.cli').focus()
				end,
				mode = { 'n', 'x', 'i', 't' },
				desc = 'Sidekick Switch Focus',
			},
			{ '<leader>a', nil, desc = 'AI' },
			{
				'<leader>aa',
				function()
					require('sidekick.cli').toggle { focus = true }
				end,
				desc = 'Sidekick Toggle CLI',
				mode = { 'n', 'v' },
			},
			{
				'<leader>ad',
				function()
					require('sidekick.cli').close()
				end,
				desc = 'Detach a CLI Session',
			},
			{
				'<leader>at',
				function()
					require('sidekick.cli').send { msg = '{this}' }
				end,
				mode = { 'x', 'n' },
				desc = 'Send This',
			},
			{
				'<leader>af',
				function()
					require('sidekick.cli').send { msg = '{file}' }
				end,
				desc = 'Send File',
			},
			{
				'<leader>av',
				function()
					require('sidekick.cli').send { msg = '{selection}' }
				end,
				mode = { 'x' },
				desc = 'Send Visual Selection',
			},
			{
				'<leader>ap',
				function()
					require('sidekick.cli').prompt()
				end,
				mode = { 'n', 'x' },
				desc = 'Sidekick Select Prompt',
			},
			{
				'<leader>aC',
				function()
					require('sidekick.cli').toggle { name = 'claude', focus = true }
				end,
				desc = 'Sidekick Toggle Claude',
			},
			{
				'<leader>ac',
				function()
					require('sidekick.cli').toggle { name = 'codex', focus = true }
				end,
				desc = 'Sidekick Toggle Codex',
			},
		},
	},

	{
		'zbirenbaum/copilot.lua',
		enabled = true,
		dependencies = {
			'copilotlsp-nvim/copilot-lsp', -- (optional) for NES functionality
		},
		cmd = 'Copilot',
		event = 'InsertEnter',
		opts = {
			nes = {
				enabled = false,
				keymap = {
					accept_and_goto = '<tab>',
					accept = false,
					dismiss = '<esc>',
				},
			},
			suggestion = {
				enabled = false,
				auto_trigger = true,
				hide_during_completion = true,
				keymap = {
					accept = false,
				},
				-- keymap = {
				-- 	accept = '<C-y>',
				-- 	accept_word = false,
				-- 	accept_line = false,
				-- 	next = '<leader>]',
				-- 	prev = '<leader>[',
				-- 	dismiss = '<C-]>',
				-- },
			},
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},

	-- {
	--   'saghen/blink.cmp',
	--   dependencies = { 'fang2hou/blink-copilot' },
	--   opts = {
	--     sources = {
	--       default = { 'copilot' },
	--       providers = {
	--         copilot = {
	--           module = 'blink-copilot',
	--           name = 'copilot',
	--           score_offset = 100,
	--           async = true,
	--         },
	--       },
	--     },
	--   },
	-- },
	{
		'CopilotC-Nvim/CopilotChat.nvim',
		enabled = false,
		dependencies = {
			{ 'zbirenbaum/copilot.lua' },
			{ 'nvim-lua/plenary.nvim' }, -- for curl, log and async functions
		},
		build = 'make tiktoken', -- Only on MacOS or Linux
		opts = {},
		cmd = { 'CopilotChat' },
		keys = {
			{ '<leader>a', '<cmd>CopilotChat<CR>', desc = 'Copilot Chat' },
		},
	},

	{
		'olimorris/codecompanion.nvim',
		enabled = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		event = 'VeryLazy',
		opts = {
			-- adapters = {
			-- 	http = {
			-- 		anthropic = function()
			-- 			return require('codecompanion.adapters').extend('anthropic', {
			-- 				env = {
			-- 					api_key = 'ANTHROPIC_API_KEY',
			-- 				},
			-- 			})
			-- 		end,
			-- 	},
			-- },
			strategies = {
				chat = {
					adapter = 'anthropic',
				},
				inline = {
					adapter = 'anthropic',
				},
				cmd = {
					adapter = 'anthropic',
				},
			},
			opts = {
				log_level = 'DEBUG',
			},
		},
	},
}
