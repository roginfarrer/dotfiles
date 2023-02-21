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
        ['<C-v>'] = {
          desc = 'open in a vertical split',
          callback = function()
            oil_select 'vertical'
          end,
        },
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

  -- Visualize moving splits
  {
    'sindrets/winshift.nvim',
    config = true,
    keys = {
      { '<C-A-H>', '<cmd>WinShift left<CR>', desc = 'winshift left' },
      { '<C-A-J>', '<cmd>WinShift down<CR>', desc = 'winshift down' },
      { '<C-A-K>', '<cmd>WinShift up<CR>', desc = 'winshift up' },
      { '<C-A-L>', '<cmd>WinShift right<CR>', desc = 'winshift right' },
    },
  },

  -- Easier navigation between splits
  {
    'mrjones2014/smart-splits.nvim',
    -- stylua: ignore
  keys = {
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

  -- Center active split
  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    cmd = 'NoNeckPain',
  },

  -- Use same keybindings to move between Vim splits and Kitty panes
  { 'knubie/vim-kitty-navigator', build = 'cp ./*.py ~/.config/kitty/' },

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
    event = 'BufReadPre',
    cmd = { 'SessionLoad', 'SessionStop', 'SessionLoadLatest' },
    opts = {
      use_git_branch = true,
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
}
