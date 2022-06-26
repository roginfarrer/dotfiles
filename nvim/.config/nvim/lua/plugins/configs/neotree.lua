local tree = require 'neo-tree'

vim.g.neo_tree_remove_legacy_commands = 1

tree.setup {
  filesystem = {
    window = {
      mappings = {
        ['o'] = 'system_open',
      },
    },
    -- hijack_netrw_behavior = 'open_current',
  },
  commands = {
    system_open = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      -- macOs specific -- open file in default application in the background
      vim.api.nvim_command('silent !open -g ' .. path)
    end,
  },
  event_handlers = {
    {
      event = 'file_opened',
      handler = function()
        -- auto close
        tree.close_all()
      end,
    },
  },
}
