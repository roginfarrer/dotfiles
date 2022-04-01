local function config(name)
  return string.format("require('user.plugins.%s')", name)
end

local function misc(name)
  return require('user.plugins.misc')[name]
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
  -- 'nathom/filetype.nvim', -- faster replacement for filetype.vim (detecting filetypes)
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  -- { 'luukvbaal/stabilize.nvim', config = misc 'stabilize' },
  { 'kyazdani42/nvim-web-devicons', config = misc 'devicons' },
  { 'ggandor/lightspeed.nvim', setup = config 'lightspeed' },

  -- -- -- -- -- -- -- -- -- -- -- -- --
  --  Language Server Protocol (LSP)  --
  -- -- -- -- -- -- -- -- -- -- -- -- --

  { 'williamboman/nvim-lsp-installer', config = config 'lsp' },
  'folke/lua-dev.nvim',
  'jose-elias-alvarez/null-ls.nvim',
  'jose-elias-alvarez/nvim-lsp-ts-utils',
  'neovim/nvim-lspconfig',
  { 'j-hui/fidget.nvim', config = misc 'fidget' },
  {
    'hrsh7th/nvim-cmp',
    config = config 'cmp',
    requires = {
      'saadparwaiz1/cmp_luasnip',
      'petertriho/cmp-git',
      'David-Kunz/cmp-npm',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
    },
  },
  { 'L3MON4D3/LuaSnip', config = config 'luasnip' },
  'rafamadriz/friendly-snippets',
  { 'onsails/lspkind-nvim', config = misc 'lspkind' },
  { 'windwp/nvim-autopairs', config = config 'autopairs' },

  -- -- -- -- -- --
  --   Editing   --
  -- -- -- -- -- --

  { 'duggiefresh/vim-easydir', event = 'CmdlineEnter' },
  { 'echasnovski/mini.nvim', config = misc 'mini' },
  { 'tpope/vim-eunuch', event = 'CmdlineEnter' },
  { 'tpope/vim-abolish', event = 'CmdlineEnter' },
  { 'wellle/targets.vim', event = 'CursorMoved' },
  { 'numToStr/Comment.nvim', config = config 'comment' },
  {
    'ThePrimeagen/harpoon',
    module_pattern = 'harpoon*',
  },
  'AckslD/nvim-neoclip.lua',
  -- {
  --   'Julian/vim-textobj-variable-segment',
  --   requires = 'kana/vim-textobj-user',
  --   event = 'CursorMoved',
  -- },

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
  'windwp/nvim-ts-autotag',
  { 'norcalli/nvim-colorizer.lua', config = misc 'colorizer' },
  { 'folke/which-key.nvim', config = config 'which-key' },
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  {
    'karb94/neoscroll.nvim',
    event = 'WinScrolled',
    config = misc 'neoscroll',
  },
  { 'folke/zen-mode.nvim', config = config 'zen', cmd = 'ZenMode' },
  -- { 'akinsho/bufferline.nvim', config = config 'bufferline' },
  { 'sindrets/winshift.nvim', config = config 'winshift', cmd = 'WinShift' },

  -- -- -- -- -- -- -- -- -- -- --
  --   Extended Functionality   --
  -- -- -- -- -- -- -- -- -- -- --

  {
    'vim-test/vim-test',
    cmd = { 'TestFile', 'TestSuite', 'TestNearest', 'TestVisit', 'TestLast' },
    ft = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' },
    setup = config 'vim-test',
  },
  -- {
  --   'mfussenegger/nvim-dap',
  --   run = ':helptags ALL',
  --   requires = {
  --     'David-Kunz/jester',
  --     'theHamsta/nvim-dap-virtual-text',
  --     'rcarriga/nvim-dap-ui',
  --   },
  --   config = config 'dap',
  -- },
  {
    'akinsho/toggleterm.nvim',
    config = config 'toggleterm',
  },

  -- -- -- --
  --  Git  --
  -- -- -- --

  -- {
  --   'tpope/vim-fugitive',
  --   cmd = {
  --     'G',
  --     'Git',
  --     'Grep',
  --     'Gsplit',
  --     'Gedit',
  --     'Gvsplit',
  --     'Gread',
  --     'Gwrite',
  --     'Gdiffsplit',
  --     'Gvdiffsplit',
  --     'GMove',
  --     'GRename',
  --     'GDelete',
  --     'GRemove',
  --     'GBrowse',
  --   },
  -- },
  {
    'ruifm/gitlinker.nvim',
    cmd = { 'GitCopyToClipboard', 'GitOpenInBrowser' },
    module_pattern = 'gitlinker*',
    config = config 'gitlinker',
  },
  {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    requires = {
      {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
      },
    },
    config = config 'neogit',
  },
  {
    'lewis6991/gitsigns.nvim',
    config = config 'gitsigns',
  },
  { 'whiteinge/diffconflicts', cmd = 'DiffConflicts' },

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
  {
    'kyazdani42/nvim-tree.lua',
    config = config 'tree',
    cmd = 'NvimTreeToggle',
  },
  {
    'nvim-telescope/telescope.nvim',
    config = config 'telescope',
    requires = {
      -- 'ahmedkhalf/project.nvim',
      'nvim-telescope/telescope-node-modules.nvim',
      { 'roginfarrer/telescope-packer.nvim', branch = 'patch-1' },
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
  { 'fladson/vim-kitty', ft = 'kitty' },
  { 'catppuccin/nvim', as = 'catppuccin' },
  'p00f/nvim-ts-rainbow',

  -- -- -- -- -- -- --
  --  Zettelkasten  --
  -- -- -- -- -- -- --

  {
    'mickael-menu/zk-nvim',
    config = config 'zk',
  },
  {
    'nvim-neorg/neorg',
    after = 'nvim-treesitter',
    config = config 'neorg',
  },
  -- {
  --   'renerocksai/telekasten.nvim',
  --   config = config 'telekasten',
  --   requires = {
  --     { 'renerocksai/calendar-vim', after = 'telekasten.nvim' },
  --   },
  -- },

  -- -- -- -- -- -- -- --
  --  New For Testing  --
  -- -- -- -- -- -- -- --
  {
    'rcarriga/vim-ultest',
    requires = { 'vim-test/vim-test' },
    run = ':UpdateRemotePlugins',
    config = config 'ultest',
    cmd = {
      'Ultest',
      'UltestNearest',
      'UltestLast',
      'UltestDebug',
      'UltestDebugNearest',
      'UltestOutput',
      'UltestAttach',
      'UltestStop',
      'UltestStopNearest',
      'UltestSummary',
    },
  },
  -- 'Matt-A-Bennett/vim-surround-funk',
  -- { 'elihunter173/dirbuf.nvim', config = misc 'dirbuf' },
  { 'stevearc/dressing.nvim', event = 'WinEnter' },
  { 'moll/vim-bbye', cmd = 'Bdelete' },
  { 'SidOfc/mkdx', ft = 'markdown' },
}
