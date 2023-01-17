return {
  'akinsho/bufferline.nvim',
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
}
