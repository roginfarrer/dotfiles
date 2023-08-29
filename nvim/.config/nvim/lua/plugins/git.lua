return {
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
    -- keys = {
    --   { '<leader>gc', ':GBrowse!<CR>', desc = 'Copy github url to clipboard' },
    --   { '<leader>gc', ":'<,'>GBrowse!<CR>", desc = 'Copy github url to clipboard', mode = { 'v' } },
    --   { '<leader>go', ':GBrowse<CR><CR>', desc = 'Open file in browser' },
    --   { '<leader>go', ":'<,'>GBrowse<CR><CR>", desc = 'Open file in browser', mode = { 'v' } },
    -- },
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview' },
    },
  },
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

  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map('n', "<leader>gk",  gs.next_hunk, "Next Hunk")
        map("n", "<leader>gj", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
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
}
