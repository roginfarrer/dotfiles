---@type 'neovide' | 'nvim-qt' | false
vim.g.gui_program = vim.g.neovide and 'neovide' or vim.fn.exists ':Guifont' > 0 and 'nvim-qt' or false

if not vim.g.gui_program then
  return
end

local M = {}

local map = require('util').map

---@type number
M.default_font_size = 16
---@type number
M.font_size = M.default_font_size
---@type string
M.font_family = 'Zed Mono'

local function setGuiFont(typeface, size)
  vim.opt.guifont = string.format('%s:h%s', typeface, size)
end

setGuiFont(M.font_family, M.font_size)

---@param delta number
local function adjustFontSize(delta)
  M.font_size = M.font_size + delta
  setGuiFont(M.font_family, M.font_size)

  if vim.g.gui_program == 'nvim-qt' then
    vim.fn.execute('Guifont! ' .. vim.opt.guifont)
  end
end

map('n', '<C-=>', function()
  adjustFontSize(1)
end, { desc = 'Increase font size' })
map('n', '<C-->', function()
  adjustFontSize(-1)
end, { desc = 'Decrease font size' })
map('n', '<D-=>', function()
  adjustFontSize(1)
end, { desc = 'Increase font size' })
map('n', '<D-->', function()
  adjustFontSize(-1)
end, { desc = 'Decrease font size' })

if vim.fn.exists ':GuiRenderLigatures' > 0 then
  vim.cmd [[GuiRenderLigatures 1]]
end

-- Mask cmd-v/cmd-c work how it should
map('n', '<D-V>', '"+p')
map('i', '<D-v>', '<C-o>"+p')
map({ 'n', 'x' }, '<D-c>', '"+y')
