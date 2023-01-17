return {
  'stevearc/oil.nvim',
  opts = {
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['q'] = 'actions.close',
      ['<C-v>'] = 'actions.select_vsplit',
      ['<C-s>'] = 'actions.select_split',
      ['<C-l>'] = false,
      ['<C-h>'] = false,
    },
  },
  keys = {
    {
      '-',
      function()
        require('oil').open()
      end,
      desc = { 'Open Oil' },
    },
  },
}
