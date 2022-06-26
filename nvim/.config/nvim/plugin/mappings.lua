local Job = require 'plenary.job'

map('n', 'gx', function()
  local path = vim.fn.expand '<cfile>'
  Job:new({ command = 'open', args = { path } }):start()
end)

map('n', '<C-h>', ':SmartCursorMoveLeft<CR>')
map('n', '<C-j>', ':SmartCursorMoveDown<CR>')
map('n', '<C-k>', ':SmartCursorMoveUp<CR>')
map('n', '<C-l>', ':SmartCursorMoveRight<CR>')
