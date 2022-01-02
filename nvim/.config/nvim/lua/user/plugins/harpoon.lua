local ui = require 'harpoon.ui'
local mark = require 'harpoon.mark'
local wk = require 'which-key'

wk.register({
  h = {
    a = { mark.add_file, 'Harpoon Add File' },
    h = { ui.toggle_quick_menu, 'Harpoon Open Menu' },
    u = {
      function()
        ui.nav_file(1)
      end,
      'Harpoon 1',
    },
    i = {
      function()
        ui.nav_file(2)
      end,
      'Harpoon 2',
    },
    o = {
      function()
        ui.nav_file(3)
      end,
      'Harpoon 3',
    },
    p = {
      function()
        ui.nav_file(4)
      end,
      'Harpoon 4',
    },
  },
}, {
  prefix = '<leader>',
})
