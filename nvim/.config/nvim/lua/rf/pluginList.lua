local use_nvim_lsp = vim.g.use_nvim_lsp == true

return {
	'wbthomason/packer.nvim',

	{
		'lewis6991/impatient.nvim',
		rocks = 'mpack',
	},

	'antoinemadec/FixCursorHold.nvim', -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open

	{
		'neovim/nvim-lspconfig',
		config = function()
			require('rf.plugins.lsp')
		end,
		requires = {
			'kabouzeid/nvim-lspinstall',
			'hrsh7th/cmp-nvim-lsp',
		},
	},

	{
		'neoclide/coc.nvim',
		branch = 'release',
		disable = use_nvim_lsp,
		config = function()
			require('rf.plugins.coc')
		end,
	},

	{
		'jose-elias-alvarez/null-ls.nvim',
		requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
		config = function()
			if not use_nvim_lsp then
				require('rf.plugins.null-ls')
			end
		end,
	},

	---
	-- LSP
	---

	{
		'onsails/lspkind-nvim',
		event = { 'BufRead', 'BufNewFile' },
		disable = not use_nvim_lsp,
		config = function()
			require('lspkind').init({ preset = 'codicons' })
		end,
	},

	{
		'folke/trouble.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		disable = not use_nvim_lsp,
		cmd = { 'Trouble', 'TroubleToggle' },
		config = function()
			require('trouble').setup({})
		end,
	},

	{
		'jose-elias-alvarez/nvim-lsp-ts-utils',
		requires = { 'null-ls.nvim' },
		disable = not use_nvim_lsp,
	},

	{
		'ms-jpq/coq_nvim',
		branch = 'coq',
		disable = true,
		requires = {
			{ 'ms-jpq/coq.artifacts', branch = 'artifacts' },
		},
		setup = function()
			require('rf.plugins.coq')
		end,
	},

	{
		'hrsh7th/nvim-cmp',
		-- disable = true,
		-- event = 'InsertEnter',
		requires = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
			{ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
			{ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
			{ 'hrsh7th/cmp-path', after = 'nvim-cmp' },
		},
		config = function()
			require('rf.plugins.cmp')
		end,
	},

	{ 'nvim-lua/lsp-status.nvim', disable = not use_nvim_lsp },

	---
	-- End LSP
	---

	-- use({
	-- 	'ggandor/lightspeed.nvim',
	-- 	config = function()
	-- 		require('utils').nmap('m', '<Plug>Lightspeed_s')
	-- 		require('utils').nmap('M', '<Plug>Lightspeed_S')
	-- 	end,
	-- })

	{
		'vuki656/package-info.nvim',
		disable = true,
		requires = 'MunifTanjim/nui.nvim',
		ft = 'json',
		config = function()
			require('package-info').setup()
		end,
	},

	{
		'shadmansaleh/lualine.nvim',
		after = 'nightfox.nvim',
		requires = {
			'kyazdani42/nvim-web-devicons',
		},
		config = function()
			require('rf.plugins.lualine')
		end,
	},

	{
		'mhinz/vim-startify',
		disable = true,
		config = function()
			require('rf.plugins.startify')
		end,
	},

	{
		'glepnir/dashboard-nvim',
		setup = function()
			require('rf.plugins.dashboard')
		end,
	},

	{
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('rf.plugins.treesitter')
		end,
		requires = { 'nvim-treesitter/nvim-treesitter-textobjects' },
	},

	{
		'windwp/nvim-autopairs',
		config = function()
			require('rf.plugins.autopairs')
		end,
	},

	{
		'vim-test/vim-test',
		-- cmd = { 'TestFile', 'TestSuite', 'TestNearest', 'TestVisit', 'TestLast' },
		rocks = 'lunajson',
		config = function()
			require('rf.plugins.vim-test')
		end,
	},

	{
		'nvim-telescope/telescope.nvim',
		config = function()
			require('rf.plugins.telescope')
		end,
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzy-native.nvim',
			'nvim-telescope/telescope-fzf-writer.nvim',
			'ahmedkhalf/project.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				run = 'make',
			},
		},
	},

	{
		'tamago324/lir.nvim',
		-- event = { 'BufRead', 'BufNewFile' },
		requires = {
			'nvim-lua/plenary.nvim',
			'kyazdani42/nvim-web-devicons',
			'tamago324/lir-git-status.nvim',
		},
		config = function()
			require('rf.plugins.lir')
		end,
	},

	{
		'ruifm/gitlinker.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('rf.plugins.gitlinker')
		end,
	},

	{
		'TimUntersberger/neogit',
		cmd = 'Neogit',
		requires = {
			'nvim-lua/plenary.nvim',
			{
				'sindrets/diffview.nvim',
				cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
			},
		},
		config = function()
			require('neogit').setup({
				integrations = {
					diffview = true,
				},
			})
		end,
	},

	{
		'lewis6991/gitsigns.nvim',
		event = { 'BufRead', 'BufNewFile' },
		requires = {
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require('rf.plugins.gitsigns')
		end,
	},

	{
		'kyazdani42/nvim-web-devicons',
		config = function()
			require('nvim-web-devicons').setup({
				override = {
					lir_folder_icon = {
						icon = '',
						color = '#7ebae4',
						name = 'LirFolderNode',
					},
				},
			})
		end,
	},

	{
		'norcalli/nvim-colorizer.lua',
		event = { 'BufRead', 'BufNewFile' },
		config = function()
			require('colorizer').setup()
		end,
	},

	{
		'windwp/nvim-ts-autotag',
		config = function()
			require('nvim-ts-autotag').setup()
		end,
	},

	{ 'jxnblk/vim-mdx-js', event = { 'BufRead', 'BufNewFile' } },

	{
		'tpope/vim-markdown',
		-- event = { 'BufRead', 'BufNewFile' },
		ft = 'markdown',
		config = function()
			require('rf.plugins.polyglot')
		end,
	},

	'JoosepAlviste/nvim-ts-context-commentstring',

	-- Colors
	{
		'folke/tokyonight.nvim',
		config = function()
			require('rf.theme')
		end,
	},
	'shaunsingh/nord.nvim',
	{ 'siduck76/nvim-base16.lua' },
	{
		'EdenEast/nightfox.nvim',
		config = function()
			require('rf.theme')
		end,
	},

	{
		'windwp/nvim-spectre',
		requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
		-- cmd = { 'FindAndReplace' },
		setup = function()
			vim.cmd(
				[[command! FindAndReplace lua require('spectre').open({is_insert_mode = true})]]
			)
			require('rf.utils').nnoremap('<leader>fr', [[:FindAndReplace<CR>]])
		end,
	},

	{
		'kkoomen/vim-doge',
		run = ':call doge#install()',
		cmd = { 'DogeGenerate', 'DogeCreateDocStandard' },
		config = function()
			require('rf.plugins.doge')
		end,
	},

	{
		'folke/which-key.nvim',
		config = function()
			require('rf.plugins.which-key')
		end,
	},

	{
		'akinsho/toggleterm.nvim',
		config = function()
			require('rf.plugins.toggleterm')
		end,
	},

	{
		'karb94/neoscroll.nvim',
		config = function()
			require('neoscroll').setup()
		end,
	},

	{
		'IndianBoy42/hop.nvim',
		requires = { 'nvim-treesitter' },
		as = 'hop',
		config = [[require('rf.plugins.hop')]],
	},

	{ 'tpope/vim-eunuch', event = { 'BufRead', 'BufNewFile' } },
	{ 'duggiefresh/vim-easydir', event = { 'BufRead', 'BufNewFile' } },
	{ 'machakann/vim-sandwich', event = { 'BufRead', 'BufNewFile' } },
	{ 'tpope/vim-commentary', event = { 'BufRead', 'BufNewFile' } },
	{ 'tpope/vim-abolish', event = { 'BufRead', 'BufNewFile' } },
	{ 'whiteinge/diffconflicts', cmd = 'DiffConflicts' },
	'Pocco81/TrueZen.nvim',
	{ 'wellle/targets.vim', event = 'BufEnter' },
	{
		'mfussenegger/nvim-dap',
		run = ':helptags ALL',
		requires = { 'David-Kunz/jester' },
		config = function()
			require('rf.plugins.dap')
		end,
	},
	{
		'sindrets/winshift.nvim',
		config = function()
			require('rf.plugins.winshift')
		end,
	},
	'editorconfig/editorconfig-vim',
	{
		'L3MON4D3/LuaSnip',
		config = function()
			require('rf.plugins.luasnip')
		end,
	},
}
