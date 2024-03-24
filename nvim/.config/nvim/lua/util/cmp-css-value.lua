local utils = require 'util.cmp-css-utils'
local source = {}

function source.new()
  local self = setmetatable({}, { __index = source })
  self.cache = {}
  return self
end

function source.is_available()
  return vim.bo.filetype == 'scss' or vim.bo.filetype == 'sass' or vim.bo.filetype == 'css'
end

-- function source.get_keyword_pattern()
--   return [[\%(\$_\w*\|\%(\w\|\.\)*\)]]
-- end

function source.get_debug_name()
  return 'css-variables'
end

function source.get_trigger_characters()
  return { 'var(' }
end

local function find_files(path)
  -- local handle = vim.loop.fs_scandir(path)
  -- while handle do
  --   local name, type = vim.loop.fs_scandir_next(handle)
  --   if not name then
  --     break
  --   end
  --  if type == 'file' then
  --     if name == 'variables.css' then

  --   end
  --   end
  -- end
  local Job = require 'plenary.job'
  local result
  local j = Job:new({
    command = 'find',
    args = { 'find', '.', '-type', 'd', '-name', 'node_modules', '-prune', '-o', '-name', path, '-print' },

    on_exit = function(self)
      local r = self:result()
      vim.print(r)
      result = r
    end,
  }):sync()
  vim.print(result)
  return result
end

function source.complete(self, _, callback)
  local bufnr = vim.api.nvim_get_current_buf()
  local global_items = {}
  local items = {}
  local file_path = vim.fn.expand '%:p'

  if not self.cache[bufnr] then
    if vim.g.css_variables_file then
      local variables_files = find_files(vim.g.css_variables_file)
      if variables_files then
        for _, file in ipairs(variables_files) do
          global_items = utils.get_css_variables(file)
        end
      end
    end

    items = utils.get_css_variables(file_path)

    -- if there are global variables add them to the other items
    for _, v in ipairs(global_items) do
      table.insert(items, v)
    end

    if type(items) ~= 'table' then
      return callback()
    end
    self.cache[bufnr] = items
  else
    items = self.cache[bufnr]
  end

  callback { items = items or {}, isIncomplete = false }
end

function source.resolve(_, completion_item, callback)
  callback(completion_item)
end

function source.execute(_, completion_item, callback)
  callback(completion_item)
end

return source
