return {
  { 'LazyVim/LazyVim' },
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'MunifTanjim/nui.nvim', lazy = true },
  {
    'brenoprata10/nvim-highlight-colors',
    event = 'VeryLazy',
    opts = { enable_named_colors = false, enable_tailwind = true, render = 'background', virtual_symbol = '•' },
  },
  { 'zeioth/garbage-day.nvim', enabled = false, event = 'VeryLazy', opts = {} },

  {
    'antoinemadec/FixCursorHold.nvim',
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },

  {
    'windwp/nvim-spectre',
    lazy = true,
    cmd = { 'Spectre' },
    -- stylua: ignore
    keys = {
      { '<leader>fr', function() require('spectre').open() end, desc = 'Replace in files (Spectre)', },
    },
  },

  -- Automatically between template literal and strings when needed
  {
    'axelvc/template-string.nvim',
    opts = { remove_template_string = true },
    event = 'InsertEnter',
  },

  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  {
    'echasnovski/mini.bracketed',
    event = 'BufReadPost',
    version = '*',
    opts = {},
    config = function(_, opts)
      local bracketed = require 'mini.bracketed'
      bracketed.setup(opts)
    end,
  },

  {
    'Wansmer/treesj',
    cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
    -- stylua: ignore
    keys = {
      { 'J', function() require('treesj').toggle() end, desc = 'toggle treesj' },
      { '<leader>jm', function() require('treesj').toggle() end, desc = 'toggle treesj' },
      { '<leader>jj', function() require('treesj').join() end, desc = 'join treesj' },
      { '<leader>js', function() require('treesj').split() end, desc = 'split treesj' },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { use_default_keymaps = false },
  },

  {
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    cmd = 'Neogen',
    opts = { snippet_engine = 'luasnip' },
  },

  {
    'chipsenkbeil/distant.nvim',
    lazy = false,
    branch = 'v0.3',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('distant'):setup {
        servers = {
          ['rfarrer.vm.dev.etsycloud.com'] = {
            cwd = 'development/Etsyweb',
          },
        },
      }
      require('telescope').load_extension 'distant'
    end,
  },
}
