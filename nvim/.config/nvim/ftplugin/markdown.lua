local function markdown_link()
  local line = vim.api.nvim_get_current_line()
  vim.cmd [[echo 'hello']]
  -- local params = vim.lsp.util.make_given_range_params()
  local begin = vim.api.nvim_buf_get_mark(0, '<')[1]
  local last = vim.api.nvim_buf_get_mark(0, '>')[1]
  -- print(line:sub(0, begin))
  -- print(line:sub(begin, last))
  -- print(line:sub(last, begin))
  local new_line = line:sub(0, begin)
    .. '['
    .. line:sub(begin, last)
    .. ']'
    .. line:sub(last, -1)
  vim.api.nvim_set_current_line(new_line)
end

-- map('v', '<leader>[[', maRkdown_link)
