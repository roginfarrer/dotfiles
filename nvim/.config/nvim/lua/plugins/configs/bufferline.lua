require('bufferline').setup {
  numbers = 'none',
  close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
  right_mouse_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
  left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
}

map('n', '<A-h>', '<cmd>BufferLineCyclePrev<CR>')
map('n', '<A-l>', '<cmd>BufferLineCycleNext<CR>')
