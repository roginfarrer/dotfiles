return {
  'ggandor/leap.nvim',
  event = 'VeryLazy',
  config = function()
    require('leap').set_default_keymaps {}
  end,
}
