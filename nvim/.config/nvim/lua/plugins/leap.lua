return {
  'ggandor/leap.nvim',
  keys = {
    { 's', '<Plug>(leap-forward-to)', desc = 'Leap forward' },
    { 'S', '<Plug>(leap-backward-to)', desc = 'Leap backward' },
    {
      'x',
      '<Plug>(leap-forward-to)',
      desc = 'Leap forward',
      mode = { 'x', 'o' },
    },
    {
      'X',
      '<Plug>(leap-forward-to)',
      desc = 'Leap backward',
      mode = { 'x', 'o' },
    },
    { 'gs', '<Plug>(leap-cross-window)', desc = 'Leap cross window' },
  },
}
