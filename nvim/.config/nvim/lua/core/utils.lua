_G.dump = function(...)
  print(vim.inspect(...))
end

_G.map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend('force', { silent = true, noremap = true }, opts or {}))
end

_G.is_m1 = require('jit').arch == 'arm64'

-- The function is called `t` for `termcodes`.
_G.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.autocmd = function(event, opts)
  if opts.group then
    vim.api.nvim_create_autocmd(
      event,
      vim.tbl_extend('force', opts, { group = vim.api.nvim_create_augroup('rogin_' .. opts.group, { clear = true }) })
    )
  else
    vim.api.nvim_create_autocmd(event, opts)
  end
end
