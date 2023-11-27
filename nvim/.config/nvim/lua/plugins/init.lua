return {
  -- { 'roginfarrer/LazyVim', dev = true, opts = { colorscheme = 'catppuccin' } },
  {
    'LazyVim/LazyVim',
    lazy = true,
    -- opts = { colorscheme = 'catppuccin', defaults = { keymaps = false } },
    -- config = function(_, opts)
    --   require('lazyvim').setup(opts)
    --   require('lazyvim.config').init()
    -- end,
  },
  { 'nvim-lua/plenary.nvim', lazy = true },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      triggers = 'auto',
      plugins = { spelling = true },
      -- key_labels = { ['<leader>'] = 'SPC', ['<tab>'] = 'TAB' },
      defaults = {
        mode = { 'n', 'v' },
        ['<leader><tab>'] = { name = '+tabs' },
        ['<leader>f'] = { name = '+find' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>gh'] = { name = '+hunk' },
        ['<leader>x'] = { name = '+trouble' },
        ['<leader>s'] = { name = '+search' },
        ['<leader>j'] = { name = '+join/split' },
        ['<leader>d'] = { name = '+debug' },
        ['<leader>t'] = { name = '+test' },
        ['<leader>u'] = { name = '+ui' },
      },
    },
    config = function(_, opts)
      local wk = require 'which-key'
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  {
    'antoinemadec/FixCursorHold.nvim',
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },

  {
    'zeioth/garbage-day.nvim',
    enabled = false,
    event = 'BufEnter',
    opts = {},
  },
}
