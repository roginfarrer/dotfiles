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

local function getDirectoryPath()
  if vim.bo.filetype == 'oil' then
    return require('oil').get_current_dir()
  end
  return vim.fn.expand '%:p:h'
end

_G.SnackPick = function(builtin, args)
  return function()
    if Snacks == nil then
      vim.notify('Snacks not defined or installed?', vim.log.levels.ERROR)
      return
    end
    args = args or {}
    if args.cwd == 'root_from_file' then
      args.cwd = getDirectoryPath()
    end
    Snacks.picker[builtin](args)
  end
end

M.makeRelativePath = function(targetPath, basePath)
  -- Normalize the paths by removing trailing slashes
  targetPath = targetPath:gsub('[/\\]+$', '')
  basePath = basePath:gsub('[/\\]+$', '')

  -- Split the paths into components
  local targetComponents = {}
  for component in targetPath:gmatch '[^/\\]+' do
    table.insert(targetComponents, component)
  end

  local baseComponents = {}
  for component in basePath:gmatch '[^/\\]+' do
    table.insert(baseComponents, component)
  end

  -- Remove common components
  local i = 1
  while i <= #targetComponents and i <= #baseComponents and targetComponents[i] == baseComponents[i] do
    i = i + 1
  end

  -- Calculate the number of upward directories needed
  local upwardDirs = #baseComponents - i + 1
  local relativePath = {}

  for j = 1, upwardDirs do
    table.insert(relativePath, '..')
  end

  -- Add the remaining target components
  for j = i, #targetComponents do
    table.insert(relativePath, targetComponents[j])
  end

  return table.concat(relativePath, '/')
end

return M
