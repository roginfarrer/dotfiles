local plugin_list = nil
return {
	{
		'folke/snacks.nvim',
		priority = 1000,
		lazy = false,
		dependencies = { 'roginfarrer/fzf-lua-lazy.nvim', dev = true },
		---@type snacks.Config
		opts = {
			bigfile = {},
			dashboard = {},
			gh = {},
			-- notifier = {},
			quickfile = {},
			statuscolumn = {},
			input = {},
			rename = {},
			notifier = {},
			repo = {},
			-- explorer = {},
			picker = {
				enabled = true,
				ui_select = true,
				win = {
					input = {
						keys = {
							['.'] = { 'toggle_ignored', mode = { 'n' } },
							['?'] = { 'toggle_hidden', mode = { 'n' } },
						},
					},
				},
				matches = {
					frecency = true,
					history_bonus = true,
				},
			},
		},
		keys = function()
			---@param builtin string
			---@param args snacks.picker.Config|nil
			local function c(builtin, args)
				return function()
					Snacks.picker[builtin](args)
				end
			end

            -- stylua: ignore
			return {
				{ '<leader>;', function() Snacks.picker.buffers() end, desc = 'Buffers' },
				{ '<leader>b', function() Snacks.picker.buffers() end, desc = 'Buffers' },
				{ '<leader>/', function() Snacks.picker.grep({ hidden = true }) end, desc = 'Grep' },
				{ '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
				{ '<leader>ff', function() Snacks.picker.git_files{ hidden = true } end, desc = 'Find Files (root dir)' },
				{
					'<leader>fF',
					function()
						---@type string
						local cwd = vim.fn.expand '%:p:h'
						if vim.bo.filetype == 'oil' then
							cwd = require('oil').get_current_dir() or cwd
						end
						Snacks.picker.files { cwd = cwd, hidden = true }
					end,
					desc = 'Find Files (from buffer)',
				},
				{
					'<leader>fG',
					function()
						---@type string
						local cwd = vim.fn.expand '%:p:h'
						if vim.bo.filetype == 'oil' then
							cwd = require('oil').get_current_dir() or cwd
						end
						Snacks.picker.grep { cwd = cwd, hidden = true }
					end,
					desc = 'Grep (from buffer)',
				},
				{ '<leader>fd', function() Snacks.picker.git_files({ cwd = '~/dotfiles', hidden = true }) end, desc = 'Dotfiles' },
				{ '<leader>fD', function() Snacks.picker.grep({ cwd = '~/dotfiles', hidden = true }) end, desc = 'Grep Dotfiles' },
				{ '<leader>fh', function() Snacks.picker.recent() end, desc = 'Recent' },
				{ '<leader>fc', function() Snacks.picker.grep_word() end, desc = 'Grep word under cursor' },
				{ '<leader>st', function() Snacks.picker.pickers() end, desc = 'Picker builtins' },
				{ '<leader>sC', function() Snacks.picker.commands() end, desc = 'commands' },
				{ '<leader>sh', function() Snacks.picker.help() end, desc = 'help pages' },
				{ '<leader>sm', function() Snacks.picker.man() end, desc = 'man pages' },
				{ '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'key maps' },
				{ '<leader>ss', function() Snacks.picker.highlights() end, desc = 'search highlight groups' },
				{ '<leader>sa', function() Snacks.picker.autocmds() end, desc = 'auto commands' },
				{ '<leader>sc', function() Snacks.picker.colorschemes() end, desc = 'colorschemes' },
				{ '<leader>sn', function() Snacks.picker.notifications() end, desc = 'notifications' },
				{ '<leader>r', function() Snacks.picker.resume() end, desc = 'Picker resume' },
				{ '<leader>gsl', function() Snacks.picker.git_log() end, desc = 'Picker Git Log' },
				{ '<leader>gss', function() Snacks.picker.git_status() end, desc = 'Picker Git Status' },
				{ '<leader>gsd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
				-- Override Neovim LSP defaults
				{ 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Definitions', nowait = true },
				{ 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Declarations', nowait = true },
				{ 'grr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
				{ 'gri', function() Snacks.picker.lsp_implementations() end, desc = 'Implementations', nowait = true },
				{ 'grt', function() Snacks.picker.lsp_type_definitions() end, desc = 'Type Definitions', nowait = true },
				{ 'gO', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Document Symbols' },
				{ 'gao', function() Snacks.picker.lsp_outgoing_calls() end, desc = 'C[a]lls Outgoing' },
				{ 'gai', function() Snacks.picker.lsp_incoming_calls() end, desc = 'C[a]lls Incoming' },
				{
					'<c-x><c-f>',
					function()
						local curr_path = vim.fn.expand '%:p:h'
						Snacks.picker.pick {
							finder = 'git_files',
							actions = {
								confirm = {
									action = function(picker, selected)
										picker:close()
										if selected.score == 0 then
											return
										end
										vim.api.nvim_put({ selected.file }, '', false, true)
										vim.schedule(function()
											vim.cmd 'startinsert!'
										end)
									end,
								},
								relative = {
									action = function(picker, selected)
										picker:close()
										if selected.score == 0 then
											return
										end
										local path = require('util').makeRelativePath(selected._path, curr_path)
										vim.api.nvim_put({ path }, '', false, true)
										vim.schedule(function()
											vim.cmd 'startinsert!'
										end)
									end,
								},
							},
							win = {
								input = {
									keys = {
										['<c-r>'] = { 'relative', mode = { 'i', 'n' } },
									},
								},
							},
						}
					end,
					desc = 'Fuzzy complete path',
					mode = { 'i' },
				},
				{
					'<leader>fl',
					function()
						if plugin_list == nil then
							plugin_list = {}
							local plugins = require('fzf-lua-lazy.lazy-plugins').plugins

							for _, plugin in ipairs(plugins) do
								local content = vim.fn.readfile(plugin.readme, '')
								local readme = table.concat(content, '\n')

								table.insert(
									plugin_list,
									vim.tbl_deep_extend('force', plugin, {
										file = plugin.path,
										text = plugin.name,
										preview = { text = readme, ft = 'markdown' },
									})
								)
							end
						end

						Snacks.picker.pick {
							finder = function()
								return plugin_list
							end,
							format = 'text',
							preview = 'preview',
							actions = {
								confirm = {
									action = function(picker, selected)
										picker:close()
										local command = string.format('edit %s', selected.readme)
										vim.cmd(command)
									end,
								},
								open_in_browser = {
									action = function(picker, selected)
										local open_cmd
										if vim.fn.executable 'xdg-open' == 1 then
											open_cmd = 'xdg-open'
										elseif vim.fn.executable 'explorer' == 1 then
											open_cmd = 'explorer'
										elseif vim.fn.executable 'open' == 1 then
											open_cmd = 'open'
										elseif vim.fn.executable 'wslview' == 1 then
											open_cmd = 'wslview'
										end

										if not open_cmd then
											vim.notify(
												'Open in browser is not supported by your operating system.',
												vim.log.levels.ERROR,
												{ title = 'Snacks Lazy' }
											)
										else
											local url = selected.url
											local ret = vim.fn.jobstart({ open_cmd, url }, { detach = true })
											picker:close()
											if ret <= 0 then
												vim.notify(
													string.format(
														"Failed to open '%s'\nwith command: '%s' (ret: '%d')",
														url,
														open_cmd,
														ret
													),
													vim.log.levels.ERROR,
													{ title = 'Snacks Lazy' }
												)
											end
										end
									end,
								},
							},
							win = {
								input = {
									keys = {
										['<c-o>'] = { 'open_in_browser', mode = { 'i', 'n' } },
									},
								},
							},
						}
					end,
				},
				-- {
				--   '<C-t>',
				--   function()
				--     Snacks.picker.explorer { hidden = true, auto_close = true }
				--   end,
				--   desc = 'Snacks Explorer',
				-- },
				-- {
				--   '-',
				--   function()
				--     Snacks.picker.explorer { hidden = true, auto_close = true }
				--   end,
				--   desc = 'Snacks Explorer',
				-- },

                -- stylua: ignore start
                { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
                { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
                { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
                { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
			}
		end,
	},
}
