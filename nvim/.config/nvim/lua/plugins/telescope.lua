local builtin = require 'telescope.builtin'
-- Function to capitalize the first letters of words
-- local function capitalizeWords(str)
--   return str:gsub("(%a)([%w_']*)", function(first, rest)
--     return first:upper() .. rest:lower()
--   end)
-- end

-- local telescope = function(builtin, opts)
--   local params = { builtin = builtin, opts = opts }
--   return function()
--     builtin = params.builtin
--     opts = params.opts or {}
--     if opts.cwd == 'root_from_file' then
--       opts = vim.tbl_deep_extend('force', { cwd = require('lazyvim.util').root() }, opts)
--     end
--     if builtin == 'files' then
--       if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. '/.git') then
--         builtin = 'git_files'
--       end
--     end
--     opts.prompt = '󰍉 '
--     local title = string.gsub(builtin, '_', ' ')
--     opts.winopts = { title = ' ' .. capitalizeWords(title) .. ' ', title_pos = 'center' }
--     require('telescope')[builtin](opts)
--   end
-- end

local M = {
  'nvim-telescope/telescope.nvim',
  -- enabled = false,
  cmd = 'Telescope',
  dependencies = {
    { 'LazyVim/LazyVim' },
    'nvim-telescope/telescope-node-modules.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'tsakirist/telescope-lazy.nvim',
    {
      'danielfalk/smart-open.nvim',
      branch = '0.2.x',
      config = function() end,
      dependencies = {
        'kkharji/sqlite.lua',
      },
    },
  },
  version = false,
}

function M.opts()
  local action_layout = require 'telescope.actions.layout'

  return {
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--trim',
        '--smart-case',
        '--hidden',
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
    extensions = {
      file_browser = {
        initial_mode = 'normal',
      },
    },
  }
end

M.config = function(_, opts)
  require('telescope').setup(opts)
  require('telescope').load_extension 'node_modules'
  require('telescope').load_extension 'fzf'
  require('telescope').load_extension 'lazy'
  require('telescope').load_extension 'smart_open'
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
  { '<leader>;', cmd 'smart_open', desc = 'Smart Open' },
  -- { '<leader>;', cmd 'buffers show_all_buffers=true', desc = 'Buffers' },
  { '<leader>/', cmd 'live_grep', desc = 'Grep (root dir)' },
  { '<leader>fp', cmd 'find_files', desc = 'Find Files (root dir)' },
  -- find
  { '<leader>fb', cmd 'buffers', desc = 'Buffers' },
  {
    '<leader>fB',
    function()
      vim.cmd [[Telescope file_browser path=%:p:h select_buffer=true]]
    end,
    desc = 'Buffers',
  },
  -- { '<leader>fF', telescope 'files', desc = 'Find Files (root dir)' },
  { '<leader>ff', cmd 'find_files', desc = 'Find Files (cwd)' },
  { '<leader>fr', cmd 'oldfiles', desc = 'Recent' },
  -- { '<leader>fR', telescope('oldfiles', { cwd = vim.loop.cwd() }), desc = 'Recent (cwd)' },
  { '<leader>fg', cmd 'live_grep', desc = 'live grep' },
  { '<leader>fG', filesContaining, desc = 'live grep (files containing)' },
  -- stylua: ignore
  { '<leader>fd', function() builtin.git_files({ cwd = '~/dotfiles', prompt_title = '~ Dotfiles ~' }) end, desc = 'Dotfiles', },
  -- stylua: ignore
  { '<leader>fD', function() builtin.live_grep({ cwd = '~/dotfiles', prompt_title = '~ Dotfiles ~' }) end, desc = 'Grep (dotfiles)' },
  { '<leader>fh', cmd 'oldfiles', desc = 'old files' },
  { '<leader>fH', cmd 'help_tags', desc = 'help tags' },
  { '<leader>fl', cmd 'lazy', desc = 'lazy plugins' },
  { '<leader>fc', findCWord, desc = 'Search word under cursor' },
  { '<leader>fC', cmd 'grep_string', desc = 'Grep word under cursor' },
  { '<leader>f.', grepInCurrentDirectory, desc = 'find in current directory' },
  -- Search
  { '<leader>st', cmd 'builtin', desc = 'telescope' },
  { '<leader>sc', cmd 'commands', desc = 'commands' },
  { '<leader>sh', cmd 'help_tags', desc = 'help pages' },
  { '<leader>sm', cmd 'man_pages', desc = 'man pages' },
  { '<leader>sk', cmd 'keymaps', desc = 'key maps' },
  { '<leader>ss', cmd 'highlights', desc = 'search highlight groups' },
  { '<leader>sf', cmd 'filetypes', desc = 'file types' },
  { '<leader>so', cmd 'vim_options', desc = 'options' },
  { '<leader>sa', cmd 'autocommands', desc = 'auto commands' },
  -- Git
  { '<leader>gb', cmd 'git_branches', desc = 'checkout branch' },
  { '<leader>gC', cmd 'git_bcommits', desc = 'checkout commit (for current file)' },
  { '<leader>r', cmd 'resume', desc = 'Telescope resume' },
}

return M
