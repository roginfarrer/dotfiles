require('incline').setup {
  hide = {
    cursorline = true,
    focused_win = true,
    only_win = true,
  },
  window = {
    width = 'fit',
    placement = { horizontal = 'right', vertical = 'top' },
    margin = {
      horizontal = { left = 0, right = 2 },
      vertical = { bottom = 0, top = 0 },
    },
    padding = { left = 1, right = 1 },
    padding_char = ' ',
    zindex = 10,
  },
}
