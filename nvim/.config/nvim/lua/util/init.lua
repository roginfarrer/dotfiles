local M = {}

---@param ... any
M.dump = function(...)
  print(vim.inspect(...))
end

M.map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_deep_extend('force', { silent = true, noremap = true }, opts or {}))
end

M.is_apple_silicon = require('jit').arch == 'arm64'

---@param str string
M.termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

---@param event any
---@param opts vim.api.keyset.create_autocmd
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

---@param plugin string
M.has = function(plugin)
  return require('lazy.core.config').spec.plugins[plugin] ~= nil
end

---@param name string
---@param fn fun(name:string)
function M.on_plugin_load(name, fn)
  local Config = require 'lazy.core.config'
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return M
