function _G.duplicate_file()
  local filepath = vim.fn.expand '%'
  local buffer_content = vim.api.nvim_buf_get_lines(
    vim.api.nvim_get_current_buf(),
    0,
    -1,
    false
  )
  local name = vim.fn.input('New name: ', filepath, 'file')
  vim.fn.execute(string.format('edit %s', name))

  local newBufNum = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(newBufNum, 0, -1, false, buffer_content)
  vim.fn.execute 'write'

  vim.fn.execute(string.format('echomsg "Created and editing %s"', name))
end

vim.cmd [[
  command! Dupe call v:lua.duplicate_file()
]]
