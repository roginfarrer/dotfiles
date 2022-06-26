local Job = require 'plenary.job'
local cmp = require 'cmp'

local function split(inputstr, sep)
  if sep == nil then
    sep = '%s'
  end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end
  return t
end

local source = {}

---Return this source is available in current context or not. (Optional)
---@return boolean
function source:is_available()
  return vim.bo.filetype == 'markdown.zk'
end

function source:get_trigger_characters()
  return { '[' }
end

---Invoke completion. (Required)
---@param params cmp.SourceCompletionApiParams
---@param callback fun(response: lsp.CompletionResponse|nil)
function source:complete(_, callback)
  Job
    :new({
      command = 'fd',
      args = {
        '--glob',
        '*.md',
        vim.fn.expand '~/Dropbox (Maestral)/Obsidian',
      },
      on_exit = function(job)
        local result = job:result()
        local items = {}
        for _, i in ipairs(result) do
          local labelTable = split(i, '/')
          local filename = labelTable[#labelTable]
          filename = string.match(filename, '(.*)%.')
          table.insert(items, {
            label = filename,
            word = filename,
            kind = cmp.lsp.CompletionItemKind.File,
            documentation = {
              kind = 'markdown',
              value = i,
            },
            -- insertText = '[' .. filename .. ']]',
          })
        end
        callback { items = items, isIncomplete = false }
      end,
    })
    :start()
end

require('cmp').register_source('zk', source)
