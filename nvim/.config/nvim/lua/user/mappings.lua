local Job = require 'plenary.job'

map('n', 'gx', function()
  local path = vim.fn.expand '<cfile>'
  Job:new({ command = 'open', args = { path } }):start()
end)
