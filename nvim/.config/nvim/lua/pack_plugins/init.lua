vim.pack.add {
	Util.cb 'cryptomilk/nvim-pack-ui',
	{ src = 'https://github.com/raddari/last-color.nvim' },
	{ src = 'https://github.com/nvim-mini/mini.icons' },
	Util.gh 'nvim-mini/mini.starter',
}

require('mini.icons').setup {}
MiniIcons.mock_nvim_web_devicons()
require('mini.starter').setup()

require 'pack_plugins.treesitter'
require 'pack_plugins.blink'
require 'pack_plugins.lsp'
require 'pack_plugins.oil'
require 'pack_plugins.themes'
require 'pack_plugins.snacks'
require 'pack_plugins.herdr-splits'
require 'pack_plugins.conform'
require 'pack_plugins.comment'
require 'pack_plugins.lualine'
require 'pack_plugins.which-key'
require 'pack_plugins.git'
require 'pack_plugins.cmdline'
require 'pack_plugins.mini-surround'
require 'pack_plugins.ufo'
require 'pack_plugins.dial'
require 'pack_plugins.flash'
require 'pack_plugins.logging'
require 'pack_plugins.markdown'
require 'pack_plugins.test'
require 'pack_plugins.quickbuf'
require 'pack_plugins.ai'
