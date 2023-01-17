return {
  'nvim-lua/plenary.nvim',
  'folke/which-key.nvim',
  {
    'kyazdani42/nvim-web-devicons',
    opts = {
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
    enabled = false,
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
  -- { 'wellle/targets.vim', event = 'VeryLazy' },
  {
    'smjonas/inc-rename.nvim',
    lazy = true,
    config = true,
  },

  -- {
  --   'Julian/vim-textobj-variable-segment',
  --   dependencies = 'kana/vim-textobj-user',
  --   event = 'VeryLazy',
  --   branch = 'main',
  -- },
  {
    'axelvc/template-string.nvim',
    opts = { remove_template_string = true },
    event = 'InsertEnter',
  },

  -- -- -- -- -- -- -- --
  --   User Interface  --
  -- -- -- -- -- -- -- --

  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  {
    'sindrets/winshift.nvim',
    config = true,
    keys = {
      { '<C-A-H>', '<cmd>WinShift left<CR>' },
      { '<C-A-J>', '<cmd>WinShift down<CR>' },
      { '<C-A-K>', '<cmd>WinShift up<CR>' },
      { '<C-A-L>', '<cmd>WinShift right<CR>' },
    },
  },
  {
    'stevearc/dressing.nvim',
    lazy = true,
    opts = {
      win_options = { winblend = 0 },
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
    enabled = false,
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
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview' },
    },
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
    opts = {
      ---@diagnostic disable-next-line: undefined-field
      github_hostname = _G.work_github_url,
    },
  },

  { 'jxnblk/vim-mdx-js', ft = 'mdx' },
  { 'fladson/vim-kitty', ft = 'kitty' },
  { 'catppuccin/nvim', name = 'catppuccin', lazy = false, priority = 1000 },
  { 'folke/tokyonight.nvim', branch = 'main', lazy = true, priority = 1000 },
  { 'ellisonleao/glow.nvim', cmd = { 'Glow' } },

  -- -- -- -- -- -- -- --
  --  New For Testing  --
  -- -- -- -- -- -- -- --

  { 'moll/vim-bbye', cmd = 'Bdelete' },
  {
    'anuvyklack/windows.nvim',
    dependencies = {
      'anuvyklack/middleclass',
      -- 'anuvyklack/animation.nvim',
    },
    event = 'BufAdd',
    init = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
    end,
    config = {
      animation = {
        fps = 40,
        duration = 200,
      },
    },
  },
  {
    'smjonas/live-command.nvim',
    version = '1.*',
    event = 'CmdlineEnter',
    opts = {
      commands = {
        Norm = { cmd = 'norm' },
      },
    },
  },

  { 'shortcuts/no-neck-pain.nvim', version = '*', cmd = 'NoNeckPain' },
}
