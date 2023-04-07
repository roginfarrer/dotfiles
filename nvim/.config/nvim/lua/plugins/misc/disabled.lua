return {
  -- Visualize moving splits
  {
    'sindrets/winshift.nvim',
    enabled = false,
    config = true,
    keys = {
      { '<C-A-H>', '<cmd>WinShift left<CR>', desc = 'winshift left' },
      { '<C-A-J>', '<cmd>WinShift down<CR>', desc = 'winshift down' },
      { '<C-A-K>', '<cmd>WinShift up<CR>', desc = 'winshift up' },
      { '<C-A-L>', '<cmd>WinShift right<CR>', desc = 'winshift right' },
    },
  },

  { 'akinsho/git-conflict.nvim', enabled = false, opts = {}, event = 'VimEnter' },

  {
    'ruifm/gitlinker.nvim',
    enabled = false,
    config = function()
      require('gitlinker').setup {
        mappings = nil,
        callbacks = {
          [_G.work_github_url] = require('gitlinker.hosts').get_github_type_url,
        },
      }
    end,
    -- stylua: ignore
    -- keys = {
    --   { '<leader>gc', function() require('gitlinker').get_buf_range_url 'n' end, desc = 'Copy github url to clipboard', },
    --   { '<leader>gc', function() require('gitlinker').get_buf_range_url 'v' end, desc = 'Copy github url to clipboard', mode = { 'v' }, },
    --   { '<leader>go', function() require('gitlinker').get_buf_range_url( 'n', { action_callback = require('gitlinker.actions').open_in_browser }) end, desc = 'Open file in browser', },
    --   { '<leader>go', function() require('gitlinker').get_buf_range_url( 'v', { action_callback = require('gitlinker.actions').open_in_browser }) end, desc = 'Open file in browser', mode = { 'v' }, },
    -- },
  },

  -- Better `vim.notify()`
  {
    'rcarriga/nvim-notify',
    enabled = false,
    keys = {
      {
        '<leader>nd',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Delete all Notifications',
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      top_down = false,
    },
  },

  -- Show buffers as tabs
  {
    'akinsho/bufferline.nvim',
    enabled = false,
    event = 'BufAdd',
    opts = {
      options = {
        numbers = 'none',
        close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
        right_mouse_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
        left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
      },
    },
    keys = {
      { '<A-h>', '<cmd>BufferLineCyclePrev<CR>' },
      { '<A-l>', '<cmd>BufferLineCycleNext<CR>' },
    },
  },

  {
    'utilyre/barbecue.nvim',
    enabled = false,
    event = 'BufReadPost',
    name = 'barbecue',
    version = '*',
    dependencies = { 'SmiteshP/nvim-navic' },
    opts = {
      show_dirname = false,
      kinds = require('ui.icons').lspkind,
      -- configurations go here
    },
  },

  -- Make the background transparent
  {
    'xiyaowong/nvim-transparent',
    enabled = false,
    event = 'VeryLazy',
    opts = {
      enable = true,
      extra_groups = {
        'NormalFloat',
        'NoiceMini',
        'MasonNormal',
        'toggleterm',
        'BufferLineTabClose',
        'BufferlineBufferSelected',
        'BufferLineFill',
        'BufferLineBackground',
        'BufferLineSeparator',
        'BufferLineIndicatorSelected',
        'FidgetTask',
        'FidgetTitle',
      },
    },
  },
}
