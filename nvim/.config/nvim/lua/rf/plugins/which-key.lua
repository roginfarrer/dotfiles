local wk = require('which-key')

wk.setup({
	triggers = 'auto',
	plugins = {
		spelling = {
			enabled = true,
		},
	},
	key_labels = { ['<leader>'] = 'SPC' },
	operators = { gc = 'Comments' },
})

local function get_module_name(s)
	local module_name

	module_name = s:gsub('%.lua', '')
	module_name = module_name:gsub('%/', '.')
	module_name = module_name:gsub('%.init', '')

	return module_name
end

local function searchDotfiles()
	require('telescope.builtin').git_files({
		cwd = '~/dotfiles',
		prompt_title = '~ Dotfiles ~',
		attach_mappings = function(_, map)
			map('i', '<c-e>', function()
				-- these two a very self-explanatory
				local entry = require('telescope.actions.state').get_selected_entry()
				local name = get_module_name(entry.value)

				reloadConfig(name)
			end)
			return true
		end,
	})
end

local leader = {
	[';'] = { '<cmd>Telescope buffers<CR>', 'Buffers' },
	q = { ':q<cr>', 'Quit' },
	w = { ':w<CR>', 'Save' },
	x = { ':wq<cr>', 'Save and Quit' },
	[' '] = 'which_key_ignore',
	y = 'which_key_ignore',
	Y = 'which_key_ignore',
	p = 'which_key_ignore',
	P = 'which_key_ignore',
	g = {
		name = 'Git',
		g = { '<cmd>Neogit<CR>', 'NeoGit' },
		c = { ':GitCopyToClipboard<CR>', 'Copy GitHub URL to Clipboard' },
		o = { ':GitOpenInBrowser<CR>', 'Open File in Browser' },
		b = { '<Cmd>Telescope git_branches<CR>', 'Checkout Branch' },
		C = {
			'<cmd>Telescope git_bcommits<cr>',
			'Checkout commit(for current file)',
		},
		d = { '<cmd>DiffviewOpen<cr>', 'DiffView' },
		-- d = { '<cmd>Gitsigns diffthis HEAD<cr>', 'Git Diff' },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next Hunk' },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev Hunk' },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", 'Blame' },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", 'Preview Hunk' },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", 'Reset Hunk' },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", 'Reset Buffer' },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", 'Stage Hunk' },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			'Undo Stage Hunk',
		},
	},
	t = {
		name = 'Test',
		n = { '<cmd>TestNearest<CR>', 'Test Nearest' },
		f = { '<cmd>TestFile<CR>', 'Test File' },
		s = { '<cmd>TestSuite<CR>', 'Test Suite' },
		l = { '<cmd>TestLast<CR>', 'Test Last' },
		g = { '<cmd>TestVisit<CR>', 'Test Visit' },
		e = { '<cmd>vs<CR>:terminal fish<CR>', 'New Terminal' },
	},
	d = {
		name = 'Configuration',
		d = { searchDotfiles, 'Search Dotfiles' },
		n = { ':e ~/dotfiles/nvim/.config/nvim/pluginList<CR>', 'Open Neovim Config' },
		l = {
			':e ~/.config/nvim/lua/local-config.lua<CR>',
			'Open Local Neovim Config',
		},
		k = {
			':e ~/dotfiles/kitty/.config/kitty/kitty.conf<CR>',
			'Open Kitty Config',
		},
		f = { ':e ~/dotfiles/fish/.config/fish/config.fish<CR>', 'Open Fish Config' },
		r = { reloadConfig, 'Reload Configuration' },
		p = {
			name = 'Plugins',
			p = { '<cmd>PackerSync<cr>', 'Sync' },
			s = { '<cmd>PackerStatus<cr>', 'Status' },
			i = { '<cmd>PackerInstall<cr>', 'Install' },
			c = { '<cmd>PackerCompile<cr>', 'Compile' },
			C = { '<cmd>PackerClean<cr>', 'Clean' },
			l = { '<cmd>PackerLoad<cr>', 'Load' },
			u = { '<cmd>PackerUpdate<cr>', 'Update' },
			P = { '<cmd>PackerProfile<cr>', 'Profile' },
		},
	},
	f = {
		name = 'Find',
		p = { '<cmd>Telescope git_files<CR>', 'Git Files' },
		b = { '<cmd>Telescope buffers<CR>', 'Buffers' },
		f = { '<cmd>Telescope find_files<CR>', 'All Files' },
		['.'] = {
			function()
				require('telescope.builtin').find_files({
					cwd = vim.fn.expand('%:p:h'),
					prompt_title = vim.fn.expand('%:~:.:p:h'),
				})
			end,
			'Find in current directory',
		},
		d = { searchDotfiles, 'Dotfiles' },
		h = { '<cmd>Telescope oldfiles<CR>', 'Old Files' },
		g = { '<cmd>Telescope live_grep<CR>', 'Live Grep' },
		G = {
			function()
				require('telescope.builtin').live_grep({ cwd = vim.fn.expand('%:p:h') })
			end,
			'Live Grep',
		},
	},
	['<tab>'] = {
		name = 'Workspace',
		['<tab>'] = { '<cmd>tabnew<CR>', 'New Tab' },
		n = { '<cmd>tabnext<CR>', 'Next' },
		d = { '<cmd>tabclose<CR>', 'Close' },
		p = { '<cmd>tabprevious<CR>', 'Previous' },
		[']'] = { '<cmd>tabnext<CR>', 'Next' },
		['['] = { '<cmd>tabprevious<CR>', 'Previous' },
		f = { '<cmd>tabfirst<CR>', 'First' },
		l = { '<cmd>tablast<CR>', 'Last' },
	},
	h = {
		name = 'Help',
		t = { '<cmd>Telescope builtin<cr>', 'Telescope' },
		c = { '<cmd>Telescope commands<cr>', 'Commands' },
		h = { '<cmd>Telescope help_tags<cr>', 'Help Pages' },
		m = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
		k = { '<cmd>Telescope keymaps<cr>', 'Key Maps' },
		s = { '<cmd>Telescope highlights<cr>', 'Search Highlight Groups' },
		l = {
			[[<cmd>TSHighlightCapturesUnderCursor<cr>]],
			'Highlight Groups at cursor',
		},
		f = { '<cmd>Telescope filetypes<cr>', 'File Types' },
		o = { '<cmd>Telescope vim_options<cr>', 'Options' },
		a = { '<cmd>Telescope autocommands<cr>', 'Auto Commands' },
	},
	s = {
		name = 'Projects',
		s = { ':SessionSave<CR>', 'Save Session' },
		l = { ':SessionLoad<CR>', 'Load Session' },
		p = { ':Telescope projects<CR>', 'Change Project' },
	},
}

wk.register(leader, { prefix = '<leader>' })

local visual = {
	y = 'which_key_ignore',
	Y = 'which_key_ignore',
	g = {
		name = 'Git',
		c = { [[:'<,'>GitCopyToClipboard<CR>]], 'Copy GitHub URL to Clipboard' },
		o = { [[:'<,'>GitOpenInBrowser<CR>]], 'Open In Browser' },
	},
}

wk.register(visual, { prefix = '<leader>', mode = 'x' })

wk.register({
	['<C-n>'] = { ':TestNearest<CR>', 'Run nearest test' },
	['<C-f>'] = { ':TestFile<CR>', 'Test file' },
	['<C-s>'] = { ':TestSuite<CR>', 'Test suite' },
	['<C-l>'] = { ':TestLast<CR>', 'Run last test' },
	['<C-g>'] = { ':TestVisit<CR>' },
}, {
	prefix = 't',
})