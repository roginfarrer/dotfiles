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
  border = {},
  borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
}

require('project_nvim').setup()
require('telescope').load_extension 'projects'

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

local M = {}

M.searchDotfiles = function()
  require('telescope.builtin').live_grep {
    cwd = '~/dotfiles',
    prompt_title = '~ Dotfiles ~',
  }
end
M.findDotfiles = function()
  require('telescope.builtin').git_files {
    cwd = '~/dotfiles',
    prompt_title = '~ Dotfiles ~',
  }
end
M.project_files = function()
  local result = require('telescope.utils').get_os_command_output {
    'git',
    'rev-parse',
    '--is-inside-work-tree',
  }
  if result[1] == 'false' then
    require('telescope.builtin').find_files()
  else
    require('telescope.builtin').git_files()
  end
end

return M
