return {
	{
		'carlos-algms/agentic.nvim',
		enabled = false,
		opts = {
			provider = 'codex-acp',
		},
		keys = {
			{
				'<C-\\>',
				function()
					require('agentic').toggle()
				end,
				mode = { 'n', 'v', 'i' },
				desc = 'Toggle Agentic Chat',
			},
		},
	},

	{
		'folke/sidekick.nvim',
		-- lazy = false,
		enabled = false,
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
			-- {
			-- 	'<tab>',
			-- 	function()
			-- 		-- if there is a next edit, jump to it, otherwise apply it if any
			-- 		if not require('sidekick').nes_jump_or_apply() then
			-- 			return '<Tab>' -- fallback to normal tab
			-- 		end
			-- 	end,
			-- 	expr = true,
			-- 	desc = 'Goto/Apply Next Edit Suggestion',
			-- },
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
		'coder/claudecode.nvim',
		dependencies = { 'folke/snacks.nvim' },
		config = true,
		-- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
		-- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
		-- spec defers loading until a <leader>a* mapping is pressed and the commands
		-- would not exist yet.
		cmd = {
			'ClaudeCode',
			'ClaudeCodeFocus',
			'ClaudeCodeSelectModel',
			'ClaudeCodeAdd',
			'ClaudeCodeSend',
			'ClaudeCodeTreeAdd',
			'ClaudeCodeStatus',
			'ClaudeCodeStart',
			'ClaudeCodeStop',
			'ClaudeCodeOpen',
			'ClaudeCodeClose',
			'ClaudeCodeDiffAccept',
			'ClaudeCodeDiffDeny',
			'ClaudeCodeCloseAllDiffs',
		},
		keys = {
			{ '<leader>a', nil, desc = 'AI/Claude Code' },
			{ '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
			{ '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
			{ '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
			{ '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
			{ '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
			{ '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
			{ '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
			{
				'<leader>as',
				'<cmd>ClaudeCodeTreeAdd<cr>',
				desc = 'Add file',
				ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw', 'snacks_picker_list' },
			},
			-- Diff management
			{ '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
			{ '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
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
}
