vim.pack.add {
	Util.cb 'cryptomilk/nvim-pack-ui',
	{ src = 'https://github.com/raddari/last-color.nvim' },
	{ src = 'https://github.com/nvim-mini/mini.icons' },
	Util.gh 'dstein64/vim-startuptime',
	Util.gh 'olimorris/persisted.nvim',
}

require('mini.icons').setup {}
MiniIcons.mock_nvim_web_devicons()
require('persisted').setup {
	use_git_branch = true,
	should_autosave = function()
		if vim.bo.filetype == 'noice' then
			return false
		end
		return true
	end,
}

require 'plugins.treesitter'
require 'plugins.dashboard'
require 'plugins.blink'
require 'plugins.lsp'
require 'plugins.oil'
require 'plugins.themes'
require 'plugins.snacks'
require 'plugins.herdr-splits'
require 'plugins.smart-splits'
require 'plugins.conform'
require 'plugins.lint'
require 'plugins.comment'
require 'plugins.lualine'
require 'plugins.which-key'
require 'plugins.git'
require 'plugins.cmdline'
require 'plugins.mini-surround'
require 'plugins.ufo'
require 'plugins.dial'
require 'plugins.flash'
require 'plugins.logging'
require 'plugins.markdown'
require 'plugins.test'
require 'plugins.quickbuf'
require 'plugins.ai'
require 'plugins.yanky'
