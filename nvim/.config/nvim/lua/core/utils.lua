_G.dump = function(...)
  print(vim.inspect(...))
end

-- Given a plugin name, returns a boolean if plugin is loaded
_G.isPackageLoaded = function(package)
  return packer_plugins[package] and packer_plugins[package].loaded
end

_G.reloadConfig = function(args)
  -- https://neovim.discourse.group/t/reload-init-lua-and-all-require-d-scripts/971/11

  if args then
    package.loaded[args] = nil
    require(args)
    return
  end

  for name, _ in pairs(package.loaded) do
    if name:match '^rf' then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
end

_G.map = function(mode, lhs, rhs, opts)
  vim.keymap.set(
    mode,
    lhs,
    rhs,
    vim.tbl_deep_extend('force', { silent = true, noremap = true }, opts or {})
  )
end

_G.is_m1 = require('jit').arch == 'arm64'

_G.augroup = vim.api.nvim_create_augroup
_G.autocmd = function(event, opts)
  if opts.group then
    vim.api.nvim_create_augroup(opts.group, { clear = true })
  end
  vim.api.nvim_create_autocmd(
    event,
    vim.tbl_extend('keep', opts, { group = opts.group })
  )
end

local M = {}

return M