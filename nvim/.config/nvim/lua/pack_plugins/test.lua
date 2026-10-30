vim.schedule(function()
	vim.pack.add {
		'https://github.com/stevearc/overseer.nvim',
		{ src = 'https://github.com/nvim-neotest/neotest', version = 'v5.19.2' },
		'https://github.com/nvim-neotest/neotest-jest',
		'https://github.com/nvim-neotest/nvim-nio',
		'https://github.com/nvim-lua/plenary.nvim',
		'https://github.com/antoinemadec/FixCursorHold.nvim',
	}

	require('overseer').setup {}

	-- local neotest_ns = vim.api.nvim_create_namespace 'neotest'
	-- vim.diagnostic.config({
	-- 	virtual_text = {
	-- 		format = function(diagnostic)
	-- 			-- Replace newline and tab characters with space for more compact diagnostics
	-- 			local message =
	-- 				diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
	-- 			return message
	-- 		end,
	-- 	},
	-- }, neotest_ns)
	require('neotest').setup {
		consumers = {
			overseer = require 'neotest.consumers.overseer',
		},
		adapters = {
			require 'neotest-jest' {
				jest_test_discovery = true,
				env = { CI = true },
				-- require_jest_dependency = false,
			},
		},
		discovery = { enabled = false },
		-- log_level = vim.log.levels.DEBUG,
		icons = require('util.icons').lazy.test,
		quickfix = {
			open = false,
			-- open = function()
			-- 	if require('util').has 'trouble.nvim' then
			-- 		require('trouble').open { mode = 'quickfix', focus = false }
			-- 	else
			-- 		vim.cmd 'copen'
			-- 	end
			-- end,
		},
	}

	local keys = {
		{
			'<leader>tn',
			function()
				require('neotest').run.run()
			end,
			desc = 'Nearest Test',
		},
		{
			'<leader>tf',
			function()
				require('neotest').run.run(vim.fn.expand '%')
			end,
			desc = 'Test File',
		},
		{
			'<leader>tl',
			function()
				require('neotest').run.run_last()
			end,
			desc = 'Last Test',
		},
		{
			'<leader>tw',
			function()
				require('neotest').run.run {
					jestCommand = require('neotest-jest.jest-util').getJestCommand(vim.fn.expand '%:p:h') .. ' --watch',
				}
			end,
			desc = 'Run Watch',
		},
		{
			'[t',
			function()
				require('neotest').jump.prev { status = 'failed' }
			end,
			desc = 'Go to previous failed test',
		},
		{
			']t',
			function()
				require('neotest').jump.next { status = 'failed' }
			end,
			desc = 'Go to next failed test',
		},
		{
			'<leader>ts',
			function()
				require('neotest').summary.toggle()
			end,
			desc = 'Toggle summary',
		},
		{
			'<leader>to',
			function()
				require('neotest').output_panel.toggle()
			end,
			desc = 'Toggle summary',
		},
		{
			'<leader>tS',
			function()
				require('neotest').run.stop()
			end,
			desc = 'Stop test',
		},
		{ '<leader>oo', '<cmd>OverseerToggle<cr>', desc = 'Toggle Overseer' },
		{ '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Run Overseer Task' },
	}

	for _, map in ipairs(keys) do
		Util.keymap(map)
	end
end)
