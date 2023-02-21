return {
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
  { 'akinsho/git-conflict.nvim', config = true, event = 'VimEnter' },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    cmd = 'Octo',
    opts = {
      ---@diagnostic disable-next-line: undefined-field
      github_hostname = _G.work_github_url,
    },

    {
      'ruifm/gitlinker.nvim',
      config = function()
        require('gitlinker').setup {
          mappings = nil,
          callbacks = {
            [_G.work_github_url] = require('gitlinker.hosts').get_github_type_url,
          },
        }
      end,
      -- stylua: ignore
      keys = {
        { '<leader>gc', function() require('gitlinker').get_buf_range_url 'n' end, desc = 'Copy github url to clipboard', },
        { '<leader>gc', function() require('gitlinker').get_buf_range_url 'v' end, desc = 'Copy github url to clipboard', mode = { 'v' }, },
        { '<leader>go', function() require('gitlinker').get_buf_range_url( 'n', { action_callback = require('gitlinker.actions').open_in_browser }) end, desc = 'Open file in browser', },
        { '<leader>go', function() require('gitlinker').get_buf_range_url( 'v', { action_callback = require('gitlinker.actions').open_in_browser }) end, desc = 'Open file in browser', mode = { 'v' }, },
      },
    },

    {
      'lewis6991/gitsigns.nvim',
      event = 'BufReadPre',
      opts = {
        signs = {
          add = { hl = 'GitGutterAdd', text = '▋' },
          change = { hl = 'GitGutterChange', text = '▋' },
          delete = { hl = 'GitGutterDelete', text = '▋' },
          topdelete = { hl = 'GitGutterDeleteChange', text = '▔' },
          changedelete = { hl = 'GitGutterChange', text = '▎' },
        },
        keymaps = {},
      },
      keys = {
        { '<leader>gj', "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = 'Next Hunk' },
        { '<leader>gk', "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = 'Prev Hunk' },
        { '<leader>gl', "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = 'Blame' },
        { '<leader>gp', "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = 'Preview Hunk' },
        { '<leader>gr', "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = 'Reset Hunk' },
        { '<leader>gR', "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = 'Reset Buffer' },
        { '<leader>gs', "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = 'Stage Hunk' },
        { '<leader>gu', "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = 'Undo Stage Hunk' },
      },
    },

    {
      'TimUntersberger/neogit',
      cmd = 'Neogit',
      opts = {
        kind = 'split',
        signs = {
          -- { CLOSED, OPENED }
          section = { '', '' },
          item = { '', '' },
          hunk = { '', '' },
        },
        integrations = { diffview = true },
      },
      keys = {
        { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit' },
      },
    },
  },
}
