local M = {}

M.bootstrap = function()
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      '--single-branch',
      'https://github.com/folke/lazy.nvim.git',
      lazypath,
    }
  end
  vim.opt.runtimepath:prepend(lazypath)
end

M.options = {
  dev = {
    path = '~/projects/neovim-dev',
  },
  install = {
    missing = true,
    colorscheme = { 'catppuccin' },
  },
  -- checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        -- "python3_provider",
        -- "python_provider",
        -- "node_provider",
        'ruby_provider',
        'perl_provider',
        'tutor',
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
      },
    },
  },
}

M.run = function(plugins)
  local final_table = {}

  for key, _ in pairs(plugins) do
    plugins[key][1] = key
    final_table[#final_table + 1] = plugins[key]
  end

  vim.g.mapleader = ' '
  require('lazy').setup(final_table, M.options)
end

return M
