function _G.duplicate_file()
  local filepath = vim.fn.expand '%'
  local name = vim.fn.input('New name: ', filepath, 'file')
  vim.fn.system(string.format('cp %s %s', filepath, name))
  vim.fn.execute(string.format('edit %s', name))
  print('Created and editing ' .. name)
end

vim.cmd [[
  command! Dupe call v:lua.duplicate_file()
]]
