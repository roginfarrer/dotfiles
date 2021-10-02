vim.g.tokyonight_italic_functions = true
-- vim.cmd([[colorscheme tokyonight]])

-- local base16 = require('base16')
-- base16(base16.themes('onenord'), true)

vim.g.nord_contrast = true
vim.g.nord_italic = true
-- require('nord').set()

local nightfox = require('nightfox')
-- nightfox.setup({ fox = 'nordfox' })
nightfox.load()
