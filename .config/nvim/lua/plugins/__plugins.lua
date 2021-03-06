local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	vim.fn.execute("packadd packer.nvim")
end

vim.cmd([[packadd packer.nvim]])
-- Run :PackerCompile whenver this file is updated
vim.cmd([[autocmd BufWritePost __plugins.lua PackerCompile]])

return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim", opt = true })

	use({
		"itchyny/lightline.vim",
		config = function()
			vim.cmd("source $HOME/.config/nvim/vim/lightline.vim")
		end,
	})
	use({
		"mhinz/vim-startify",
		config = function()
			require("plugins.startify")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use("machakann/vim-sandwich")
	use("tpope/vim-commentary")
	use("tpope/vim-sleuth")
	use("junegunn/goyo.vim")
	use({
		"steelsojka/pears.nvim",
		config = function()
			require("pears").setup()
		end,
	})
	use("tpope/vim-abolish")
	use("dhruvasagar/vim-open-url")
	use({
		"vim-test/vim-test",
		config = function()
			require("plugins.vim-test")
		end,
	})
	use("wellle/targets.vim")
	if vim.fn.isdirectory("/usr/local/opt/fzf") then
		use({ "/usr/local/opt/fzf", opt = vim.g.use_telescope })
	else
		use({ "junegunn/fzf", rtp = "~/.fzf", run = "./install --bin", opt = vim.g.use_telescope })
	end
	use({
		"junegunn/fzf.vim",
		opt = vim.g.use_telescope,
		config = function()
			vim.cmd("source $HOME/.config/nvim/vim/fzf.vim")
		end,
	})
	-- use({
	-- 	"nvim-telescope/telescope.nvim",
	-- 	config = function()
	-- 		require("plugins.telescope")
	-- 	end,
	-- 	opt = not vim.g.use_telescope,
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-lua/popup.nvim",
	-- 		"nvim-telescope/telescope-fzf-writer.nvim",
	-- 	},
	-- })
	use({
		"camspiers/snap",
		config = function()
			require("plugins.snap")
		end,
	})
	use("justinmk/vim-dirvish")
	use({ "roginfarrer/vim-dirvish-dovish", branch = "main" })
	use("tpope/vim-eunuch")
	use("duggiefresh/vim-easydir")
	use("jesseleite/vim-agriculture")
	use({
		"tpope/vim-fugitive",
		config = function()
			require("plugins.git")
		end,
	})
	use({
		"TimUntersberger/neogit",
		config = function()
			require("neogit").setup({
				-- override/add mappings
				mappings = {
					-- modify status buffer mappings
					status = {
						-- Adds a mapping with "B" as key that does the "BranchPopup" command
						["B"] = "BranchPopup",
					},
				},
			})
		end,
	})
	use({
		"tpope/vim-rhubarb",
		config = function()
			require("plugins.git")
		end,
	})
	use("whiteinge/diffconflicts")
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use({
		"neoclide/coc.nvim",
		branch = "release",
		opt = vim.g.use_nvim_lsp,
		config = function()
			require("plugins.coc")
		end,
	})
	use({
		"kabouzeid/nvim-lspinstall",
		opt = not vim.g.use_nvim_lsp,
		config = function()
			require("lspinstall").setup()
		end,
	})
	use({
		"onsails/lspkind-nvim",
		opt = not vim.g.use_nvim_lsp,
		config = function()
			require("lspkind").init()
		end,
	})
	use({
		"folke/trouble.nvim",
		opt = not vim.g.use_nvim_lsp,
		config = function()
			require("trouble").setup()
		end,
	})
	use({
		"glepnir/lspsaga.nvim",
		opt = not vim.g.use_nvim_lsp,
	})
	use({ "neovim/nvim-lspconfig", opt = not vim.g.use_nvim_lsp })
	use({ "jose-elias-alvarez/nvim-lsp-ts-utils", opt = not vim.g.use_nvim_lsp })
	use({
		"ray-x/lsp_signature.nvim",
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		opt = not vim.g.use_nvim_lsp,
	})
	use("svermeulen/vimpeccable")
	use({
		"hrsh7th/nvim-compe",
		opt = not vim.g.use_nvim_lsp,
		config = function()
			require("plugins.compe")
		end,
	})
	use({
		"voldikss/vim-floaterm",
		config = function()
			require("plugins.floaterm")
		end,
	})
	use({
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})
	use("kyazdani42/nvim-web-devicons")
	use("ryanoasis/vim-devicons")
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	use({ "jxnblk/vim-mdx-js" })
	use({
		"tpope/vim-markdown",
		config = function()
			require("plugins.polyglot")
		end,
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Colors
	use("Rigellute/rigel")
	use("cocopon/iceberg.vim")
	use("bluz71/vim-nightfly-guicolors")
	use({ "Dualspc/spaceodyssey", branch = "lua" })
	use("windwp/wind-colors")
	use({ "metalelf0/jellybeans-nvim", requires = { "rktjmp/lush.nvim" } })
	use("christianchiarulli/nvcode-color-schemes.vim")
	use({ "folke/tokyonight.nvim" })
	use({ "lighthaus-theme/vim-lighthaus" })
	use("shaunsingh/moonlight.nvim")
	-- use(
	--   {
	--     "mhartington/formatter.nvim",
	--     config = function()
	--       require("plugins.format")
	--     end
	--   }
	-- )
	-- use {
	--   "kkoomen/vim-doge",
	--   run = ":call doge#install()",
	--   config = function()
	--     require "plugins.doge"
	--   end
	-- }
end)
