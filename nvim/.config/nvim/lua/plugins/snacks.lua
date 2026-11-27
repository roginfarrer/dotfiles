vim.pack.add {
	Util.gh 'folke/snacks.nvim',
	Util.gh '2kabhishek/seeker.nvim',
}

require('snacks').setup {
	bigfile = {},
	-- dashboard = {
	-- 	preset = {
	--                 -- stylua: ignore
	-- 			    keys = {
	-- 			        { icon = ' ', key = 'f', desc = 'Find File', action = ":lua require('seeker').seek{picker_opts = {hidden = true}}", },
	-- 			        -- { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
	-- 			        { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')", },
	-- 			        { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')", },
	-- 			        { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
	--                     -- { icon = '󰕚 ', key = 'd', desc = 'CodeDiff', action = '<cmd>CodeDiff<CR>' },
	--                     { icon = '󰕚 ', key = 'd', desc = 'Diffview', action = '<cmd>DiffviewOpen<CR>' },
	-- 			        { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
	-- 			        { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil, },
	--                     { icon = " ", key = "m", desc = "Mason", action = ":Mason", enabled = package.loaded.lazy ~= nil },
	--                     { icon = " ", key = "h", desc = "Health", action = ":checkhealth" },
	-- 			        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
	-- 			    },
	-- 	},
	-- },
	gh = {},
	quickfile = {},
	statuscolumn = {},
	input = {},
	lazygit = {},
	rename = {},
	repo = {},
	notifier = {},
	-- explorer = {},
	picker = {
		enabled = true,
		ui_select = true,
		previewers = {
			git = { builtin = false },
		},
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
}

local keys = {
	-- { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
	-- {
	-- 	'<leader>;',
	-- 	function()
	-- 		Snacks.picker.buffers()
	-- 	end,
	-- 	desc = 'Buffers',
	-- },
	-- { '<leader>b', function() Snacks.picker.buffers() end, desc = 'Buffers' },
	{
		'<leader>/',
		function()
			Snacks.picker.grep { hidden = true }
		end,
		desc = 'Grep',
	},
	{
		'<leader>:',
		function()
			Snacks.picker.command_history()
		end,
		desc = 'Command History',
	},
	{
		'<leader>ff',
		function()
			require('seeker').seek { picker_opts = { hidden = true } }
		end,
		desc = 'Find Files (root dir)',
	},
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
	{
		'<leader>fd',
		function()
			Snacks.picker.git_files { cwd = '~/dotfiles', hidden = true }
		end,
		desc = 'Dotfiles',
	},
	{
		'<leader>fD',
		function()
			Snacks.picker.grep { cwd = '~/dotfiles', hidden = true }
		end,
		desc = 'Grep Dotfiles',
	},
	{
		'<leader>fh',
		function()
			Snacks.picker.recent()
		end,
		desc = 'Recent',
	},
	{
		'<leader>fc',
		function()
			Snacks.picker.grep_word()
		end,
		desc = 'Grep word under cursor',
	},
	{
		'<leader>st',
		function()
			Snacks.picker.pickers()
		end,
		desc = 'Picker builtins',
	},
	{
		'<leader>sC',
		function()
			Snacks.picker.commands()
		end,
		desc = 'commands',
	},
	{
		'<leader>sh',
		function()
			Snacks.picker.help()
		end,
		desc = 'help pages',
	},
	{
		'<leader>sm',
		function()
			Snacks.picker.man()
		end,
		desc = 'man pages',
	},
	{
		'<leader>sk',
		function()
			Snacks.picker.keymaps()
		end,
		desc = 'key maps',
	},
	{
		'<leader>ss',
		function()
			Snacks.picker.highlights()
		end,
		desc = 'search highlight groups',
	},
	{
		'<leader>sa',
		function()
			Snacks.picker.autocmds()
		end,
		desc = 'auto commands',
	},
	{
		'<leader>sc',
		function()
			Snacks.picker.colorschemes()
		end,
		desc = 'colorschemes',
	},
	{
		'<leader>sn',
		function()
			Snacks.picker.notifications()
		end,
		desc = 'notifications',
	},
	{
		'<leader>r',
		function()
			Snacks.picker.resume()
		end,
		desc = 'Picker resume',
	},
	{
		'<leader>gsl',
		function()
			Snacks.picker.git_log()
		end,
		desc = 'Picker Git Log',
	},
	{
		'<leader>gss',
		function()
			Snacks.picker.git_status()
		end,
		desc = 'Picker Git Status',
	},
	{
		'<leader>gsd',
		function()
			Snacks.picker.git_diff()
		end,
		desc = 'Git Diff (Hunks)',
	},
	-- Override Neovim LSP defaults
	{
		'gd',
		function()
			Snacks.picker.lsp_definitions()
		end,
		desc = 'Definitions',
		nowait = true,
	},
	{
		'gD',
		function()
			Snacks.picker.lsp_declarations()
		end,
		desc = 'Declarations',
		nowait = true,
	},
	{
		'grr',
		function()
			Snacks.picker.lsp_references()
		end,
		nowait = true,
		desc = 'References',
	},
	{
		'gri',
		function()
			Snacks.picker.lsp_implementations()
		end,
		desc = 'Implementations',
		nowait = true,
	},
	{
		'grt',
		function()
			Snacks.picker.lsp_type_definitions()
		end,
		desc = 'Type Definitions',
		nowait = true,
	},
	{
		'gO',
		function()
			Snacks.picker.lsp_symbols()
		end,
		desc = 'LSP Document Symbols',
	},
	{
		'gao',
		function()
			Snacks.picker.lsp_outgoing_calls()
		end,
		desc = 'C[a]lls Outgoing',
	},
	{
		'gai',
		function()
			Snacks.picker.lsp_incoming_calls()
		end,
		desc = 'C[a]lls Incoming',
	},
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
    -- stylua: ignore start
    { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
    { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
    { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
    { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
}

for _, map in ipairs(keys) do
	Util.keymap(map)
end
