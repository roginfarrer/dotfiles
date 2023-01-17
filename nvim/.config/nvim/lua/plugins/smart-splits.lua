return {
  'mrjones2014/smart-splits.nvim',
  keys = {
    {
      '<C-h>',
      function()
        require('smart-splits').move_cursor_left()
      end,
      desc = ' window left',
      mode = { 'n', 't' },
    },
    {
      '<C-l>',
      function()
        require('smart-splits').move_cursor_right()
      end,
      desc = ' window right',
      mode = { 'n', 't' },
    },
    {
      '<C-j>',
      function()
        require('smart-splits').move_cursor_down()
      end,
      desc = ' window down',
      mode = { 'n', 't' },
    },
    {
      '<C-k>',
      function()
        require('smart-splits').move_cursor_up()
      end,
      desc = ' window up',
      mode = { 'n', 't' },
    },
    {
      '<S-Left>',
      function()
        require('smart-splits').resize_left()
      end,
      desc = 'resize window left',
      mode = { 'n', 't' },
    },
    {
      '<S-Up>',
      function()
        require('smart-splits').resize_up()
      end,
      desc = 'resize window up',
      mode = { 'n', 't' },
    },
    {
      '<S-Down>',
      function()
        require('smart-splits').resize_down()
      end,
      desc = 'resize window down',
      mode = { 'n', 't' },
    },
    {
      '<S-Right>',
      function()
        require('smart-splits').resize_right()
      end,
      desc = 'resize window right',
      mode = { 'n', 't' },
    },
  },
}
