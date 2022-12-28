return {
  'nvim-lua/plenary.nvim',
  'folke/which-key.nvim',
  {
    'kyazdani42/nvim-web-devicons',
    config = {
      override = {
        lir_folder_icon = {
          icon = '',
          color = '#7ebae4',
          name = 'LirFolderNode',
        },
      },
    },
  },
  {
    'glacambre/firenvim',
    lazy = false,
    build = function()
      vim.fn['firenvim#install'](0)
    end,
  },

  -- -- -- -- -- --
  --   Editing   --
  -- -- -- -- -- --

  { 'jghauser/mkdir.nvim', event = 'CmdlineEnter' },
  { 'tpope/vim-eunuch', event = 'CmdlineEnter' },
  { 'tpope/vim-abolish', event = 'CmdlineEnter' },
  { 'wellle/targets.vim', event = 'VeryLazy' },
  {
    'smjonas/inc-rename.nvim',
    lazy = true,
    config = true,
  },

  {
    'Julian/vim-textobj-variable-segment',
    dependencies = 'kana/vim-textobj-user',
    event = 'VeryLazy',
    branch = 'main',
  },
  {
    'axelvc/template-string.nvim',
    config = { remove_template_string = true },
    event = 'InsertEnter',
  },

  -- -- -- -- -- -- -- --
  --   User Interface  --
  -- -- -- -- -- -- -- --

  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  {
    'kdheepak/tabline.nvim',
    config = {
      enable = false,
      options = { show_filename_only = true },
    },
    event = 'BufReadPre',
  },
  { 'sindrets/winshift.nvim', config = true, cmd = 'WinShift' },
  {
    'stevearc/dressing.nvim',
    config = {
      win_options = { winblend = 0 },
      -- input = {
      --   override = function(conf)
      --     conf.col = -1
      --     conf.row = 0
      --     return conf
      --   end,
      -- },
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.input(...)
      end
    end,
  },

  -- -- -- --
  --  Git  --
  -- -- -- --

  {
    'tpope/vim-fugitive',
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
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  },
  { 'akinsho/git-conflict.nvim', config = true, event = 'VeryLazy' },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    cmd = { 'Octo' },
    config = {
      github_hostname = 'github.csnzoo.com',
    },
  },

  { 'jxnblk/vim-mdx-js', ft = 'mdx' },
  { 'fladson/vim-kitty', ft = 'kitty' },
  { 'catppuccin/nvim', name = 'catppuccin', lazy = true, priority = 1000 },
  { 'folke/tokyonight.nvim', branch = 'main', lazy = true, priority = 1000 },
  { 'ellisonleao/glow.nvim', cmd = { 'Glow' } },

  -- -- -- -- -- -- -- --
  --  New For Testing  --
  -- -- -- -- -- -- -- --

  { 'moll/vim-bbye', cmd = 'Bdelete' },
  { 'mrjones2014/smart-splits.nvim', event = 'BufReadPost' },
  {
    'anuvyklack/windows.nvim',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    event = 'BufReadPost',
  },

  {
    'smjonas/live-command.nvim',
    version = '1.*',
    event = 'CmdlineEnter',
    config = {
      commands = {
        Norm = { cmd = 'norm' },
      },
    },
  },
}
