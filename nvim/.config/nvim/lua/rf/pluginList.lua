local use_nvim_lsp = vim.g.use_nvim_lsp == true

local function config(name)
	return string.format("require('rf.plugins.%s')", name)
end

return {
	'wbthomason/packer.nvim',

	{
		'lewis6991/impatient.nvim',
		rocks = 'mpack',
	},

	{
		-- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open	'antoinemadec/FixCursorHold.nvim',
		setup = function()
			vim.g.cursorhold_updatetime = 250
		end,
	},
	'editorconfig/editorconfig-vim',
	'duggiefresh/vim-easydir',
	'machakann/vim-sandwich',
	'tpope/vim-eunuch',
	'tpope/vim-repeat',
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end,
	},
	'tpope/vim-abolish',
	'Pocco81/TrueZen.nvim',
	'wellle/targets.vim',
	{ 'whiteinge/diffconflicts', cmd = 'DiffConflicts' },

	{
		'neovim/nvim-lspconfig',
		config = config('lsp'),
		requires = {
			'kabouzeid/nvim-lspinstall',
			'hrsh7th/cmp-nvim-lsp',
		},
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
		requires = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
		},
		config = config('cmp'),
	},

	{ 'nvim-lua/lsp-status.nvim', disable = not use_nvim_lsp },

	{
		'ray-x/lsp_signature.nvim',
		disable = not use_nvim_lsp,
	},

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
		config = config('lualine'),
	},

	{
		'goolord/alpha-nvim',
		config = config('alpha'),
	},

	{
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = config('treesitter'),
		requires = { 'nvim-treesitter/nvim-treesitter-textobjects' },
	},

	{
		'windwp/nvim-autopairs',
		config = config('autopairs'),
	},

	{
		'vim-test/vim-test',
		cmd = { 'TestFile', 'TestSuite', 'TestNearest', 'TestVisit', 'TestLast' },
		config = config('vim-test'),
	},

	{
		'nvim-telescope/telescope.nvim',
		config = config('telescope'),
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
		disable = true,
		requires = {
			'nvim-lua/plenary.nvim',
			'kyazdani42/nvim-web-devicons',
			'tamago324/lir-git-status.nvim',
		},
		config = config('lir'),
	},

	{
		'ruifm/gitlinker.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = config('gitlinker'),
	},

	'tpope/vim-fugitive',

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
				signs = {
					-- { CLOSED, OPENED }
					section = { '', '' },
					item = { '', '' },
					hunk = { '', '' },
				},
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
		config = config('gitsigns'),
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
			require('colorizer').setup({}, {
				css = true,
				css_fn = true,
			})
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
		ft = { 'markdown', 'mdx', 'markdown.mdx' },
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
		'folke/which-key.nvim',
		config = config('which-key'),
	},

	{
		'akinsho/toggleterm.nvim',
		config = config('toggleterm'),
	},

	-- {
	-- 	'karb94/neoscroll.nvim',
	-- 	config = function()
	-- 		require('neoscroll').setup()
	-- 	end,
	-- },

	{
		'weilbith/nvim-code-action-menu',
	},

	{
		'IndianBoy42/hop.nvim',
		requires = { 'nvim-treesitter' },
		config = config('hop'),
	},

	{
		'mfussenegger/nvim-dap',
		run = ':helptags ALL',
		requires = { 'David-Kunz/jester' },
		config = config('dap'),
	},

	{
		'L3MON4D3/LuaSnip',
		config = config('luasnip'),
	},

	{
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons',
		config = config('tree'),
	},

	'simeji/winresizer',
	'sindrets/winshift.nvim',
	'kevinhwang91/nvim-bqf',
}
