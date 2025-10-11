return {
	{
		'folke/sidekick.nvim',
		enabled = true,
		opts = {
			servers = {
				copilot = {},
			},
			-- add any options here
			-- cli = {
			-- 	mux = {
			-- 		backend = 'tmux',
			-- 		enabled = true,
			-- 	},
			-- },
			-- debug = true,
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
				'<leader>ac',
				function()
					require('sidekick.cli').toggle { name = 'claude', focus = true }
				end,
				desc = 'Sidekick Claude Toggle',
				mode = { 'n', 'v' },
			},
			{
				'<leader>ap',
				function()
					require('sidekick.cli').select_prompt()
				end,
				desc = 'Sidekick Ask Prompt',
				mode = { 'n', 'v' },
			},
			{
				'<leader>ar',
				function()
					require('sidekick.nes').update()
				end,
				desc = 'Sidekick Refresh Suggestions',
			},
			{
				'<leader>ad',
				function()
					require('sidekick').clear()
				end,
				desc = 'Sidekick Clear',
			},
			{
				'<leader>aj',
				function()
					require('sidekick.nes').jump()
				end,
				desc = 'Sidekick Jump To Next',
			},
			{
				'<leader>ay',
				function()
					require('sidekick').apply()
				end,
				desc = 'Sidekick Apply Edits',
			},
		},
	},

	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		opts = {
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
			'nvim-treesitter/nvim-treesitter',
		},
		opts = {
			strategies = {
				chat = {
					adapter = 'anthropic',
				},
				inline = {
					adapter = 'anthropic',
				},
			},
		},
	},
	{
		'Exafunction/windsurf.nvim',
		enabled = false,
		event = 'InsertEnter',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		opts = {
			virtual_text = { enabled = true },
			enable_cmp_source = false,
		},
		config = function(_, opts)
			require('codeium').setup(opts)
		end,
	},
	-- {
	--   'CopilotC-Nvim/CopilotChat.nvim',
	--   dependencies = {
	--     { 'nvim-lua/plenary.nvim' }, -- for curl, log and async functions
	--   },
	--   build = 'make tiktoken', -- Only on MacOS or Linux
	--   cmd = {
	--     'CopilotChatPrompts',
	--     'CopilotChatReview',
	--     'CopilotChatExplain',
	--     'CopilotChatFix',
	--     'CopilotChatOptimize',
	--     'CopilotChatDocs',
	--     'CopilotChatTests',
	--     'CopilotChatCommit',
	--     'CopilotChatModels',
	--   },
	--   opts = {
	--     -- See Configuration section for options
	--   },
	--   -- See Commands section for default commands if you want to lazy load on them
	-- },
	{
		'yetone/avante.nvim',
		enabled = false,
		event = 'VeryLazy',
		version = false, -- Never set this value to "*"! Never!
		opts = {
			provider = 'claude',
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = 'make',
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-lua/plenary.nvim',
			'MunifTanjim/nui.nvim',
		},
		keys = {
			{ '<leader>a', nil, group = 'avante' },
		},
		specs = {
			{
				'saghen/blink.cmp',
				opts = function(_, opts)
					opts = opts or {}
					opts.sources = opts.sources or {}
					table.insert(opts.sources.default or {}, 1, 'avante')
					return vim.tbl_deep_extend('force', opts, {
						providers = {
							avante = {
								module = 'blink-cmp-avante',
								name = 'Avante',
								opts = {
									-- options for blink-cmp-avante
								},
							},
						},
					})
					-- opts = opts or {}
					-- opts.sources = opts.sources or {}
					-- table.insert(opts.sources.default or {}, 1, 'avante')
					-- opts.sources.providers = opts.sources.providers or {}
					-- opts.sources.providers.avante = {
					--   module = 'blink-cmp-avante',
					--   name = 'Avante',
					--   opts = {
					--     -- options for blink-cmp-avante
					--   },
					-- }
					-- return opts
				end,
			},
		},
	},

	{
		'greggh/claude-code.nvim',
		enabled = false,
		dependencies = {
			'nvim-lua/plenary.nvim', -- Required for git operations
		},
		config = function()
			require('claude-code').setup()
		end,
		keys = { '<C-,>', '<leader>ac' },
		cmd = { 'ClaudeCode', 'ClaudeCodeContinue', 'ClaudeCodeResume', 'ClaudeCodeVerbose' },
	},

	{
		'coder/claudecode.nvim',
		enabled = false,
		cmd = { 'ClaudeCode', 'ClaudeCodeSend', 'ClaudeCodeFocus', 'ClaudeCodeAdd' },
		dependencies = { 'folke/snacks.nvim' },
		config = true,
		keys = {
			{ '<leader>a', nil, desc = 'AI/Claude Code' },
			{ '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
			{ '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
			{ '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
			{ '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
			{ '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
			{ '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
			{
				'<leader>as',
				'<cmd>ClaudeCodeTreeAdd<cr>',
				desc = 'Add file',
				ft = { 'NvimTree', 'neo-tree', 'oil' },
			},
			-- Diff management
			{ '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
			{ '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
		},
	},
}
