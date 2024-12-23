return {

  -- Highlight symbols under cursor

  -- Prettier vim.ui
  {
    'stevearc/dressing.nvim',
    lazy = true,
    enabled = false,
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

  -- {
  --   'j-hui/fidget.nvim',
  --   enabled = false,
  --   tag = 'v1.1.0',
  --   event = 'VeryLazy',
  --   opts = { notification = { override_vim_notify = true } },
  -- },

  -- Better `vim.notify()`
  -- {
  --   'rcarriga/nvim-notify',
  --   enabled = false,
  --   opts = {
  --     timeout = 3000,
  --     max_height = function()
  --       return math.floor(vim.o.lines * 0.75)
  --     end,
  --     max_width = function()
  --       return math.floor(vim.o.columns * 0.75)
  --     end,
  --   },
  --   init = function()
  --     -- when noice is not enabled, install notify on VeryLazy
  --     -- local Util = require 'lazyvim.util'
  --     -- if not Util.has 'noice.nvim' then
  --     --   Util.on_very_lazy(function()
  --     --     vim.notify = require 'notify'
  --     --   end)
  --     -- end
  --   end,
  --   keys = {
  --     {
  --       '<leader>un',
  --       function()
  --         require('notify').dismiss { silent = true, pending = true }
  --       end,
  --       desc = 'Dismiss all Notifications',
  --     },
  --   },
  -- },

  -- Noicer UI

  -- Easy set-up of Neovim's new statuscolumn feature
  -- { 'luukvbaal/statuscol.nvim', event = 'BufReadPost', opts = { setopt = true } },
}
