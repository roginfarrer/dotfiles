return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      triggers = 'auto',
      plugins = { spelling = true },
      key_labels = { ['<leader>'] = 'SPC', ['<tab>'] = 'TAB' },
      defaults = {
        mode = { 'n', 'v' },
        ['<leader><tab>'] = { name = '+tabs' },
        ['<leader>f'] = { name = '+find' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>gh'] = { name = '+hunk' },
        ['<leader>x'] = { name = '+trouble' },
        ['<leader>s'] = { name = '+search' },
        ['<leader>j'] = { name = '+join/split' },
        ['<leader>d'] = { name = '+debug' },
        ['<leader>t'] = { name = '+test' },
        ['<leader>u'] = { name = '+ui' },
      },
    },
    config = function(_, opts)
      local wk = require 'which-key'
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
