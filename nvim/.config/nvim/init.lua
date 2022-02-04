-- impatient.nvim will only be required until https://github.com/neovim/neovim/pull/15436 is merged
if not pcall(require, 'impatient') then
  print 'failed to load impatient.nvim'
end

_G.global = {}

require 'user.startup'
require 'user.disable_builtins'
require 'user.settings'
require 'user.utils'

-- Safely require it, in case it doesn't exist
pcall(require, 'local-config')
pcall(vim.cmd, 'source $HOME/.config/nvim/local-config.vim')

require 'user.packerInit'
require 'user.mappings'
require 'user.theme'
