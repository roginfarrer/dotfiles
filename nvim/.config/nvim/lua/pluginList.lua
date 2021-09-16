-- If your Neovim install doesn't include mpack, e.g. if installed via
-- Homebrew, then you need to also install mpack from luarocks.
-- There is an existing issue with luarocks on macOS where `luarocks install` is using a different version of lua.
-- @see: https://github.com/wbthomason/packer.nvim/issues/180
-- Make sure to add this on top of your plugins.lua to resolve this
vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')

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
	use('wbthomason/packer.nvim')
	use({
		'lewis6991/impatient.nvim',
		rocks = 'mpack',
	})

	use({
		'neovim/nvim-lspconfig',
		config = function()
			require('plugins.lsp')
		end,
		requires = {
			'kabouzeid/nvim-lspinstall',
			-- 'hrsh7th/cmp-nvim-lsp',
		},
	})

	use({
		'neoclide/coc.nvim',
		-- event = {"BufRead", "BufNewFile"},
		branch = 'release',
		disable = use_nvim_lsp,
		config = function()
			require('plugins.coc')
		end,
	})

	use({
		'jose-elias-alvarez/null-ls.nvim',
		requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
		config = function()
			if not use_nvim_lsp then
				require('plugins.null-ls')
			end
		end,
	})

	---
	-- LSP
	---

	use({
		'onsails/lspkind-nvim',
		event = { 'BufRead', 'BufNewFile' },
		disable = not use_nvim_lsp,
		config = function()
			require('lspkind').init({ preset = 'codicons' })
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
		'jose-elias-alvarez/nvim-lsp-ts-utils',
		requires = { 'null-ls.nvim' },
		disable = not use_nvim_lsp,
	})

	use({
		'ms-jpq/coq_nvim',
		branch = 'coq',
		-- disable = true,
		requires = {
			{ 'ms-jpq/coq.artifacts', branch = 'artifacts' },
		},
		setup = function()
			require('plugins.coq')
		end,
	})

	use({
		'hrsh7th/nvim-cmp',
		disable = true,
		-- event = 'InsertEnter',
		requires = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
			{ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
			{ 'hrsh7th/cmp-path', after = 'nvim-cmp' },
		},
		config = function()
			require('plugins.cmp')
		end,
	})

	use({ 'nvim-lua/lsp-status.nvim', disable = not use_nvim_lsp })

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

	use({
		'vuki656/package-info.nvim',
		requires = 'MunifTanjim/nui.nvim',
		ft = 'json',
		config = function()
			require('package-info').setup()
		end,
	})

	use({
		'shadmansaleh/lualine.nvim',
		after = 'nightfox.nvim',
		requires = {
			'kyazdani42/nvim-web-devicons',
		},
		config = function()
			require('plugins.lualine')
		end,
	})

	use({
		'mhinz/vim-startify',
		disable = true,
		config = function()
			require('plugins.startify')
		end,
	})

	use({
		'glepnir/dashboard-nvim',
		setup = function()
			require('plugins.dashboard')
		end,
	})

	use({
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('plugins.treesitter')
		end,
		requires = { 'nvim-treesitter/nvim-treesitter-textobjects' },
	})

	use({
		'windwp/nvim-autopairs',
		config = function()
			require('plugins.autopairs')
		end,
	})

	use({
		'vim-test/vim-test',
		cmd = { 'TestFile', 'TestSuite', 'TestNearest', 'TestVisit', 'TestLast' },
		config = function()
			require('plugins.vim-test')
		end,
	})

	use({
		'nvim-telescope/telescope.nvim',
		config = function()
			require('plugins.telescope')
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
	})

	use({
		'tamago324/lir.nvim',
		event = { 'BufRead', 'BufNewFile' },
		requires = {
			'nvim-lua/plenary.nvim',
			'kyazdani42/nvim-web-devicons',
			'tamago324/lir-git-status.nvim',
		},
		config = function()
			require('plugins.lir')
		end,
	})

	use({
		'ruifm/gitlinker.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('plugins.gitlinker')
		end,
	})

	use({
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
	})

	use({
		'lewis6991/gitsigns.nvim',
		event = { 'BufRead', 'BufNewFile' },
		requires = {
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require('plugins.gitsigns')
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

	use({
		'norcalli/nvim-colorizer.lua',
		event = { 'BufRead', 'BufNewFile' },
		config = function()
			require('colorizer').setup()
		end,
	})

	use({
		'windwp/nvim-ts-autotag',
		config = function()
			require('nvim-ts-autotag').setup()
		end,
	})

	use({ 'jxnblk/vim-mdx-js', event = { 'BufRead', 'BufNewFile' } })

	use({
		'tpope/vim-markdown',
		-- event = { 'BufRead', 'BufNewFile' },
		ft = 'markdown',
		config = function()
			require('plugins.polyglot')
		end,
	})

	use({
		'JoosepAlviste/nvim-ts-context-commentstring',
	})

	-- Colors
	use({
		'folke/tokyonight.nvim',
		config = function()
			require('theme')
		end,
	})
	use('shaunsingh/nord.nvim')
	use({ 'siduck76/nvim-base16.lua' })
	use({
		'EdenEast/nightfox.nvim',
		config = function()
			require('theme')
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

	use({
		'akinsho/toggleterm.nvim',
		config = function()
			require('plugins.toggleterm')
		end,
	})

	-- use({
	-- 	'karb94/neoscroll.nvim',
	-- 	config = function()
	-- 		require('neoscroll').setup()
	-- 	end,
	-- })

	-- use('antoinemadec/FixCursorHold.nvim') -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open

	use({ 'tpope/vim-eunuch', event = { 'BufRead', 'BufNewFile' } })
	use({ 'duggiefresh/vim-easydir', event = { 'BufRead', 'BufNewFile' } })
	use({ 'machakann/vim-sandwich', event = { 'BufRead', 'BufNewFile' } })
	use({ 'tpope/vim-commentary', event = { 'BufRead', 'BufNewFile' } })
	use({ 'tpope/vim-abolish', event = { 'BufRead', 'BufNewFile' } })
	use({ 'whiteinge/diffconflicts', cmd = 'DiffConflicts' })
	use('Pocco81/TrueZen.nvim')
	use({ 'wellle/targets.vim', event = 'BufEnter' })
	use({
		'mfussenegger/nvim-dap',
		run = ':helptags ALL',
		requires = { 'David-Kunz/jester' },
		config = function()
			require('plugins.dap')
		end,
	})
	use({
		'sindrets/winshift.nvim',
		config = function()
			require('plugins.winshift')
		end,
	})
	use('editorconfig/editorconfig-vim')
	use({
		'L3MON4D3/LuaSnip',
		config = function()
			require('plugins.luasnip')
		end,
	})
end)
