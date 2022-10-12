vim.cmd 'packadd packer.nvim'

local function config(name)
  return string.format("require('plugins.configs.%s')", name)
end

local function misc(name)
  return require('plugins.configs.misc')[name]
end

local plugins = {
  ['wbthomason/packer.nvim'] = {},
  ['nvim-lua/plenary.nvim'] = {},
  -- ['nathom/filetype.nvim'] = {},

  ['lewis6991/impatient.nvim'] = { rocks = 'mpack' },

  -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  ['antoinemadec/FixCursorHold.nvim'] = {
    setup = function()
      vim.g.cursorhold_updatetime = 250
    end,
  },

  ['kyazdani42/nvim-web-devicons'] = { config = misc 'devicons' },

  ['ggandor/leap.nvim'] = { config = misc 'leap' },

  ['glacambre/firenvim'] = {
    run = function()
      vim.fn['firenvim#install'](0)
    end,
  },

  -- -- -- -- -- -- -- -- -- -- -- -- --
  --  Language Server Protocol (LSP)  --
  -- -- -- -- -- -- -- -- -- -- -- -- --

  ['williamboman/mason.nvim'] = {
    config = config 'lsp',
    requires = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  },
  ['folke/lua-dev.nvim'] = {},
  ['jose-elias-alvarez/null-ls.nvim'] = {},
  ['jose-elias-alvarez/nvim-lsp-ts-utils'] = {},
  ['neovim/nvim-lspconfig'] = {},
  ['j-hui/fidget.nvim'] = { config = misc 'fidget' },
  ['glepnir/lspsaga.nvim'] = {},
  ['hrsh7th/nvim-cmp'] = {
    config = config 'cmp',
    requires = {
      'saadparwaiz1/cmp_luasnip',
      'petertriho/cmp-git',
      'David-Kunz/cmp-npm',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
  },
  ['mtoohey31/cmp-fish'] = { ft = 'fish' },
  ['L3MON4D3/LuaSnip'] = { config = config 'luasnip' },
  ['windwp/nvim-autopairs'] = { config = config 'autopairs' },
  -- ['zbirenbaum/copilot.lua'] = {
  --   event = 'InsertEnter',
  --   config = function()
  --     vim.schedule(function()
  --       require('copilot').setup()
  --     end)
  --   end,
  -- },
  -- ['zbirenbaum/copilot-cmp'] = {
  --   module = 'copilot_cmp',
  -- },

  -- -- -- -- -- --
  --   Editing   --
  -- -- -- -- -- --

  ['jghauser/mkdir.nvim'] = { event = 'CmdlineEnter' },
  -- ['echasnovski/mini.nvim'] = { config = config 'mini' },
  ['kylechui/nvim-surround'] = { config = config 'surround' },
  ['tpope/vim-eunuch'] = { event = 'CmdlineEnter' },
  ['tpope/vim-abolish'] = { event = 'CmdlineEnter' },
  ['wellle/targets.vim'] = { event = 'CursorMoved' },
  ['numToStr/Comment.nvim'] = { config = config 'comment' },
  -- ['ThePrimeagen/harpoon'] = { module_pattern = 'harpoon*' },
  -- ['AckslD/nvim-neoclip.lua'] = {},
  ['Julian/vim-textobj-variable-segment'] = {
    requires = 'kana/vim-textobj-user',
    event = 'CursorMoved',
  },
  ['axelvc/template-string.nvim'] = { config = misc 'template_string' },

  -- -- -- -- -- -- -- --
  --   User Interface  --
  -- -- -- -- -- -- -- --

  ['goolord/alpha-nvim'] = { config = config 'alpha' },
  ['nvim-lualine/lualine.nvim'] = { config = config 'lualine' },
  -- ['b0o/incline.nvim'] = { config = config 'incline' },
  ['nvim-treesitter/nvim-treesitter'] = {
    run = ':TSUpdate',
    config = config 'treesitter',
  },
  ['lewis6991/spellsitter.nvim'] = {
    config = function()
      require('spellsitter').setup()
    end,
  },
  ['nvim-treesitter/nvim-treesitter-textobjects'] = { event = 'BufRead' },
  ['JoosepAlviste/nvim-ts-context-commentstring'] = {},
  ['windwp/nvim-ts-autotag'] = {},
  ['folke/which-key.nvim'] = { config = config 'which-key' },
  ['kevinhwang91/nvim-bqf'] = { ft = 'qf' },
  -- ['akinsho/bufferline.nvim'] = { config = config 'bufferline' },
  ['kdheepak/tabline.nvim'] = { config = misc 'tabline' },
  ['sindrets/winshift.nvim'] = {
    config = config 'winshift',
    cmd = 'WinShift',
  },
  ['kevinhwang91/nvim-ufo'] = {
    requires = 'kevinhwang91/promise-async',
    after = 'nvim-treesitter',
    config = config 'ufo',
  },

  ['akinsho/toggleterm.nvim'] = {
    tag = 'v2.*',
    config = config 'toggleterm',
  },

  -- -- -- --
  --  Git  --
  -- -- -- --

  ['tpope/vim-fugitive'] = {
    cmd = {
      'Git',
      'GBrowse',
      'GDelete',
      'GMove',
      'Ggrep',
      'Gwrite',
      'Gread',
      'Gdiffsplit',
      'Gvdiffsplit',
      'Gedit',
    },
    requires = { 'tpope/vim-rhubarb' },
  },
  -- ['ruifm/gitlinker.nvim'] = { config = config 'gitlinker' },
  ['sindrets/diffview.nvim'] = {
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  },
  -- {
  --   'TimUntersberger/neogit',
  --   cmd = 'Neogit',
  --   requires = {
  --     {
  --       'sindrets/diffview.nvim',
  --       cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  --     },
  --   },
  --   config = config 'neogit',
  -- },
  ['lewis6991/gitsigns.nvim'] = {
    config = config 'gitsigns',
  },
  -- {
  --   'lambdalisue/suda.vim',
  --   cmd = { 'SudaRead', 'SudaWrite' },
  --   setup = function()
  --     vim.g.suda_smart_edit = 1
  --   end,
  -- },
  ['akinsho/git-conflict.nvim'] = {
    config = misc 'git-conflict',
  },
  ['pwntester/octo.nvim'] = {
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('octo').setup()
    end,
  },
  ['ThePrimeagen/git-worktree.nvim'] = {},
  -- ['matbme/JABS.nvim'] = { config = misc 'jabs' },

  -- -- -- -- -- -- -- --
  --   File Browsing   --
  -- -- -- -- -- -- -- --

  ['tamago324/lir.nvim'] = {
    keys = '-',
    requires = {
      'tamago324/lir-git-status.nvim',
    },
    config = config 'lir',
  },
  ['nvim-telescope/telescope.nvim'] = {
    config = config 'telescope',
    requires = {
      'nvim-telescope/telescope-node-modules.nvim',
      { 'roginfarrer/telescope-packer.nvim', branch = 'patch-1' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
      },
      'nvim-telescope/telescope-file-browser.nvim',
    },
  },
  -- ['ahmedkhalf/project.nvim'] = {},

  -- -- -- -- -- -- -- --
  --  Themes & Syntax  --
  -- -- -- -- -- -- -- --

  ['jxnblk/vim-mdx-js'] = { ft = { 'mdx', 'markdown.mdx' } },
  ['fladson/vim-kitty'] = { ft = 'kitty' },
  ['catppuccin/nvim'] = { as = 'catppuccin', run = 'CatppuccinCompile' },
  -- ['B4mbus/oxocarbon-lua.nvim'] = {},
  -- ['~/projects/catppuccin-nvim'] = { as = 'catppuccin' },
  ['p00f/nvim-ts-rainbow'] = {},
  ['ellisonleao/glow.nvim'] = {},
  -- ['EdenEast/nightfox.nvim'] = {},

  -- -- -- -- -- -- -- --
  --  New For Testing  --
  -- -- -- -- -- -- -- --

  -- 'Matt-A-Bennett/vim-surround-funk',
  -- ['stevearc/dressing.nvim'] = {},
  ['moll/vim-bbye'] = { cmd = 'Bdelete' },
  ['mrjones2014/smart-splits.nvim'] = {},
  ['anuvyklack/windows.nvim'] = {
    requires = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    config = function()
      -- vim.o.winwidth = 10
      -- vim.o.winminwidth = 10
      -- vim.o.equalalways = false
      -- require('windows').setup()
    end,
  },
  ['Shatur/neovim-session-manager'] = { config = config 'sessions' },
  ['nvim-neotest/neotest'] = {
    requires = { '~/projects/neotest-jest', 'nvim-neotest/neotest-vim-test' },
    config = config 'neotest',
  },
  ['vim-test/vim-test'] = { config = config 'vim-test' },

  ['ziontee113/syntax-tree-surfer'] = {
    config = function()
      require('syntax-tree-surfer').setup {}

      vim.keymap.set('n', 'vU', function()
        vim.opt.opfunc = 'v:lua.STSSwapUpNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })
      vim.keymap.set('n', 'vD', function()
        vim.opt.opfunc = 'v:lua.STSSwapDownNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })

      -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
      vim.keymap.set('n', 'vd', function()
        vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })
      vim.keymap.set('n', 'vu', function()
        vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'
        return 'g@l'
      end, { silent = true, expr = true })

      -- map('n', 'vd', '<cmd>STSSwapCurrentNodeNextNormal<cr>')
      -- map('n', 'vu', '<cmd>STSSwapCurrentNodePrevNormal<cr>')
      -- map('n', 'vD', '<cmd>STSSwapDownNormal<cr>')
      -- map('n', 'vU', '<cmd>STSSwapUpNormal<cr>')
    end,
  },
  ['smjonas/live-command.nvim'] = {
    tag = '1.*',
    config = misc 'live-command',
  },
}

require('core.packer').run(plugins)
