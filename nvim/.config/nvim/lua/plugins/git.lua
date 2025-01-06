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
    'ruifm/gitlinker.nvim',
    enabled = false,
    config = function()
      require('gitlinker').setup {
        mappings = nil,
        -- callbacks = {
        --   [_G.work_github_url] = require('gitlinker.hosts').get_github_type_url,
        -- },
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
    'folke/snacks.nvim',
    opts = {
      gitbrowse = {
        enabled = true,
        open = function(url)
          -- Use 'local-open' on remote machine to open in local machine's browser
          if vim.fn.executable 'local-open' then
            local ret = vim.fn.jobstart('local-open ' .. url, { detach = true })
            if ret <= 0 then
              local msg = {
                'Failed to open uri',
                ret,
              }
              vim.notify(table.concat(msg, '\n'), vim.log.levels.ERROR)
            end
            return
          end
          require('lazy.util').open(url, { system = true })
        end,
      },
    },
    keys = {
      {
        '<leader>go',
        function()
          Snacks.gitbrowse()
        end,
        mode = { 'n', 'x' },
        desc = 'Open file in Github',
      },
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

  {
    'daliusd/ghlite.nvim',
    opts = {
      keymaps = { -- override default keymaps with the ones you prefer
        diff = {
          open_file = 'gf',
          approve = '<C-A>',
        },
        comment = {
          send_comment = '<C-CR>',
        },
        pr = {
          approve = '<C-A>',
        },
      },
    },
    keys = function()
      local desc = function(str)
        return 'GHLite: ' .. str
      end
      return {
        { '<leader>us', '<cmd>GHLitePRSelect<cr>', silent = true, desc = desc 'Select PR' },
        { '<leader>uo', '<cmd>GHLitePRCheckout<cr>', silent = true, desc = desc 'Checkout PR' },
        { '<leader>uv', '<cmd>GHLitePRView<cr>', silent = true, desc = desc 'View PR' },
        { '<leader>uu', '<cmd>GHLitePRLoadComments<cr>', silent = true, desc = 'Load PR Comments' },
        { '<leader>up', '<cmd>GHLitePRDiff<cr>', silent = true, desc = desc 'PR Diff' },
        { '<leader>ua', '<cmd>GHLitePRAddComment<cr>', silent = true, desc = 'Add Comment' },
        { '<leader>ug', '<cmd>GHLitePROpenComment<cr>', silent = true, desc = desc 'Open Comment' },
      }
    end,
  },
}
