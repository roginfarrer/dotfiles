return {
  'gbprod/yanky.nvim',
  event = 'BufReadPost',
  config = function()
    require('yanky').setup {
      preserve_cursor_position = {
        enabled = true,
      },
    }
  end,
  keys = {
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' } },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' } },
    { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' } },
    { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' } },
    { '<c-n>', '<Plug>(YankyCycleForward)' },
    { '<c-p>', '<Plug>(YankyCycleBackward)' },
  },
}
