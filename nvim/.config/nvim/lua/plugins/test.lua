return {
	-- testing integration
	{
		'nvim-neotest/neotest',
		-- https://github.com/nvim-neotest/neotest/issues/531
		commit = '52fca6717ef972113ddd6ca223e30ad0abb2800c',
		enabled = true,
		cond = not vim.g.disable_treesitter,
		dependencies = {
			{ 'nvim-neotest/neotest-jest' },
			'nvim-neotest/nvim-nio',
			'nvim-lua/plenary.nvim',
			'antoinemadec/FixCursorHold.nvim',
			'nvim-treesitter/nvim-treesitter',
		},
		config = function()
			local neotest_ns = vim.api.nvim_create_namespace 'neotest'
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						-- Replace newline and tab characters with space for more compact diagnostics
						local message =
							diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
						return message
					end,
				},
			}, neotest_ns)
			require('neotest').setup {
				adapters = {
					require 'neotest-jest' {
						jest_test_discovery = false,
						env = { CI = true },
						-- require_jest_dependency = false,
					},
				},
				discovery = { enabled = false },
				log_level = vim.log.levels.DEBUG,
				icons = require('ui.icons').lazy.test,
				output = { open_on_run = true },
				quickfix = {
					open = function()
						if require('util').has 'trouble.nvim' then
							require('trouble').open { mode = 'quickfix', focus = false }
						else
							vim.cmd 'copen'
						end
					end,
				},
			}
		end,
		keys = {
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
						jestCommand = require('neotest-jest.jest-util').getJestCommand(vim.fn.expand '%:p:h')
							.. ' --watch',
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
		},
	},

	{
		'mfussenegger/nvim-dap',
		dependencies = {
			{ 'nvim-neotest/nvim-nio' },
			{
				'rcarriga/nvim-dap-ui',
				keys = {
					{
						'<leader>du',
						function()
							require('dapui').toggle {}
						end,
						desc = 'Dap UI',
					},
					{
						'<leader>de',
						function()
							require('dapui').eval()
						end,
						desc = 'Eval',
						mode = { 'n', 'v' },
					},
				},
				opts = {},
				config = function(_, opts)
					-- setup dap config by VsCode launch.json file
					-- require("dap.ext.vscode").load_launchjs()
					local dap = require 'dap'
					local dapui = require 'dapui'
					dapui.setup(opts)
					dap.listeners.after.event_initialized['dapui_config'] = function()
						dapui.open {}
					end
					dap.listeners.before.event_terminated['dapui_config'] = function()
						dapui.close {}
					end
					dap.listeners.before.event_exited['dapui_config'] = function()
						dapui.close {}
					end
				end,
			},
			-- virtual text for the debugger
			{ 'theHamsta/nvim-dap-virtual-text', opts = {} },
			-- {
			--   'mxsdev/nvim-dap-vscode-js',
			--   dependencies = {
			--     {
			--       -- stylua: ignore
			--       { 'microsoft/vscode-js-debug', build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out' },
			--     },
			--   },
			--   opts = {
			--     debugger_path = vim.fn.getenv 'HOME' .. '/.local/share/nvim/lazy/vscode-js-debug',
			--   },
			-- },
			-- mason.nvim integration
			{
				'jay-babu/mason-nvim-dap.nvim',
				lazy = false,
				cmd = { 'DapInstall', 'DapUninstall' },
				-- opts = {},
			},
		},
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
    },
		config = function()
			local dap = require 'dap'
			dap.adapters['pwa-node'] = {
				type = 'server',
				host = 'localhost',
				port = '${port}',
				executable = {
					command = 'node',
					-- 💀 Make sure to update this path to point to your installation
					args = { vim.env.HOME .. '/js-debug/src/dapDebugServer.js', '${port}' },
				},
			}
			dap.adapters.node2 = {
				type = 'executable',
				command = 'node',
				args = { os.getenv 'HOME' .. '/development/vscode-node-debug2/out/src/nodeDebug.js' },
			}

			for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' } do
				if not dap.configurations[language] then
					dap.configurations[language] = {
						-- {
						--   type = 'node2',
						--   request = 'launch',
						--   name = 'Launch file',
						--   program = '${file}',
						--   cwd = '${workspaceFolder}',
						--   runtimeArgs = { '--inspect-brk', '$path_to_jest', '--no-coverage', '-t', '$result', '--', '$file' },
						--   args = { '--no-cache' },
						--   sourceMaps = false,
						--   protocol = 'inspector',
						--   skipFiles = { '<node_internals>/**/*.js' },
						--   console = 'integratedTerminal',
						--   port = 9229,
						--   disableOptimisticBPs = true,
						-- },
						{
							name = 'Launch',
							type = 'node2',
							request = 'launch',
							program = '${file}',
							cwd = vim.fn.getcwd(),
							sourceMaps = true,
							protocol = 'inspector',
							console = 'integratedTerminal',
						},
						{
							-- For this to work you need to make sure the node process is started with the `--inspect` flag.
							name = 'Attach to process',
							type = 'node2',
							request = 'attach',
							processId = require('dap.utils').pick_process,
						},
						{
							type = 'pwa-node',
							request = 'launch',
							name = 'Launch file',
							program = '${file}',
							cwd = '${workspaceFolder}',
						},
					}
				end
			end
		end,
	},

	{
		'David-Kunz/jester',
		enabled = false,
		event = { 'BufReadPre' },
		dependencies = { 'nvim-neotest/neotest' },
		config = function()
			require('util').autocmd('FileType', {
				pattern = 'javascript,typescript,typescriptreact,javascriptreact',
				group = 'rf-jester',
				callback = function(evt)
					if vim.b.is_jest ~= nil then
						return
					end

					local file = evt.file
					local util = require 'neotest-jest.util'
					local is_jest = util.search_ancestors(file, function(path)
						if util.path.is_file(util.path.join(path, 'jest.config.js')) then
							return path
						end
					end)
					vim.b.is_jest = is_jest
					if not vim.b.is_jest then
						return
					end
					require('which-key').add {
						{
							'<leader>tn',
							function()
								require('jester').run()
							end,
							desc = 'Nearest Test (Jester)',
							buffer = true,
						},
						{
							'<leader>tf',
							function()
								require('jester').run_file()
							end,
							desc = 'Test File (Jester)',
							buffer = true,
						},
						{
							'<leader>tl',
							function()
								require('jester').run_last()
							end,
							desc = 'Last Test (Jester)',
							buffer = true,
						},
						{
							'<leader>td',
							function()
								require('jester').debug()
							end,
							desc = 'Debug Test (Jester)',
							buffer = true,
						},
					}
				end,
			})

			require('jester').setup {
				cmd = "yarnpkg jest -t '$result' $file", -- run command
				path_to_jest_debug = './node_modules/.bin/jest', -- used for debugging
				path_to_run_jest = './node_modules/.bin/jest', -- used for debugging
			}
		end,
	},

	{
		'vim-test/vim-test',
		enabled = false,
		cmd = { 'TestNearest', 'TestClass', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit' },
		dependencies = {
			{ 'jebaum/vim-tmuxify' },
		},
		init = function()
			vim.cmd [[ let test#strategy = 'tmuxify' ]]
		end,

		keys = {
			{
				'<leader>tn',
				'<cmd>TestNearest<cr>',
				desc = 'Nearest Test',
			},
			{
				'<leader>tf',
				'<cmd>TestFile<cr>',
				desc = 'Test File',
			},
			{
				'<leader>tl',
				'<cmd>TestLast<cr>',
				desc = 'Last Test',
			},
		},
	},
}
