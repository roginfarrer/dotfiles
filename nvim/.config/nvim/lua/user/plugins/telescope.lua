local actions = require 'telescope.actions'
local action_layout = require 'telescope.actions.layout'

require('telescope').setup {
  defaults = {
    -- file_sorter = require('telescope.sorters').get_fzy_sorter,
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    layout_config = {
      horizontal = {
        prompt_position = 'top',
      },
    },
    sorting_strategy = 'ascending',
    mappings = {
      -- insert mode
      i = {
        ['<esc>'] = actions.close,
        ['?'] = action_layout.toggle_preview,
      },
      -- normal mode
      n = {
        ['<esc>'] = actions.close,
      },
    },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
    },
  },
}

require('project_nvim').setup {}
require('telescope').load_extension 'projects'
-- https://github.com/nvim-telescope/telescope-node-modules.nvim
require('telescope').load_extension 'node_modules'
