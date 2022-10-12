local surr_utils = require 'nvim-surround.utils'
local ts_utils = require 'nvim-treesitter.ts_utils'
local query = vim.treesitter.query

require('nvim-surround').setup {
  -- keymaps = { -- vim-surround style keymaps
  --   insert = 'sa',
  --   delete = 'sd',
  --   change = 'cr',
  --   insert_line = nil,
  --   visual = 'S',
  -- },
  highlight = {
    duration = 500,
  },
  keymaps = {
    visual = 'gS',
  },
}

require('nvim-surround').buffer_setup {
  surrounds = {
    ['f'] = {
      add = function()
        local cur = ts_utils.get_node_at_cursor(0, true)
        while cur and cur:type() ~= 'fenced_code_block' do
          cur = cur:parent()
        end

        local language = nil
        if cur then
          for child_node in cur:iter_children() do
            if child_node:type() == 'info_string' then
              language = query.get_node_text(child_node:child(0), 0)
            end
          end
        end

        if language == 'javascript' or language == 'typescript' then
          local input = surr_utils.get_input 'Enter a function name: '
          if input then
            return {
              'function ' .. input .. '() {',
              '}',
            }
          end
        elseif language == 'lua' then
          local input = surr_utils.get_input 'Enter a function name: '
          if input then
            return {
              'local ' .. input .. ' = function()',
              {
                'end',
              },
            }
          end
        end
        return { '', '' }
      end,
    },
  },
}
