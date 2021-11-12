_G.global = {}

-- Safely require it, in case it doesn't exist
pcall(require, 'local-config')
pcall(vim.cmd, 'source $HOME/.config/nvim/local-config.vim')

require 'rf.packerInit'
