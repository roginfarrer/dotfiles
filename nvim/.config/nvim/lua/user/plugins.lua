local function config(name)
  return string.format("require('user.plugins.%s')", name)
end

return {
  'wbthomason/packer.nvim',
  'nvim-lua/plenary.nvim',
  { 'lewis6991/impatient.nvim', rocks = 'mpack' },
  {
    -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
    'antoinemadec/FixCursorHold.nvim',
    setup = function()
      vim.g.cursorhold_updatetime = 250
    end,
  },
  'nathom/filetype.nvim', -- faster replacement for filetype.vim (detecting filetypes)
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  -- {
  --   'luukvbaal/stabilize.nvim',
  --   config = function()
  --     require('stabilize').setup()
  --   end,
  -- },
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
    config = config 'lsp',
  },
  'folke/lua-dev.nvim',
  -- 'ray-x/lsp_signature.nvim',
  'jose-elias-alvarez/null-ls.nvim',
  'jose-elias-alvarez/nvim-lsp-ts-utils',
  'neovim/nvim-lspconfig',
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    config = function()
      require('trouble').setup {}
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    config = config 'cmp',
  },
  {
    'L3MON4D3/LuaSnip',
    config = config 'luasnip',
  },
  {
    'onsails/lspkind-nvim',
    config = function()
      require('lspkind').init { preset = 'codicons' }
    end,
  },
  {
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'petertriho/cmp-git',
    'David-Kunz/cmp-npm',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lua',
  },
  { 'windwp/nvim-autopairs', config = config 'autopairs' },

  -- -- -- -- -- --
  --   Editing   --
  -- -- -- -- -- --

  { 'duggiefresh/vim-easydir', event = 'CmdLineEnter' },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.surround').setup {}
    end,
  },
  { 'tpope/vim-eunuch', event = 'CmdLineEnter' },
  { 'tpope/vim-abolish', event = 'CmdlineEnter' },
  { 'wellle/targets.vim', event = 'CursorMoved' },
  { 'numToStr/Comment.nvim', config = config 'comment' },
  { 'ThePrimeagen/harpoon', config = config 'harpoon' },

  -- -- -- -- -- -- -- --
  --   User Interface  --
  -- -- -- -- -- -- -- --

  { 'nvim-lualine/lualine.nvim', config = config 'lualine' },
  { 'goolord/alpha-nvim', config = config 'alpha' },
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config 'treesitter',
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'BufRead' },
  'JoosepAlviste/nvim-ts-context-commentstring',
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      vim.o.termguicolors = true
      require('colorizer').setup({}, {
        css = true,
        css_fn = true,
      })
    end,
  },
  { 'folke/which-key.nvim', config = config 'which-key' },
  {
    'b0o/mapx.nvim',
    config = config 'mapx',
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
  { 'IndianBoy42/hop.nvim', config = config 'hop' },
  {
    'akinsho/toggleterm.nvim',
    config = config 'toggleterm',
  },

  -- -- -- --
  --  Git  --
  -- -- -- --

  {
    'tpope/vim-fugitive',
    cmd = {
      'G',
      'Git',
      'Grep',
      'Gsplit',
      'Gedit',
      'Gvsplit',
      'Gread',
      'Gwrite',
      'Gdiffsplit',
      'Gvdiffsplit',
      'GMove',
      'GRename',
      'GDelete',
      'GRemove',
      'GBrowse',
    },
  },
  {
    'ruifm/gitlinker.nvim',
    cmd = { 'GitCopyToClipboard', 'GitOpenInBrowser' },
    module_patterns = 'gitlinker*',
    config = config 'gitlinker',
  },
  { 'whiteinge/diffconflicts', cmd = 'DiffConflicts' },
  {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    requires = {
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
    config = config 'gitsigns',
  },
  -- 'pwntester/octo.nvim',

  -- -- -- -- -- -- -- --
  --   File Browsing   --
  -- -- -- -- -- -- -- --

  {
    'tamago324/lir.nvim',
    keys = '-',
    requires = {
      'tamago324/lir-git-status.nvim',
    },
    config = config 'lir',
  },
  -- {
  --   'kyazdani42/nvim-tree.lua',
  --   disable = true,
  --   requires = 'kyazdani42/nvim-web-devicons',
  --   config = config 'tree',
  -- },
  {
    'nvim-telescope/telescope.nvim',
    config = config 'telescope',
    -- cmd = { 'Telescope', 'Telekasten' },
    -- module_patterns = 'telescope',
    requires = {
      'nvim-telescope/telescope-fzf-writer.nvim',
      'ahmedkhalf/project.nvim',
      'nvim-telescope/telescope-node-modules.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
      },
    },
  },
  -- { 'stevearc/gkeep.nvim', run = ':UpdateRemotePlugins' },
  {
    'renerocksai/telekasten.nvim',
    config = config 'telekasten',
    requires = {
      { 'renerocksai/calendar-vim', after = 'telekasten.nvim' },
    },
  },

  -- -- -- -- -- -- -- --
  --  Themes & Syntax  --
  -- -- -- -- -- -- -- --

  { 'jxnblk/vim-mdx-js', ft = { 'mdx', 'markdown.mdx' } },
  {
    'folke/tokyonight.nvim',
    config = function()
      require 'user.theme'
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    config = function()
      require 'user.theme'
    end,
  },
  'rebelot/kanagawa.nvim',
  -- {
  --   'mickael-menu/zk-nvim',
  --   config = function()
  --     require('zk').setup {
  --       -- create user commands such as :ZkNew
  --       create_user_commands = true,
  --
  --       lsp = {
  --         -- `config` is passed to `vim.lsp.start_client(config)`
  --         config = {
  --           cmd = { 'zk', 'lsp' },
  --           name = 'zk',
  --           -- init_options = ...
  --           -- on_attach = ...
  --           -- etc, see `:h vim.lsp.start_client()`
  --         },
  --
  --         -- automatically attach buffers in a zk notebook that match the given filetypes
  --         auto_attach = {
  --           enabled = true,
  --           filetypes = { 'markdown', 'telekasten' },
  --         },
  --       },
  --     }
  --     require('telescope').load_extension 'zk'
  --   end,
  -- },
  {
    'nvim-neorg/neorg',
    after = 'nvim-treesitter',
    config = function()
      require('neorg').setup {
        -- Tell Neorg what modules to load
        load = {
          ['core.defaults'] = {}, -- Load all the default modules
          ['core.norg.concealer'] = {}, -- Allows for use of icons
          ['core.norg.dirman'] = { -- Manage your directories with Neorg
            config = {
              workspaces = {
                my_workspace = '~/neorg',
              },
            },
          },
          ['core.norg.completion'] = {
            config = {
              engine = 'nvim-cmp',
            },
          },
        },
      }
    end,
    requires = 'nvim-lua/plenary.nvim',
  },
}