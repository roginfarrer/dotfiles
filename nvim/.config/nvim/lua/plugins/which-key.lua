local wk = require('which-key')

local presets = require('which-key.plugins.presets')
presets.objects['a('] = nil
wk.setup({
	triggers = 'auto',
	plugins = { spelling = true },
	key_labels = { ['<leader>'] = 'SPC' },
})

local function searchDotfiles()
	require('telescope.builtin').git_files({
		cwd = '~/dotfiles',
		prompt = '~ dotfiles ~',
	})
end

local leader = {
	[' '] = { '<cmd>e #<cr>', 'Switch to Last Buffer' },
	[';'] = { '<cmd>Telescope buffers<CR>', 'Buffers' },
	q = { ':q<cr>', 'Quit' },
	w = { ':w<CR>', 'Save' },
	x = { ':wq<cr>', 'Save and Quit' },
	p = 'which_key_ignore',
	P = 'which_key_ignore',
	y = 'which_key_ignore',
	Y = 'which_key_ignore',
	g = {
		name = 'Git',
		g = { '<cmd>Neogit<CR>', 'NeoGit' },
		c = { ':GitCopyToClipboard<CR>', 'Open File in Browser' },
		o = { ':GitOpenInBrowser<CR>', 'Copy GitHub URL to Clipboard' },
		b = { '<Cmd>Telescope git_branches<CR>', 'Checkout Branch' },
		s = { '<Cmd>Telescope git_status<CR>', 'Open changed file' },
		C = {
			'<cmd>Telescope git_bcommits<cr>',
			'Checkout commit(for current file)',
		},
		d = { '<cmd>DiffviewOpen<cr>', 'DiffView' },
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
		p = {
			name = 'Plugins',
			p = { '<cmd>PackerSync<cr>', 'Sync' },
			s = { '<cmd>PackerStatus<cr>', 'Status' },
			i = { '<cmd>PackerInstall<cr>', 'Install' },
			c = { '<cmd>PackerCompile<cr>', 'Compile' },
		},
	},
	f = {
		name = 'Find',
		p = { '<cmd>Telescope git_files<CR>', 'Git Files' },
		b = { '<cmd>Telescope buffers<CR>', 'Buffers' },
		['.'] = { '<cmd>Telescope find_files<CR>', 'All Files' },
		d = { searchDotfiles, 'Dotfiles' },
		h = { '<cmd>Telescope oldfiles<CR>', 'Old Files' },
		g = { '<cmd>Telescope live_grep<CR>', 'Live Grep' },
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
		t = { '<cmd>:Telescope builtin<cr>', 'Telescope' },
		c = { '<cmd>:Telescope commands<cr>', 'Commands' },
		h = { '<cmd>:Telescope help_tags<cr>', 'Help Pages' },
		m = { '<cmd>:Telescope man_pages<cr>', 'Man Pages' },
		k = { '<cmd>:Telescope keymaps<cr>', 'Key Maps' },
		s = { '<cmd>:Telescope highlights<cr>', 'Search Highlight Groups' },
		l = {
			[[<cmd>TSHighlightCapturesUnderCursor<cr>]],
			'Highlight Groups at cursor',
		},
		f = { '<cmd>:Telescope filetypes<cr>', 'File Types' },
		o = { '<cmd>:Telescope vim_options<cr>', 'Options' },
		a = { '<cmd>:Telescope autocommands<cr>', 'Auto Commands' },
	},
	l = {
		name = 'LSP',
		a = { ':Lspsaga code_action<CR>', 'Code Action' },
		r = { ':Lspsaga rename<CR>', 'Rename Symbol' },
		f = { ':Format<CR>', 'Format Document' },
		x = { ':TroubleToggle<CR>', 'Trouble' },
	},
	s = {
		name = 'Projects',
		s = { ':SessionSave<CR>', 'Save Session' },
		l = { ':SessionLoad<CR>', 'Load Session' },
		p = { ':Telescope projects<CR>', 'Change Project' },
	},
}

wk.register(leader, { prefix = '<leader>' })
