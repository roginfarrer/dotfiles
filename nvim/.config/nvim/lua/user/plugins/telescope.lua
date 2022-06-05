local actions = require 'telescope.actions'
local action_layout = require 'telescope.actions.layout'

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--trim',
      '--smart-case',
      '-g',
      '!.git',
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
        -- ['<esc>'] = actions.close,
        ['?'] = action_layout.toggle_preview,
      },
      -- normal mode
      -- n = {
      --   ['<esc>'] = actions.close,
      -- },
    },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
  },
  pickers = {
    find_files = {
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
    },
    buffers = {
      ignore_current_buffer = true,
      sort_mru = true,
    },
  },
}

-- https://github.com/nvim-telescope/telescope-node-modules.nvim
require('telescope').load_extension 'node_modules'
-- https://github.com/nvim-telescope/telescope-packer.nvim
require('telescope').load_extension 'packer'
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension 'fzf'
-- https://github.com/AckslD/nvim-neoclip.lua
require('neoclip').setup()
require('telescope').load_extension 'neoclip'
require('telescope').load_extension 'file_browser'
require('telescope').load_extension 'git_worktree'
