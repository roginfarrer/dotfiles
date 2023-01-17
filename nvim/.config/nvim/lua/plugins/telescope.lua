local M = {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-telescope/telescope-node-modules.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    'nvim-telescope/telescope-file-browser.nvim',
  },
}

function M.config()
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
      builtin = {
        include_extensions = true,
      },
    },
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  }

  -- require('project_nvim').setup()
  -- require('telescope').load_extension 'projects'

  -- https://github.com/nvim-telescope/telescope-node-modules.nvim
  require('telescope').load_extension 'node_modules'
  -- https://github.com/nvim-telescope/telescope-packer.nvim
  -- require('telescope').load_extension 'packer'
  -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
  require('telescope').load_extension 'fzf'
  require('telescope').load_extension 'file_browser'
  -- require('telescope').load_extension 'git_worktree'
  require('telescope').load_extension 'yank_history'
end

local searchDotfiles = function()
  require('telescope.builtin').live_grep {
    cwd = '~/dotfiles',
    prompt_title = '~ Dotfiles ~',
  }
end
local findDotfiles = function()
  require('telescope.builtin').git_files {
    cwd = '~/dotfiles',
    prompt_title = '~ Dotfiles ~',
  }
end
local project_files = function()
  local opts = {}
  if vim.loop.fs_stat '.git' then
    opts.show_untracked = true
    require('telescope.builtin').git_files(opts)
  else
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require('telescope.builtin').find_files(opts)
  end
end
local filesContaining = function()
  require('telescope.builtin').live_grep {
    prompt_title = 'Find Files Containing',
    additional_args = { '--files-with-matches' },
  }
end

local cmd = function(rhs)
  return '<cmd>' .. rhs .. '<cr>'
end

M.keys = {
  { '<leader>ft', cmd 'Telescope builtin include_extensions=true<CR>', desc = 'Telescope' },
  { '<leader>fp', project_files, desc = 'Git files' },
  { '<leader>;', cmd 'Telescope buffers', desc = 'Buffers' },
  { '<leader>fb', cmd 'Telescope buffers', desc = 'Buffers' },
  { '<leader>ff', cmd 'Telescope find_files', desc = 'All files' },
  { '<leader>fg', cmd 'Telesope live_grep', desc = 'Live grep' },
  { '<leader>fG', filesContaining, desc = 'Live grep (files containing)' },
  { '<leader>fd', findDotfiles, desc = 'Find in dotfiles' },
  { '<leader>fD', searchDotfiles, desc = 'Grep in dotfiles' },
  { '<leader>fh', cmd 'Telescope oldfiles', desc = 'Old files' },
  { '<leader>fH', cmd 'Telescope help_tags', desc = 'Help tags' },
  {
    '<leader>f.',
    function()
      require('telescope.builtin').find_files {
        cwd = vim.fn.expand '%:p:h',
        prompt_title = vim.fn.expand '%:~:.:p:h',
      }
    end,
    desc = 'Find in current directory',
  },
  { '<leader>Ht', cmd 'Telescope builtin', desc = 'Telescope' },
  { '<leader>Hc', cmd 'Telescope commands', desc = 'Commands' },
  { '<leader>Hh', cmd 'Telescope help_tags', desc = 'Help Pages' },
  { '<leader>Hm', cmd 'Telescope man_pages', desc = 'Man Pages' },
  { '<leader>Hk', cmd 'Telescope keymaps', desc = 'Key Maps' },
  { '<leader>Hs', cmd 'Telescope highlights', desc = 'Search Highlight Groups' },
  { '<leader>Hf', cmd 'Telescope filetypes', desc = 'File Types' },
  { '<leader>Ho', cmd 'Telescope vim_options', desc = 'Options' },
  { '<leader>Ha', cmd 'Telescope autocommands', desc = 'Auto Commands' },
  { '<leader>gb', cmd 'Telescope git_branches', desc = 'Checkout branch' },
  { '<leader>gC', cmd 'Telescope git_bcommits', desc = 'Checkout commit (for current file)' },
}

return M
