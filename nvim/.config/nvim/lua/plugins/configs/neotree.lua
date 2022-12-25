local tree = require 'neo-tree'

vim.g.neo_tree_remove_legacy_commands = 1

map('n', '-', ':Neotree toggle<CR>')

tree.setup {
  filesystem = {
    follow_current_file = true,
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    window = {
      mappings = {
        ['o'] = 'system_open',
      },
    },
  },
  event_handlers = {
    {
      event = 'file_opened',
      handler = function()
        --auto close
        require('neo-tree').close_all()
      end,
    },
  },
  commands = {
    system_open = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      -- macOs: open file in default application in the background.
      -- Probably you need to adapt the Linux recipe for manage path with spaces. I don't have a mac to try.
      vim.api.nvim_command('silent !open -g ' .. path)
      -- Linux: open file in default application
      vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
    end,
  },
}
