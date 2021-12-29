local alpha = require 'alpha'
local startify = require 'alpha.themes.startify'

startify.section.header.val = {
  [[███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
  [[████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
  [[██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
  [[██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
  [[██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
  [[╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
}
startify.nvim_web_devicons = {
  enabled = true,
  highlight = true,
}
startify.section.bottom_buttons.val = {
  startify.button(
    'v',
    'Open Neovim Plugins',
    '<cmd>e ~/dotfiles/nvim/.config/nvim/lua/user/plugins.lua<CR>'
  ),
  startify.button(
    'k',
    'Open Kitty Config',
    '<cmd>e ~/dotfiles/kitty/.config/kitty/kitty.conf<CR>'
  ),
  startify.button(
    'f',
    'Open Fish Config',
    '<cmd>e ~/dotfiles/fish/.config/fish/config.fish<CR>'
  ),
}

alpha.setup(startify.opts)
