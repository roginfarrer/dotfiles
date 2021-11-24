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
    -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    'antoinemadec/FixCursorHold.nvim',
    setup = function()
      vim.g.cursorhold_updatetime = 250
    end,
  },
  'nathom/filetype.nvim', -- faster replacement for filetype.vim (detecting filetypes)

  {
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup()
    end,
  },

  -- -- -- -- -- -- -- -- -- -- -- -- --
  --  Language Server Protocol (LSP)  --
  -- -- -- -- -- -- -- -- -- -- -- -- --

  'nvim-lua/lsp-status.nvim',
  'ray-x/lsp_signature.nvim',
  'weilbith/nvim-code-action-menu',
  'folke/lua-dev.nvim',
  {
    'neovim/nvim-lspconfig',
    config = config 'lsp',
    requires = {
      'williamboman/nvim-lsp-installer',
      'hrsh7th/cmp-nvim-lsp',
    },
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  },
  {
    'onsails/lspkind-nvim',
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('lspkind').init { preset = 'codicons' }
    end,
  },
  {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    cmd = { 'Trouble', 'TroubleToggle' },
    config = function()
      require('trouble').setup {}
    end,
  },
  {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = { 'null-ls.nvim' },
  },
  {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      { 'petertriho/cmp-git', requires = 'nvim-lua/plenary.nvim' },
      { 'David-Kunz/cmp-npm', requires = { 'nvim-lua/plenary.nvim' } },
    },
    config = config 'cmp',
  },
  {
    'windwp/nvim-autopairs',
    config = config 'autopairs',
  },
  {
    'L3MON4D3/LuaSnip',
    config = config 'luasnip',
  },

  -- -- -- -- -- --
  --   Editing   --
  -- -- -- -- -- --

  'editorconfig/editorconfig-vim',
  'duggiefresh/vim-easydir',
  'machakann/vim-sandwich',
  'tpope/vim-eunuch',
  'tpope/vim-repeat',
  'tpope/vim-abolish',
  'Pocco81/TrueZen.nvim',
  'wellle/targets.vim',
  {
    'numToStr/Comment.nvim',
    config = config 'comment',
  },
  {
    'ThePrimeagen/harpoon',
    requires = 'nvim-lua/plenary.nvim',
    config = config 'harpoon',
  },

  -- -- -- -- -- -- -- --
  --   User Interface  --
  -- -- -- -- -- -- -- --

  {
    'nvim-lualine/lualine.nvim',
    after = 'nightfox.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = config 'lualine',
  },
  {
    'goolord/alpha-nvim',
    config = config 'alpha',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config 'treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      {
        'windwp/nvim-ts-autotag',
        config = function()
          require('nvim-ts-autotag').setup()
        end,
      },
    },
  },
  {
    'nvim-treesitter/playground',
    requires = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup {
        override = {
          lir_folder_icon = {
            icon = '',
            color = '#7ebae4',
            name = 'LirFolderNode',
          },
        },
      }
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
    'folke/which-key.nvim',
    config = config 'which-key',
  },
  {
    'simeji/winresizer',
    setup = function()
      vim.g.winresizer_start_key = '<C-w>e'
    end,
  },
  'sindrets/winshift.nvim',
  'kevinhwang91/nvim-bqf',
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup()
    end,
  },

  -- -- -- -- -- -- -- -- -- -- --
  --   Extended Functionality   --
  -- -- -- -- -- -- -- -- -- -- --

  {
    'vim-test/vim-test',
    cmd = { 'TestFile', 'TestSuite', 'TestNearest', 'TestVisit', 'TestLast' },
    setup = config 'vim-test',
  },
  {
    'mfussenegger/nvim-dap',
    run = ':helptags ALL',
    requires = { 'David-Kunz/jester' },
    config = config 'dap',
  },
  {
    'IndianBoy42/hop.nvim',
    requires = { 'nvim-treesitter' },
    config = config 'hop',
  },
  {
    'akinsho/toggleterm.nvim',
    config = config 'toggleterm',
  },

  -- -- -- --
  --  Git  --
  -- -- -- --

  'tpope/vim-fugitive',
  {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = config 'gitlinker',
  },
  { 'whiteinge/diffconflicts', cmd = 'DiffConflicts' },
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
      require('neogit').setup {
        signs = {
          -- { CLOSED, OPENED }
          section = { '', '' },
          item = { '', '' },
          hunk = { '', '' },
        },
        integrations = {
          diffview = true,
        },
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead', 'BufNewFile' },
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = config 'gitsigns',
  },
  'pwntester/octo.nvim',

  -- -- -- -- -- -- -- --
  --   File Browsing   --
  -- -- -- -- -- -- -- --

  {
    'tamago324/lir.nvim',
    -- disable = true,
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'tamago324/lir-git-status.nvim',
    },
    config = config 'lir',
  },
  {
    'kyazdani42/nvim-tree.lua',
    disable = true,
    requires = 'kyazdani42/nvim-web-devicons',
    config = config 'tree',
  },
  {
    'nvim-telescope/telescope.nvim',
    config = config 'telescope',
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

  -- -- -- -- -- -- -- --
  --  Themes & Syntax  --
  -- -- -- -- -- -- -- --

  { 'jxnblk/vim-mdx-js', ft = { 'mdx', 'markdown.mdx' } },
  {
    'tpope/vim-markdown',
    ft = { 'markdown', 'mdx', 'markdown.mdx' },
  },
  {
    'folke/tokyonight.nvim',
    config = function()
      require 'rf.theme'
    end,
  },
  'shaunsingh/nord.nvim',
  { 'siduck76/nvim-base16.lua' },
  {
    'EdenEast/nightfox.nvim',
    config = function()
      require 'rf.theme'
    end,
  },
}
