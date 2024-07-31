return {
  {
    'monaqa/dial.nvim',
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
      { "<C-a>", function() return require("dial.map").inc_visual() end, expr = true, desc = "Increment", mode = {'v'} },
      { "<C-x>", function() return require("dial.map").dec_visual() end, expr = true, desc = "Decrement", mode = {'v'} },
      { "g<C-a>", function() return require("dial.map").inc_gvisual() end, expr = true, desc = "Increment", mode = {'v'} },
      { "g<C-x>", function() return require("dial.map").dec_gvisual() end, expr = true, desc = "Decrement", mode = {'v'} },
    },
    config = function()
      local augend = require 'dial.augend'
      require('dial.config').augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      }
    end,
  },
}
