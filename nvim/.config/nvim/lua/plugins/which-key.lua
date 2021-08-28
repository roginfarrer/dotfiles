local wk = require('which-key')

local presets = require('which-key.plugins.presets')
presets.objects['a('] = nil
wk.setup({
	triggers = 'auto',
	plugins = { spelling = true },
	key_labels = { ['<leader>'] = 'SPC' },
})

function _G.gitCopyToClipboard(range)
	local mode = range > 0 and 'v' or 'n'
	require('gitlinker').get_buf_range_url(
		mode,
		{ action_callback = require('gitlinker.actions').copy_to_clipboard }
	)
end
function _G.gitOpenInBrowser(range)
	local mode = range > 0 and 'v' or 'n'
	require('gitlinker').get_buf_range_url(
		mode,
		{ action_callback = require('gitlinker.actions').open_in_browser }
	)
end

vim.cmd([[
		command! -nargs=0 -range GitCopyToClipboard call v:lua.gitCopyToClipboard(<range>)
	]])
vim.cmd([[
		command! -nargs=0 -range GitOpenInBrowser call v:lua.gitOpenInBrowser(<range>)
	]])

local function searchDotfiles()
	require('telescope.builtin').git_files({
		cwd = '~/dotfiles',
		prompt = '~ dotfiles ~',
	})
end

local leader = {
	g = {
		name = '+git',
		g = { '<cmd>Neogit<CR>', 'NeoGit' },
		o = {
			function()
				_G.gitOpenInBrowser('n')
			end,
			'open in browser',
		},
		c = {
			function()
				_G.gitCopyToClipboard('n')
			end,
			'copy github url to clipboard',
		},
		b = { '<Cmd>Telescope git_branches<CR>', 'branches' },
		s = { '<Cmd>Telescope git_status<CR>', 'status' },
		d = { '<cmd>DiffviewOpen<cr>', 'DiffView' },
	},
	t = {
		name = 'terminal/test',
		n = { '<cmd>TestNearest<CR>', 'Test Nearest' },
		f = { '<cmd>TestFile<CR>', 'Test File' },
		s = { '<cmd>TestSuite<CR>', 'Test Suite' },
		l = { '<cmd>TestLast<CR>', 'Test Last' },
		g = { '<cmd>TestVisit<CR>', 'Test Visit' },
		e = { '<cmd>vs<CR>:terminal fish<CR>', 'New Terminal' },
	},
	f = {
		name = 'find',
		p = { '<cmd>Telescope git_files<CR>', 'Git Files' },
		b = { '<cmd>Telescope buffers<CR>', 'Buffers' },
		['.'] = { '<cmd>Telescope find_files<CR>', 'All Files' },
		d = { searchDotfiles, 'Dotfiles' },
		h = { '<cmd>Telescope oldfiles<CR>', 'Old Files' },
		g = {
			'<cmd> lua require("telescope").extensions.fzf_writer.staged_grep()<CR>',
			'Live Grep',
		},
	},
	q = {
		name = 'quit/session',
		q = { '<cmd>:q<cr>', 'Close Buffer' },
		a = { '<cmd>:qa<cr>', 'Quit' },
		x = { '<cmd>:x<cr>', 'Save and Quit' },
		['!'] = { '<cmd>:qa!<cr>', 'Quit without saving' },
	},
	x = {
		name = 'errors',
		x = { '<cmd>TroubleToggle<cr>', 'Trouble' },
		w = { '<cmd>TroubleWorkspaceToggle<cr>', 'Workspace Trouble' },
		d = { '<cmd>TroubleDocumentToggle<cr>', 'Document Trouble' },
		t = { '<cmd>TodoTrouble<cr>', 'Todo Trouble' },
		T = { '<cmd>TodoTelescope<cr>', 'Todo Telescope' },
		l = { '<cmd>lopen<cr>', 'Open Location List' },
		q = { '<cmd>copen<cr>', 'Open Quickfix List' },
	},
	['<tab>'] = {
		name = 'workspace',
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
		name = 'help',
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
		p = {
			name = '+packer',
			p = { '<cmd>PackerSync<cr>', 'Sync' },
			s = { '<cmd>PackerStatus<cr>', 'Status' },
			i = { '<cmd>PackerInstall<cr>', 'Install' },
			c = { '<cmd>PackerCompile<cr>', 'Compile' },
		},
	},
	[' '] = { '<cmd>e #<cr>', 'Switch to Last Buffer' },
	[';'] = { '<cmd>Telescope buffers<CR>', 'Buffers' },
	w = { '<cmd>w<CR>', 'Save' },
	p = 'which_key_ignore',
	P = 'which_key_ignore',
	y = 'which_key_ignore',
	Y = 'which_key_ignore',
}

wk.register(leader, { prefix = '<leader>' })
