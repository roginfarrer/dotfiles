local ui = require 'harpoon.ui'
local mark = require 'harpoon.mark'
local wk = require 'which-key'

wk.register {
  ['<leader>a'] = { mark.add_file, 'Harpoon Add File' },
  ['<leader>h'] = { ui.toggle_quick_menu, 'Harpoon Open Menu' },
  ['<leader>u'] = {
    function()
      ui.nav_file(1)
    end,
    'Harpoon 1',
  },
  ['<leader>i'] = {
    function()
      ui.nav_file(2)
    end,
    'Harpoon 2',
  },
  ['<leader>o'] = {
    function()
      ui.nav_file(3)
    end,
    'Harpoon 3',
  },
  ['<leader>p'] = {
    function()
      ui.nav_file(4)
    end,
    'Harpoon 4',
  },
}
