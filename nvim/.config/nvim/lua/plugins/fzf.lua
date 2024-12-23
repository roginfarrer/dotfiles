local M = {}

-- Function to capitalize the first letters of words
local function capitalizeWords(str)
  return str:gsub("(%a)([%w_']*)", function(first, rest)
    return first:upper() .. rest:lower()
  end)
end

function M.fzf(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts or {}
    if opts.cwd == 'root_from_file' then
      opts = vim.tbl_deep_extend('force', { cwd = require('lazyvim.util').root() }, opts)
    end
    if builtin == 'files' then
      if vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. '/.git') then
        builtin = 'git_files'
      end
    end
    opts.prompt = '󰍉 '
    local title = string.gsub(builtin, '_', ' ')
    opts.winopts = { title = ' ' .. capitalizeWords(title) .. ' ', title_pos = 'center' }
    require('fzf-lua')[builtin](opts)
  end
end

local function getDirectoryPath()
  if vim.bo.filetype == 'oil' then
    return require('oil').get_current_dir()
  end
  return vim.fn.expand '%:p:h'
end

local grepInCurrentDirectory = function()
  local p = getDirectoryPath()
  return M.fzf('live_grep', {
    cwd = p,
    prompt_title = p,
  })
end

return {
  'ibhagwan/fzf-lua',
  dependencies = {
    { 'roginfarrer/fzf-lua-lazy.nvim', dev = true },
  },
  cmd = 'FzfLua',
  opts = {
    grep = {
      rg_opts = "--hidden --column --line-number --no-heading --trim --color=always --smart-case -g '!{.git,node_modules}/*'",
    },
    git = {
      files = {
        cmd = 'git ls-files --exclude-standard --others --cached',
      },
    },
    files = {
      formatter = 'path.dirname_first',
      fzf_opts = {
        ['--info'] = 'inline-right',
      },
    },
    keymap = {
      builtin = {
        ['?'] = 'toggle-preview',
      },
    },
    fzf_opts = {
      ['--layout'] = 'reverse',
      ['--info'] = 'inline-right',
      -- https://github.com/ibhagwan/fzf-lua/wiki#how-do-i-setup-input-history-keybinds
      -- ['--history'] = vim.fn.stdpath 'data' .. '/fzf-lua-history',
    },
    defaults = { formatter = 'path.filename_first' },
    hls = {
      -- normal = 'TelescopeResultsNormal',
      -- title = 'TelescopePromptTitle',
      -- help_normal = 'TelescopeNormal',
      -- preview_title = 'TelescopePreviewTitle',
      -- -- builtin preview only
      -- cursor = 'Cursor',
      -- cursorline = 'TelescopePreviewLine',
      -- cursorlinenr = 'TelescopePreviewLine',
      -- search = 'IncSearch',
    },
    fzf_colors = {
      -- ['fg'] = { 'fg', 'TelescopeNormal' },
      -- ['bg'] = { 'bg', 'FzfLuaBorder' },
      -- ['hl'] = { 'fg', 'TelescopeMatching' },
      -- ['fg+'] = { 'fg', 'TelescopeSelection' },
      -- ['bg+'] = { 'bg', 'TelescopeSelection' },
      -- ['hl+'] = { 'fg', 'TelescopeMatching' },
      -- ['info'] = { 'fg', 'TelescopeMultiSelection' },
      -- ['border'] = { 'fg', 'TelescopeBorder' },
      -- ['gutter'] = { 'bg', 'TelescopeNormal' },
      -- ['prompt'] = { 'fg', 'TelescopePromptPrefix' },
      -- ['pointer'] = { 'fg', 'TelescopeSelectionCaret' },
      -- ['marker'] = { 'fg', 'TelescopeSelectionCaret' },
      -- ['header'] = { 'fg', 'TelescopeTitle' },
    },
    winopts = {
      border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
      preview = {
        hidden = vim.fn.winwidth(0) < 125 and 'hidden' or 'nohidden',
        vertical = 'up:45%',
        horizontal = 'right:45%',
      },
    },
    lsp = {
      code_actions = {
        previewer = 'codeaction_native',
        preview_pager = 'delta --side-by-side --width=$FZF_PREVIEW_COLUMNS',
      },
    },
    colorschemes = {
      colors = vim.list_extend({
        'rose-pine',
        'tokyonight',
        'nordic',
        'kanagawa',
        'palenightfall',
        'nightfox',
        'onenord',
        'onedarkpro',
        'gruvbox',
      }, vim.fn.getcompletion('', 'color')),
    },
  },
  keys = function()
    local config = require 'fzf-lua.config'
    local actions = require('trouble.sources.fzf').actions
    config.defaults.actions.files['ctrl-t'] = actions.open
    return {
      { '<leader>;', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<CR>', desc = 'Buffers' },
      { '<leader>/', M.fzf 'live_grep', desc = 'live grep' },
      { '<leader>ff', M.fzf 'files', desc = 'Find Files (cwd)' },
      { '<leader>fF', M.fzf('files', { cwd = 'root_from_file' }), desc = 'Find Files (root dir)' },
      { '<leader>fg', M.fzf 'live_grep', desc = 'Grep (cwd)' },
      { '<leader>fG', M.fzf('live_grep', { cwd = 'root_from_file' }), desc = 'Grep (cwd)' },
      { '<leader>fd', M.fzf('files', { cwd = '~/dotfiles' }), desc = 'Dotfiles' },
      { '<leader>fD', M.fzf('live_grep', { cwd = '~/dotfiles' }), desc = 'Grep Dotfiles' },
      { '<leader>fh', M.fzf 'oldfiles', desc = 'old files' },
      {
        '<leader>fl',
        function()
          require('fzf-lua-lazy').search { prompt = '󰍉 ', winopts = { title = ' Lazy ', title_pos = 'center' } }
        end,
        desc = 'lazy plugins',
      },
      { '<leader>fc', M.fzf 'grep_cword', desc = 'Grep word under cursor' },
      { '<leader>fC', M.fzf 'grep_cWORD', desc = 'Grep WORD under cursor' },
      { '<leader>f.', grepInCurrentDirectory, desc = 'find in current directory' },
      { '<leader>st', M.fzf 'builtin', desc = 'fzf builtins' },
      { '<leader>sC', M.fzf 'commands', desc = 'commands' },
      { '<leader>sh', M.fzf 'help_tags', desc = 'help pages' },
      { '<leader>sm', M.fzf 'man_pages', desc = 'man pages' },
      { '<leader>sk', M.fzf 'keymaps', desc = 'key maps' },
      { '<leader>ss', M.fzf 'highlights', desc = 'search highlight groups' },
      { '<leader>sf', M.fzf 'filetypes', desc = 'file types' },
      { '<leader>so', M.fzf 'vim_options', desc = 'options' },
      { '<leader>sa', M.fzf 'autocommands', desc = 'auto commands' },
      { '<leader>sc', M.fzf 'colorschemes', desc = 'colorschemes' },
      { '<leader>gb', M.fzf 'git_branches', desc = 'checkout branch' },
      { '<leader>gC', M.fzf 'git_bcommits', desc = 'checkout commit (for current file)' },
      { '<leader>r', M.fzf 'resume', desc = 'Fzf resume' },
    -- stylua: ignore
    { '<c-x><c-f>', function() require('fzf-lua').complete_file { cmd = 'fd -t file', winopts = { preview = { hidden = 'nohidden' } }, } end, desc = 'Fuzzy complete path', mode = {'i'} },
    }
  end,
  config = function(_, opts)
    require('fzf-lua').setup(opts)
    -- Automatically size window for vim.ui.select
    -- https://github.com/ibhagwan/fzf-lua/wiki#automatic-sizing-of-heightwidth-of-vimuiselect
    require('fzf-lua').register_ui_select(function(_, items)
      local min_h, max_h = 0.15, 0.70
      local h = (#items + 4) / vim.o.lines
      if h < min_h then
        h = min_h
      elseif h > max_h then
        h = max_h
      end
      return { winopts = { height = h, width = 0.60, row = 0.40 } }
    end)
  end,
}
