local fontsize = 16

local function adjustFontSize(amount)
  fontsize = fontsize + amount
  local newValue = 'Zed Mono:h' .. fontsize

  if vim.fn.exists ':Guifont' > 0 then
    vim.fn.execute('Guifont! ' .. newValue)
  else
    vim.o.guifont = newValue
  end
end

adjustFontSize(0)

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
