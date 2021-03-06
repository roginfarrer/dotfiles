-- Some handy toggles for trying to setups
vim.g.use_nvim_lsp = true
vim.g.use_telescope = true

_G.global = {}

require("plugins.__plugins")

require("settings")
require("autocmds")
require("keybindings")

if vim.g.use_nvim_lsp then
  require("plugins.lsp")
end

if vim.fn.empty(vim.fn.glob("$HOME/.config/nvim/local-config.vim")) == 0 then
  vim.cmd([[source $HOME/.config/nvim/local-config.vim]])
end
