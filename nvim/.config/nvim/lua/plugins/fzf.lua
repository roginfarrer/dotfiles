local function cmd(args)
  return ':FzfLua ' .. args .. '<CR>'
end

local function basename(path)
  return vim.fn.fnamemodify(path, ':t')
end

local function node_modules()
  local scan = require 'plenary.scandir'
  local util = require 'lspconfig.util'
  local currentBufPath = vim.fn.expand '%'
  local gitAncestor = util.find_git_ancestor(currentBufPath)
  if not gitAncestor then
    vim.notify('no ancestor found', 1, {})
  end
  local list = {}
  local mods = {}

  -- print('gitAncestor ' .. gitAncestor)
  -- print('node_modules_ancestor ' .. util.find_node_modules_ancestor(currentBufPath))

  local function collect(start)
    local node_modules_ancestor = util.find_node_modules_ancestor(start)
    local dirs = scan.scan_dir(util.path.join(node_modules_ancestor, 'node_modules'), { depth = 1, only_dirs = true })
    for _, dir in ipairs(dirs) do
      local base = basename(dir)
      if string.find(base, '^@') then
        local namespacedDirs = scan.scan_dir(dir, { depth = 1, only_dirs = true })
        for _, nestedDir in ipairs(namespacedDirs) do
          local name = base .. '/' .. basename(nestedDir)
          table.insert(list, name)
          table.insert(mods, { path = nestedDir, name = name })
        end
      else
        local name = basename(dir)
        table.insert(mods, { path = dir, name = name })
        table.insert(list, name)
      end
    end
    -- dump { gitAncestor, node_modules_ancestor }
    if gitAncestor ~= node_modules_ancestor then
      collect(util.find_node_modules_ancestor(util.path.dirname(node_modules_ancestor)))
    end
  end

  collect(currentBufPath)

  table.sort(list, function(a, b)
    return a:lower() < b:lower()
  end)

  local opts = {}
  local previewer = require 'fzf-lua.previewer.builtin'
  local path = require 'fzf-lua.path'

  local MyPreviewer = previewer.buffer_or_file:extend()
  function MyPreviewer:new(o, op, fzf_win)
    MyPreviewer.super.new(self, o, op, fzf_win)
    setmetatable(self, MyPreviewer)
    return self
  end
  function MyPreviewer:parse_entry(entry_str)
    local readme
    for _, plugin in ipairs(mods) do
      if entry_str == plugin.name then
        readme = require('plugins.misc.fzf-lua.lazy-plugins').find_readme(plugin.path)
        local entry = path.entry_to_file(readme, self.opts)
        return entry
      end
    end
  end

  opts.prompt = 'node_modules> '
  -- opts.actions = {
  --   ['default'] = function(selected)
  --     local readme
  --     for _, plugin in ipairs(mods) do
  --       if plugin.name == selected[1] then
  --         readme = plugin.readme
  --       end
  --     end
  --     local command = string.format('edit %s', readme)
  --     vim.cmd(command)
  --   end,
  --   ['ctrl-o'] = function(selected)
  --     local url
  --     for _, plugin in ipairs(plugins) do
  --       if plugin.name == selected[1] then
  --         url = plugin.url
  --       end
  --     end
  --     local command = string.format('!open %s', url)
  --     vim.cmd(command)
  --   end,
  -- }
  opts.previewer = MyPreviewer

  require('fzf-lua').fzf_exec(list, opts)
end

-- _G.node_modules = node_modules

local function lazy(opts)
  opts = {}
  local exec = require('fzf-lua').fzf_exec
  local previewer = require 'fzf-lua.previewer.builtin'
  local plugins = require('plugins.misc.fzf-lua.lazy-plugins').plugins()
  local path = require 'fzf-lua.path'

  local list = {}
  for _, plugin in ipairs(plugins) do
    table.insert(list, plugin.name)
  end

  local MyPreviewer = previewer.buffer_or_file:extend()
  function MyPreviewer:new(o, op, fzf_win)
    MyPreviewer.super.new(self, o, op, fzf_win)
    setmetatable(self, MyPreviewer)
    return self
  end
  function MyPreviewer:parse_entry(entry_str)
    local readme
    for _, plugin in ipairs(plugins) do
      if entry_str == plugin.name then
        readme = plugin.readme
        local entry = path.entry_to_file(readme, self.opts)
        return entry
      end
    end
  end

  opts.prompt = 'Lazy> '
  opts.actions = {
    ['default'] = function(selected)
      local readme
      for _, plugin in ipairs(plugins) do
        if plugin.name == selected[1] then
          readme = plugin.readme
        end
      end
      local command = string.format('edit %s', readme)
      vim.cmd(command)
    end,
    ['ctrl-o'] = function(selected)
      local url
      for _, plugin in ipairs(plugins) do
        if plugin.name == selected[1] then
          url = plugin.url
        end
      end
      local command = string.format('!open %s', url)
      vim.cmd(command)
    end,
  }
  opts.previewer = MyPreviewer

  return exec(list, opts)
end

_G.lazy_search = lazy

local project_files = function()
  local opts = {}
  if vim.loop.fs_stat '.git' then
    require('fzf-lua').git_files(opts)
  else
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require('fzf-lua').files(opts)
  end
end

return {
  'ibhagwan/fzf-lua',
  dependencies = {
    { dir = '~/projects/fzf-lua-lazy', opts = {}, dependencies = { dir = '~/neovim/open.nvim', opts = {} } },
  },
  cmd = 'FzfLua',
  -- opts = { 'telescope' },
  opts = {
    'telescope',
    grep = {
      rg_opts = '--hidden --column --line-number --no-heading --trim '
        .. "--color=always --smart-case -g '!{.git,node_modules}/*'",
    },
    keymap = {
      builtin = {
        ['?'] = 'toggle-preview',
      },
    },
    fzf_opts = {
      ['--layout'] = 'reverse',
    },
    winopts = {
      preview = {
        hidden = vim.fn.winwidth(0) < 125 and 'hidden' or 'nohidden',
      },
    },
  },
  keys = {
    { '<leader>ft', cmd 'builtin', desc = 'fzf builtins' },
    { '<leader>fp', project_files, desc = 'git files' },
    { '<leader>;', cmd 'buffers', desc = 'buffers' },
    { '<leader>/', cmd 'live_grep', desc = 'live grep' },
    { '<leader>fb', cmd 'buffers', desc = 'buffers' },
    { '<leader>ff', cmd 'files', desc = 'all files' },
    { '<leader>fg', cmd 'live_grep', desc = 'live grep' },
    { '<leader>/', cmd 'live_grep', desc = 'live grep' },
    -- { '<leader>fG', filesContaining, desc = 'live grep (files containing)' },
    { '<leader>fd', cmd 'git_files cwd=~/dotfiles', desc = 'find in dotfiles' },
    -- { '<leader>fD', searchDotfiles, desc = 'grep in dotfiles' },
    { '<leader>fh', cmd 'oldfiles', desc = 'old files' },
    { '<leader>fH', cmd 'help_tags', desc = 'help tags' },
    { '<leader>fl', cmd 'lazy', desc = 'lazy plugins' },
    -- { '<leader>f.', grepInCurrentDirectory, desc = 'find in current directory' },
    { '<leader>Ht', cmd 'builtin', desc = 'fzf builtins' },
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
    { '<leader>r', cmd 'resume', desc = 'Fzf resume' },
  },
}
