local function toBlockComment()
  local _row = vim.api.nvim_win_get_cursor(0)[1]
  local row = _row - 1

  local lineContent = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
  dump(lineContent)
  local newContent = string.gsub(lineContent, '//', '*')

  vim.api.nvim_buf_set_lines(0, row, row + 1, true, {
    '/**',
    newContent,
    '*/',
  })
end

_G.toBlockComment = toBlockComment

vim.cmd [[command! ToBlockComment lua _G.toBlockComment()]]
