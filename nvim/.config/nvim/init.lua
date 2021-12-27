-- impatient.nvim will only be required until https://github.com/neovim/neovim/pull/15436 is merged
if not pcall(require, 'impatient') then
  print 'failed to load impatient.nvim'
end

_G.global = {}

local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Safely require it, in case it doesn't exist
pcall(require, 'local-config')
pcall(vim.cmd, 'source $HOME/.config/nvim/local-config.vim')

require 'user.packerInit'
