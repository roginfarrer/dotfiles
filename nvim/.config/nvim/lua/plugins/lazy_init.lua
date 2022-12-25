local function config(name)
  local path = string.format('plugins.configs.%s', name)
  return function()
    require(path)
  end
end

local function misc(name)
  return function()
    require('plugins.configs.misc')[name]()
  end
end

local plugins = {
  ['nvim-lua/plenary.nvim'] = {},

  ['kyazdani42/nvim-web-devicons'] = { config = misc 'devicons' },

  ['ggandor/leap.nvim'] = { config = misc 'leap', event = 'VeryLazy' },

  ['glacambre/firenvim'] = {
    lazy = false,
    build = function()
      vim.fn['firenvim#install'](0)
    end,
  },

  -- -- -- -- -- -- -- -- -- -- -- -- --
  --  Language Server Protocol (LSP)  --
  -- -- -- -- -- -- -- -- -- -- -- -- --

  ['williamboman/mason.nvim'] = {
    config = config 'lsp',
    dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
  },
  ['folke/neodev.nvim'] = {},
  ['jose-elias-alvarez/null-ls.nvim'] = {},
  ['jose-elias-alvarez/typescript.nvim'] = {},
  ['neovim/nvim-lspconfig'] = {},
  ['glepnir/lspsaga.nvim'] = {},
  ['hrsh7th/nvim-cmp'] = {
    config = config 'cmp',
    event = 'InsertEnter',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'petertriho/cmp-git',
      'David-Kunz/cmp-npm',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-cmdline',
      'mtoohey31/cmp-fish',
    },
  },
  ['L3MON4D3/LuaSnip'] = { config = config 'luasnip', event = 'InsertEnter' },
  ['windwp/nvim-autopairs'] = {
    config = config 'autopairs',
    event = 'InsertEnter',
  },
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
  ['kylechui/nvim-surround'] = {
    config = config 'surround',
    event = 'InsertEnter',
  },
  ['tpope/vim-eunuch'] = { event = 'CmdlineEnter' },
  ['tpope/vim-abolish'] = { event = 'CmdlineEnter' },
  ['wellle/targets.vim'] = { event = 'CursorMoved' },
  ['numToStr/Comment.nvim'] = {
    config = config 'comment',
    event = 'VeryLazy',
  },
  ['Julian/vim-textobj-variable-segment'] = {
    dependencies = 'kana/vim-textobj-user',
    event = 'VeryLazy',
    branch = 'main',
  },
  ['axelvc/template-string.nvim'] = {
    config = misc 'template_string',
    event = 'InsertEnter',
  },

  -- -- -- -- -- -- -- --
  --   User Interface  --
  -- -- -- -- -- -- -- --

  ['goolord/alpha-nvim'] = { config = config 'alpha' },
  ['nvim-lualine/lualine.nvim'] = {
    config = config 'lualine',
    event = 'VeryLazy',
  },
  ['nvim-treesitter/nvim-treesitter'] = {
    build = ':TSUpdate',
    config = config 'treesitter',
    event = 'VeryLazy',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      { 'lewis6991/spellsitter.nvim', config = true },
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'p00f/nvim-ts-rainbow',
    },
  },
  -- ['nvim-treesitter/nvim-treesitter-context'] = {},
  -- ['lewis6991/spellsitter.nvim'] = {
  --   config = function()
  --     require('spellsitter').setup()
  --   end,
  -- },
  -- ['nvim-treesitter/nvim-treesitter-textobjects'] = { event = 'BufRead' },
  -- ['JoosepAlviste/nvim-ts-context-commentstring'] = {},
  ['folke/which-key.nvim'] = { config = config 'which-key' },
  ['kevinhwang91/nvim-bqf'] = { ft = 'qf' },
  ['kdheepak/tabline.nvim'] = { config = misc 'tabline', event = 'BufReadPre' },
  ['sindrets/winshift.nvim'] = {
    config = config 'winshift',
    cmd = 'WinShift',
  },
  ['kevinhwang91/nvim-ufo'] = {
    event = 'BufReadPost',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = config 'ufo',
  },

  ['akinsho/toggleterm.nvim'] = {
    version = 'v2.*',
    config = config 'toggleterm',
    event = 'VeryLazy',
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
    dependencies = { 'tpope/vim-rhubarb' },
  },
  ['sindrets/diffview.nvim'] = {
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  },
  ['lewis6991/gitsigns.nvim'] = {
    config = config 'gitsigns',
    event = 'VeryLazy',
  },
  ['akinsho/git-conflict.nvim'] = {
    config = misc 'git-conflict',
    event = 'VeryLazy',
  },
  ['pwntester/octo.nvim'] = {
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    cmd = { 'Octo' },
    config = function()
      require('octo').setup {
        github_hostname = 'github.csnzoo.com',
        -- pull_requests = {
        --   always_select_remote_on_create = true,
        -- },
      }
    end,
  },
  -- ['anuvyklack/hydra.nvim'] = { config = config 'hydra' },
  -- ['ThePrimeagen/git-worktree.nvim'] = {},

  -- -- -- -- -- -- -- --
  --   File Browsing   --
  -- -- -- -- -- -- -- --

  ['tamago324/lir.nvim'] = {
    keys = '-',
    dependencies = {
      'tamago324/lir-git-status.nvim',
    },
    config = config 'lir',
  },
  -- ['nvim-neo-tree/neo-tree.nvim'] = {
  --   branch = 'v2.x',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
  --     'MunifTanjim/nui.nvim',
  --   },
  --   config = config 'neotree',
  -- },
  -- ['prichrd/netrw.nvim'] = { config = config 'netrw' },
  -- ['tpope/vim-vinegar'] = {},
  ['nvim-telescope/telescope.nvim'] = {
    config = config 'telescope',
    cmd = 'Telescope',
    dependencies = {
      'nvim-telescope/telescope-node-modules.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
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
  ['catppuccin/nvim'] = { name = 'catppuccin' },
  -- ['p00f/nvim-ts-rainbow'] = {},
  ['ellisonleao/glow.nvim'] = {
    cmd = { 'Glow' },
  },

  -- -- -- -- -- -- -- --
  --  New For Testing  --
  -- -- -- -- -- -- -- --

  ['moll/vim-bbye'] = { cmd = 'Bdelete' },
  ['mrjones2014/smart-splits.nvim'] = { event = 'BufReadPost' },
  ['anuvyklack/windows.nvim'] = {
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    event = 'BufReadPost',
  },
  ['Shatur/neovim-session-manager'] = {
    config = config 'sessions',
    event = 'VeryLazy',
  },
  ['nvim-neotest/neotest'] = {
    dependencies = { 'haydenmeade/neotest-jest', dev = true },
    config = config 'neotest',
    lazy = true,
  },

  -- ['ziontee113/syntax-tree-surfer'] = {
  --   config = function()
  --     require('syntax-tree-surfer').setup {}

  --     vim.keymap.set('n', 'vU', function()
  --       vim.opt.opfunc = 'v:lua.STSSwapUpNormal_Dot'
  --       return 'g@l'
  --     end, { silent = true, expr = true })
  --     vim.keymap.set('n', 'vD', function()
  --       vim.opt.opfunc = 'v:lua.STSSwapDownNormal_Dot'
  --       return 'g@l'
  --     end, { silent = true, expr = true })

  --     -- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
  --     vim.keymap.set('n', 'vd', function()
  --       vim.opt.opfunc = 'v:lua.STSSwapCurrentNodeNextNormal_Dot'
  --       return 'g@l'
  --     end, { silent = true, expr = true })
  --     vim.keymap.set('n', 'vu', function()
  --       vim.opt.opfunc = 'v:lua.STSSwapCurrentNodePrevNormal_Dot'
  --       return 'g@l'
  --     end, { silent = true, expr = true })

  --     -- map('n', 'vd', '<cmd>STSSwapCurrentNodeNextNormal<cr>')
  --     -- map('n', 'vu', '<cmd>STSSwapCurrentNodePrevNormal<cr>')
  --     -- map('n', 'vD', '<cmd>STSSwapDownNormal<cr>')
  --     -- map('n', 'vU', '<cmd>STSSwapUpNormal<cr>')
  --   end,
  -- },
  ['smjonas/live-command.nvim'] = {
    version = '1.*',
    config = misc 'live-command',
    event = 'CmdlineEnter',
  },
  ['folke/noice.nvim'] = {
    event = 'VeryLazy',
    config = config 'noice',
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- 'rcarriga/nvim-notify',
    },
  },
  ['gbprod/yanky.nvim'] = { config = misc 'yanky', event = 'VeryLazy' },
}

require('core.lazy').run(plugins)
