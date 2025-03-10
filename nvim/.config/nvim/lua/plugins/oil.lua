local oil_select = function(direction)
  local oil = require 'oil'
  if direction == 'vertical' then
    oil.select { vertical = true }
  else
    oil.select()
  end
  vim.cmd.wincmd { args = { 'p' } }
  oil.close()
  vim.cmd.wincmd { args = { 'p' } }
end

return {
  {
    'stevearc/oil.nvim',
    opts = {
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['q'] = 'actions.close',
        ['<C-v>'] = {
          desc = 'open in a vertical split',
          callback = function()
            oil_select 'vertical'
          end,
        },
        ['<C-s>'] = {
          desc = 'open in a vertical split',
          callback = function()
            oil_select 'vertical'
          end,
        },
        ['<C-l>'] = false,
        ['<C-h>'] = false,
      },
      -- EXPERIMENTAL support for performing file operations with git
      git = {
        -- Return true to automatically git add/mv/rm files
        add = function(path)
          return true
        end,
        mv = function(src_path, dest_path)
          return true
        end,
        rm = function(path)
          return true
        end,
      },
    },
    -- stylua: ignore
    keys = {
      { '-', function() require('oil').open() end, desc = 'Open Oil', },
    },
  },
}
