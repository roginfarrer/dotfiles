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
  -- 'nathom/filetype.nvim', -- faster replacement for filetype.vim (detecting filetypes)
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  {
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup()
    end,
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

  -- -- -- -- -- -- -- -- -- -- -- -- --
  --  Language Server Protocol (LSP)  --
  -- -- -- -- -- -- -- -- -- -- -- -- --

  { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' },
  {
    'williamboman/nvim-lsp-installer',
    event = 'BufRead',
    config = config 'lsp',
    requires = {
      'neovim/nvim-lspconfig',
      { 'hrsh7th/cmp-nvim-lsp' },
      'folke/lua-dev.nvim',
      'ray-x/lsp_signature.nvim',
      {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
      },
      {
        'jose-elias-alvarez/nvim-lsp-ts-utils',
        requires = { 'null-ls.nvim' },
      },
    },
  },
  'neovim/nvim-lspconfig',
  {
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    cmd = { 'Trouble', 'TroubleToggle' },
    config = function()
      require('trouble').setup {}
    end,
  },
  {
    {
      'hrsh7th/nvim-cmp',
      after = 'nvim-lspconfig',
      requires = {
        {
          'L3MON4D3/LuaSnip',
          -- after = 'nvim-lspconfig',
          config = config 'luasnip',
        },
        {
          'onsails/lspkind-nvim',
          after = 'nvim-lspconfig',
          config = function()
            require('lspkind').init { preset = 'codicons' }
          end,
        },
      },
      config = config 'cmp',
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    {
      'petertriho/cmp-git',
      after = 'nvim-cmp',
      requires = 'nvim-lua/plenary.nvim',
    },
    {
      'David-Kunz/cmp-npm',
      after = 'nvim-cmp',
      requires = { 'nvim-lua/plenary.nvim' },
    },
  },
  {
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = config 'autopairs',
  },

  -- -- -- -- -- --
  --   Editing   --
  -- -- -- -- -- --

  { 'editorconfig/editorconfig-vim', event = 'BufRead' },
  { 'duggiefresh/vim-easydir', event = 'BufRead' },
  { 'machakann/vim-sandwich', event = 'BufRead' },
  { 'tpope/vim-eunuch', event = 'BufRead' },
  { 'tpope/vim-repeat', event = 'BufRead' },
  { 'tpope/vim-abolish', event = 'BufRead' },
  { 'wellle/targets.vim', event = 'BufRead' },
  {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    config = config 'comment',
  },
  {
    'ThePrimeagen/harpoon',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufRead',
    config = config 'harpoon',
  },

  -- -- -- -- -- -- -- --
  --   User Interface  --
  -- -- -- -- -- -- -- --

  {
    'nvim-lualine/lualine.nvim',
    after = 'nightfox.nvim',
    event = 'BufEnter',
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
    -- event = 'CursorHold',
    run = ':TSUpdate',
    config = config 'treesitter',
    requires = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
      },
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        after = 'nvim-treesitter',
      },
      {
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter',
        config = function()
          require('nvim-ts-autotag').setup()
        end,
      },
    },
  },
  {
    'nvim-treesitter/playground',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    after = 'nvim-treesitter',
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = 'CursorHold',
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
    cmd = {
      'WinResizerStartResize',
      'WinResizerStartMove',
      'WinResizerStartFocus',
    },
    setup = function()
      vim.g.winresizer_start_key = '<C-w>e'
    end,
  },
  { 'sindrets/winshift.nvim', cmd = 'WinShift' },
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  {
    'karb94/neoscroll.nvim',
    event = 'WinScrolled',
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
  -- {
  --   'mfussenegger/nvim-dap',
  --   run = ':helptags ALL',
  --   requires = { 'David-Kunz/jester' },
  --   config = config 'dap',
  -- },
  {
    'IndianBoy42/hop.nvim',
    after = 'nvim-treesitter',
    event = 'BufRead',
    requires = { 'nvim-treesitter' },
    config = config 'hop',
  },
  {
    'akinsho/toggleterm.nvim',
    -- cmd = { 'ToggleTerm', 'ToggleTermAll', 'TermExec' },
    config = config 'toggleterm',
  },

  -- -- -- --
  --  Git  --
  -- -- -- --

  { 'tpope/vim-fugitive', event = 'BufRead' },
  {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
    event = 'BufRead',
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
    event = 'BufRead',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = config 'gitsigns',
  },
  -- 'pwntester/octo.nvim',

  -- -- -- -- -- -- -- --
  --   File Browsing   --
  -- -- -- -- -- -- -- --

  {
    'tamago324/lir.nvim',
    -- event = 'BufRead',
    -- disable = true,
    keys = '-',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'tamago324/lir-git-status.nvim',
    },
    config = config 'lir',
  },
  {
    'kyazdani42/nvim-tree.lua',
    event = 'CursorHold',
    disable = true,
    requires = 'kyazdani42/nvim-web-devicons',
    config = config 'tree',
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'CursorHold',
    config = config 'telescope',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-writer.nvim',
      'ahmedkhalf/project.nvim',
      'nvim-telescope/telescope-node-modules.nvim',
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
  -- {
  --   'tpope/vim-markdown',
  --   ft = { 'markdown', 'mdx', 'markdown.mdx' },
  -- },
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
