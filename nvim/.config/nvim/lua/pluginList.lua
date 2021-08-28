local use_nvim_lsp = vim.g.use_nvim_lsp == true

local present, _ = pcall(require, 'packerInit')
local packer

if present then
	packer = require('packer')
else
	return false
end

local use = packer.use

return packer.startup(function()
	use({ 'wbthomason/packer.nvim', opt = true })

	use({
		'vuki656/package-info.nvim',
		event = 'BufRead',
		config = function()
			require('package-info').setup()
		end,
	})

	use({
		'shadmansaleh/lualine.nvim',
		requires = {
			'kyazdani42/nvim-web-devicons',
		},
		config = function()
			require('plugins.lualine')
		end,
	})

	use({
		'mhinz/vim-startify',
		config = function()
			require('plugins.startify')
		end,
	})

	use({
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		event = 'BufRead',
		config = function()
			require('plugins.treesitter')
		end,
	})

	use({
		'David-Kunz/treesitter-unit',
		requires = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			vim.api.nvim_set_keymap(
				'x',
				'iu',
				':lua require"treesitter-unit".select()<CR>',
				{ noremap = true }
			)
			vim.api.nvim_set_keymap(
				'x',
				'au',
				':lua require"treesitter-unit".select(true)<CR>',
				{ noremap = true }
			)
			vim.api.nvim_set_keymap(
				'o',
				'iu',
				':<c-u>lua require"treesitter-unit".select()<CR>',
				{ noremap = true }
			)
			vim.api.nvim_set_keymap(
				'o',
				'au',
				':<c-u>lua require"treesitter-unit".select(true)<CR>',
				{ noremap = true }
			)
		end,
	})

	use('machakann/vim-sandwich')

	use('tpope/vim-commentary')
	use('tpope/vim-sleuth')
	use({ 'junegunn/goyo.vim', cmd = 'Goyo' })

	use({
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		config = function()
			require('nvim-autopairs').setup({})
		end,
	})

	use('tpope/vim-abolish')

	use({ 'dhruvasagar/vim-open-url', cmd = '<Plug>(open-url-browser)' })

	use({
		'vim-test/vim-test',
		cmd = { 'TestFile', 'TestSuite', 'TestNearest' },
		config = function()
			require('plugins.vim-test')
		end,
		setup = function()
			require('mappings').test()
		end,
	})

	use({
		'kassio/neoterm',
		setup = function()
			vim.g.neoterm_default_mod = 'vertical'
			vim.g.neoterm_shell = 'fish'
		end,
	})

	use({ 'wellle/targets.vim', event = 'BufEnter' })

	use({
		'nvim-telescope/telescope.nvim',
		config = function()
			require('plugins.telescope')
		end,
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzf-writer.nvim',
		},
	})

	use({
		'ahmedkhalf/project.nvim',
		after = 'telescope.nvim',
		config = function()
			require('project_nvim').setup({})
			require('telescope').load_extension('projects')
		end,
	})

	use({
		'camspiers/snap',
		disable = true,
		config = function()
			require('plugins.snap')
		end,
	})

	-- use({"justinmk/vim-dirvish", opt = false})
	-- use({"roginfarrer/vim-dirvish-dovish", opt = false, branch = "main"})

	use({
		'tamago324/lir.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			'kyazdani42/nvim-web-devicons',
			'tamago324/lir-git-status.nvim',
		},
		config = function()
			require('plugins.lir')
		end,
	})

	use('tpope/vim-eunuch')
	use('duggiefresh/vim-easydir')
	use('jesseleite/vim-agriculture')

	use({
		'ruifm/gitlinker.nvim',
		requires = 'nvim-lua/plenary.nvim',
		cmd = { 'GBrowse' },
		config = function()
			require('plugins.gitlinker')
		end,
		setup = function()
			require('mappings').gitlinker()
		end,
	})

	use({
		'TimUntersberger/neogit',
		cmd = 'Neogit',
		requires = {
			'nvim-lua/plenary.nvim',
			'sindrets/diffview.nvim',
		},
		config = function()
			require('neogit').setup({
				integrations = {
					diffview = true,
				},
			})
		end,
	})

	use('whiteinge/diffconflicts')

	use({
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require('gitsigns').setup()
		end,
	})

	use({
		'neoclide/coc.nvim',
		event = 'BufRead',
		branch = 'release',
		disable = use_nvim_lsp,
		config = function()
			require('plugins.coc')
		end,
	})

	use({
		'kabouzeid/nvim-lspinstall',
		disable = not use_nvim_lsp,
		config = function()
			require('lspinstall').setup()
		end,
	})

	use({
		'onsails/lspkind-nvim',
		event = 'BufEnter',
		disable = not use_nvim_lsp,
		config = function()
			require('lspkind').init()
		end,
	})

	use({
		'folke/trouble.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		disable = not use_nvim_lsp,
		cmd = { 'Trouble', 'TroubleToggle' },
		config = function()
			require('trouble').setup({})
		end,
	})

	use({
		'glepnir/lspsaga.nvim',
		disable = not use_nvim_lsp,
	})

	use({
		'neovim/nvim-lspconfig',
	})

	use({
		'jose-elias-alvarez/nvim-lsp-ts-utils',
		disable = not use_nvim_lsp,
	})

	-- use(
	--   {
	--     "ray-x/lsp_signature.nvim",
	--     disable = not use_nvim_lsp
	--     -- cond = function()
	--     --   return use_nvim_lsp
	--     -- end,
	--   }
	-- )

	use({
		'jose-elias-alvarez/null-ls.nvim',
		requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
		config = function()
			if use_nvim_lsp then
				require('plugins.null-ls')
			end
		end,
		-- disable = not use_nvim_lsp
	})

	use({ 'svermeulen/vimpeccable' })

	use({
		'ms-jpq/coq_nvim',
		branch = 'coq',
		disable = true,
		requires = {
			{ 'ms-jpq/coq.artifacts', branch = 'artifacts' },
		},
		setup = function()
			vim.g.coq_settings = {
				auto_start = true,
			}
		end,
	})

	use({
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
		},
		config = function()
			require('plugins.cmp')
		end,
	})

	use({
		'voldikss/vim-floaterm',
		cmd = { 'FloatermToggle', 'FloatTermNew' },
		config = function()
			vim.g.floaterm_shell = 'fish'
		end,
		setup = function()
			require('mappings').floatterm()
		end,
	})

	use({
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
	})

	use('ryanoasis/vim-devicons')

	use({
		'norcalli/nvim-colorizer.lua',
		event = 'BufRead',
		config = function()
			require('colorizer').setup()
		end,
	})

	use({
		'windwp/nvim-ts-autotag',
		after = 'nvim-treesitter',
		config = function()
			require('nvim-ts-autotag').setup()
		end,
	})

	use({ 'jxnblk/vim-mdx-js', event = 'BufRead' })

	use({
		'tpope/vim-markdown',
		event = 'BufRead',
		config = function()
			require('plugins.polyglot')
		end,
	})

	use({ 'JoosepAlviste/nvim-ts-context-commentstring', event = 'BufRead' })

	-- Colors
	-- use('Rigellute/rigel')
	-- use('cocopon/iceberg.vim')
	-- use('bluz71/vim-nightfly-guicolors')
	-- use({ 'Dualspc/spaceodyssey', branch = 'lua' })
	-- use('windwp/wind-colors')
	-- use({ 'metalelf0/jellybeans-nvim', requires = { 'rktjmp/lush.nvim' } })
	-- use('christianchiarulli/nvcode-color-schemes.vim')
	use({
		'folke/tokyonight.nvim',
		config = function()
			require('theme')
		end,
	})
	-- use({ 'lighthaus-theme/vim-lighthaus' })
	-- use('shaunsingh/moonlight.nvim')
	-- use({ 'siduck76/nvim-base16.lua' })
	-- use({
	-- 	'EdenEast/nightfox.nvim',
	-- 	config = function()
	-- 		require('theme')
	-- 	end,
	-- })

	use({
		'mhartington/formatter.nvim',
		-- event = "BufRead",
		disable = true,
		config = function()
			require('plugins.format')
		end,
	})

	use({
		'windwp/nvim-spectre',
		requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
		cmd = { 'FindAndReplace' },
		setup = function()
			vim.cmd(
				[[command! FindAndReplace lua require('spectre').open({is_insert_mode = true})]]
			)
			require('utils').nnoremap('<leader>fr', [[:FindAndReplace<CR>]])
		end,
	})

	use({
		'kkoomen/vim-doge',
		run = ':call doge#install()',
		cmd = { 'DogeGenerate', 'DogeCreateDocStandard' },
		config = function()
			require('plugins.doge')
		end,
	})

	use({
		'folke/which-key.nvim',
		config = function()
			require('plugins.which-key')
		end,
	})
end)
