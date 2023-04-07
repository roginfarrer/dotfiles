local M = {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-telescope/telescope-node-modules.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'tsakirist/telescope-lazy.nvim',
  },
  version = false,
}

function M.opts()
  local action_layout = require 'telescope.actions.layout'

  return {
    defaults = {
      -- vimgrep_arguments = {
      --   'rg',
      --   '--hidden',
      --   '--color=never',
      --   '--no-heading',
      --   '--with-filename',
      --   '--line-number',
      --   '--column',
      --   '--trim',
      --   '--smart-case',
      --   '-g',
      --   '!.git',
      -- },
      layout_config = {
        horizontal = {
          prompt_position = 'top',
        },
      },
      sorting_strategy = 'ascending',
      mappings = {
        i = {
          ['?'] = action_layout.toggle_preview,
        },
      },
      color_devicons = true,
      set_env = { ['COLORTERM'] = 'truecolor' },
    },
    pickers = {
      find_files = {
        find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix', '-H' },
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
end

M.config = function(_, opts)
  require('telescope').setup(opts)
  require('telescope').load_extension 'node_modules'
  require('telescope').load_extension 'fzf'
  if pcall(require, 'yanky') then
    require('telescope').load_extension 'yank_history'
  end
  require('telescope').load_extension 'lazy'
end

local grepDotfiles = function()
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

local function getDirectoryPath()
  if vim.bo.filetype == 'oil' then
    return require('oil').get_current_dir()
  end
  return vim.fn.expand '%:p:h'
end

local grepInCurrentDirectory = function()
  local p = getDirectoryPath()
  require('telescope.builtin').live_grep {
    cwd = p,
    prompt_title = p,
  }
end

local function findCWord()
  require('telescope.builtin').find_files { search_file = vim.fn.expand '<cword>' }
end

local cmd = function(rhs)
  return '<cmd>Telescope ' .. rhs .. '<cr>'
end

M.keys = {
  { '<leader>ft', cmd 'builtin include_extensions=true', desc = 'telescope' },
  {
    '<leader>fp',
    function()
      require('telescope.builtin').git_files()
    end,
    desc = 'git files',
  },
  { '<leader>;', cmd 'buffers', desc = 'buffers' },
  { '<leader>fb', cmd 'buffers', desc = 'buffers' },
  { '<leader>ff', cmd 'find_files', desc = 'all files' },
  { '<leader>fg', cmd 'live_grep', desc = 'live grep' },
  { '<leader>fG', filesContaining, desc = 'live grep (files containing)' },
  { '<leader>fd', findDotfiles, desc = 'find in dotfiles' },
  { '<leader>fD', grepDotfiles, desc = 'grep in dotfiles' },
  { '<leader>fh', cmd 'oldfiles', desc = 'old files' },
  { '<leader>fH', cmd 'help_tags', desc = 'help tags' },
  { '<leader>fl', cmd 'lazy', desc = 'lazy plugins' },
  { '<leader>fc', findCWord, desc = 'Search word under cursor' },
  { '<leader>fC', cmd 'grep_string', desc = 'Grep word under cursor' },
  { '<leader>f.', grepInCurrentDirectory, desc = 'find in current directory' },
  { '<leader>Ht', cmd 'builtin', desc = 'telescope' },
  { '<leader>Hc', cmd 'commands', desc = 'commands' },
  { '<leader>Hh', cmd 'help_tags', desc = 'help pages' },
  { '<leader>Hm', cmd 'man_pages', desc = 'man pages' },
  { '<leader>Hk', cmd 'keymaps', desc = 'key maps' },
  { '<leader>Hs', cmd 'highlights', desc = 'search highlight groups' },
  { '<leader>Hf', cmd 'filetypes', desc = 'file types' },
  { '<leader>Ho', cmd 'vim_options', desc = 'options' },
  { '<leader>Ha', cmd 'autocommands', desc = 'auto commands' },
  { '<leader>gb', cmd 'git_branches', desc = 'checkout branch' },
  { '<leader>gC', cmd 'git_bcommits', desc = 'checkout commit (for current file)' },
}

return M
