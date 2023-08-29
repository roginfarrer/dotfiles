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

require('lazy').setup {
  defaults = {
    version = false,
    lazy = true,
  },
  spec = {
    { dir = '~/projects/LazyVim', import = 'lazyvim.plugins' },
    { import = 'plugins' },
  },
  dev = {
    path = '~/projects',
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
        -- 'ftplugin',
      },
    },
  },
}
