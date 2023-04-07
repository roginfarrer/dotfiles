local oil_select = function(direction)
  local oil = require 'oil'
  if direction == 'vertical' then
    oil.select { vertical = true }
  else
    oil.select()
  end
  vim.cmd.wincmd { args = { 'p' } }
  oil.close()
  vim.cmd.wincmd { args = { 'p' } }
end

return {
  -- Better netrw
  {
    'stevearc/oil.nvim',
    opts = {
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['q'] = 'actions.close',
        -- ['<C-v>'] = {
        --   desc = 'open in a vertical split',
        --   callback = function()
        --     oil_select 'vertical'
        --   end,
        -- },
        ['<C-s>'] = {
          desc = 'open in a horizontal split',
          callback = function()
            oil_select 'horizontal'
          end,
        },
        ['<C-l>'] = false,
        ['<C-h>'] = false,
      },
    },
    -- stylua: ignore
    keys = {
      { '-', function() require('oil').open() end, desc = 'Open Oil', },
    },
  },

  -- Center active split
  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    cmd = 'NoNeckPain',
  },

  -- Use same keybindings to move between Vim splits and Kitty panes
  {
    'knubie/vim-kitty-navigator',
    build = 'cp ./*.py ~/.config/kitty/',
    cond = function()
      -- local term = vim.fn.execute('echo $TERM'):gsub('%s+', ''):gsub('\n', '') -- trim spaces and new lines
      -- return term == 'xterm-kitty'
      return false
    end,
  },
  {
    'Lilja/zellij.nvim',
    cond = function()
      return vim.env.ZELLIJ_SESSION_NAME ~= nil
    end,
    opts = { vimTmuxNavigatorKeybinds = true },
  },
  {
    'aserowy/tmux.nvim',
    lazy = false,
    cond = function()
      return vim.env.TERM_PROGRAM == 'tmux'
    end,
    opts = {
      resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = false,
      },
    },
    -- keys = {
    --   { '<C-H>', [[<cmd>lua require("tmux").resize_left()<cr>]], desc = 'resize left' },
    --   { '<C-J>', [[<cmd>lua require("tmux").resize_down()<cr>]], desc = 'resize down' },
    --   { '<C-K>', [[<cmd>lua require("tmux").resize_up()<cr>]], desc = 'resize up' },
    --   { '<C-L>', [[<cmd>lua require("tmux").resize_right()<cr>]], desc = 'resize right' },
    -- },
  },
  -- Easier navigation between splits
  {
    'mrjones2014/smart-splits.nvim',
    cond = function()
      -- tmux.nvim handles most of what this plugin does
      return vim.env.TERM_PROGRAM == 'WezTerm'
    end,
    -- stylua: ignore
  keys = {
    -- { '<leader><leader>h', function() require('smart-splits').swap_buf_left() end, desc = ' swap buf left', mode = { 'n', 't' } },
    -- { '<leader><leader>l', function() require('smart-splits').swap_buf_right() end, desc = ' swap buf right', mode = { 'n', 't' } },
    -- { '<leader><leader>j', function() require('smart-splits').swap_buf_down() end, desc = ' swap buf down', mode = { 'n', 't' } },
    -- { '<leader><leader>k', function() require('smart-splits').swap_buf_up() end, desc = ' swap buf up', mode = { 'n', 't' } },
    { '<C-h>', function() require('smart-splits').move_cursor_left() end, desc = ' window left', mode = { 'n', 't' } },
    { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = ' window right', mode = { 'n', 't' } },
    { '<C-j>', function() require('smart-splits').move_cursor_down() end, desc = ' window down', mode = { 'n', 't' } },
    { '<C-k>', function() require('smart-splits').move_cursor_up() end, desc = ' window up', mode = { 'n', 't' } },
    { '<S-Left>', function() require('smart-splits').resize_left() end, desc = 'resize window left', mode = { 'n', 't' } },
    { '<S-Up>', function() require('smart-splits').resize_up() end, desc = 'resize window up', mode = { 'n', 't' } },
    { '<S-Down>', function() require('smart-splits').resize_down() end, desc = 'resize window down', mode = { 'n', 't' } },
    { '<S-Right>', function() require('smart-splits').resize_right() end, desc = 'resize window right', mode = { 'n', 't' } },
  },
  },

  -- Jump shortcuts to spots in buffer
  {
    'ggandor/leap.nvim',
    dependencies = { { 'ggandor/flit.nvim', opts = { labeled_modes = 'nv' } } },
    -- stylua: ignore
    keys = {
      { 's', '<Plug>(leap-forward-to)', desc = 'Leap forward' },
      { 'S', '<Plug>(leap-backward-to)', desc = 'Leap backward' },
      { 'x', '<Plug>(leap-forward-to)', desc = 'Leap forward', mode = { 'x', 'o' }, },
      { 'X', '<Plug>(leap-forward-to)', desc = 'Leap backward', mode = { 'x', 'o' }, },
      { 'gs', '<Plug>(leap-cross-window)', desc = 'Leap cross window' },
    },
  },

  -- Better session management
  {
    'olimorris/persisted.nvim',
    lazy = false,
    -- event = 'BufReadPre',
    -- cmd = { 'SessionLoad', 'SessionStop', 'SessionLoadLatest' },
    opts = {
      use_git_branch = true,
      should_autosave = function()
        if vim.bo.filetype == 'noice' then
          return false
        end
        return true
      end,
    },
  },

  {
    'windwp/nvim-spectre',
    lazy = true,
    -- stylua: ignore
    keys = {
      { '<leader>fr', function() require('spectre').open() end, desc = 'Replace in files (Spectre)', },
    },
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
}
