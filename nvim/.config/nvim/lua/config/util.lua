local M = {}

M.dump = function(...)
  print(vim.inspect(...))
end

M.map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend('force', { silent = true, noremap = true }, opts or {}))
end

M.is_apple_silicon = require('jit').arch == 'arm64'

-- The function is called `t` for `termcodes`.
M.termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.autocmd = function(event, opts)
  if opts.group then
    vim.api.nvim_create_autocmd(
      event,
      vim.tbl_extend('force', opts, { group = vim.api.nvim_create_augroup('rogin_' .. opts.group, { clear = true }) })
    )
  else
    vim.api.nvim_create_autocmd(event, opts)
  end
end

M.has = require('lazyvim.util').has

return M
