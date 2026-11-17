vim.pack.add {
	-- Util.gh 'carlos-algms/agentic.nvim',
	-- Util.gh 'folke/sidekick.nvim',
	Util.gh 'coder/claudecode.nvim',
}

require('claudecode').setup {}

local claudecode_keys = {
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
}

vim.schedule(function()
	require('which-key').add {
		{ '<leader>a', group = 'AI/Claude Code' },
	}
end)

for _, map in ipairs(claudecode_keys) do
	Util.keymap(map)
end

-- require('sidekick').setup {
-- 	nes = {
-- 		enabled = false,
-- 	},
-- 	servers = {
-- 		copilot = {},
-- 	},
-- 	-- add any options here
-- 	cli = {
-- 		mux = {
-- 			backend = 'tmux',
-- 			enabled = true,
-- 		},
-- 	},
-- 	-- debug = true,
-- }
--
-- local sidekick_keys = {
-- 	{
-- 		'<c-.>',
-- 		function()
-- 			require('sidekick.cli').focus()
-- 		end,
-- 		mode = { 'n', 'x', 'i', 't' },
-- 		desc = 'Sidekick Switch Focus',
-- 	},
-- 	{
-- 		'<leader>aa',
-- 		function()
-- 			require('sidekick.cli').toggle { focus = true }
-- 		end,
-- 		desc = 'Sidekick Toggle CLI',
-- 		mode = { 'n', 'v' },
-- 	},
-- 	{
-- 		'<leader>ad',
-- 		function()
-- 			require('sidekick.cli').close()
-- 		end,
-- 		desc = 'Detach a CLI Session',
-- 	},
-- 	{
-- 		'<leader>at',
-- 		function()
-- 			require('sidekick.cli').send { msg = '{this}' }
-- 		end,
-- 		mode = { 'x', 'n' },
-- 		desc = 'Send This',
-- 	},
-- 	{
-- 		'<leader>af',
-- 		function()
-- 			require('sidekick.cli').send { msg = '{file}' }
-- 		end,
-- 		desc = 'Send File',
-- 	},
-- 	{
-- 		'<leader>av',
-- 		function()
-- 			require('sidekick.cli').send { msg = '{selection}' }
-- 		end,
-- 		mode = { 'x' },
-- 		desc = 'Send Visual Selection',
-- 	},
-- 	{
-- 		'<leader>ap',
-- 		function()
-- 			require('sidekick.cli').prompt()
-- 		end,
-- 		mode = { 'n', 'x' },
-- 		desc = 'Sidekick Select Prompt',
-- 	},
-- 	{
-- 		'<leader>aC',
-- 		function()
-- 			require('sidekick.cli').toggle { name = 'claude', focus = true }
-- 		end,
-- 		desc = 'Sidekick Toggle Claude',
-- 	},
-- 	{
-- 		'<leader>ac',
-- 		function()
-- 			require('sidekick.cli').toggle { name = 'codex', focus = true }
-- 		end,
-- 		desc = 'Sidekick Toggle Codex',
-- 	},
-- }
--
-- vim.schedule(function()
-- 	require('which-key').add {
-- 		{ '<leader>a', group = 'ai' },
-- 	}
-- end)
--
-- for _, map in ipairs(sidekick_keys) do
-- 	Util.keymap(map)
-- end
--
-- require('agentic').setup { provider = 'codex-acp' }
-- Util.keymap {
-- 	'<C-\\>',
-- 	function()
-- 		require('agentic').toggle()
-- 	end,
-- 	mode = { 'n', 'v', 'i' },
-- 	desc = 'Toggle Agentic Chat',
-- }

Util.on_event('InsertEnter', function()
	vim.pack.add {
		-- Util.gh'copilotlsp-nvim/copilot-lsp', -- (optional) for NES functionality
		Util.gh 'zbirenbaum/copilot.lua',
	}

	require('copilot').setup {
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
	}
end)
