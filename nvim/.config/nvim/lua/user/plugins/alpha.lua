local alpha = require 'alpha'
local startify = require 'alpha.themes.startify'
local dashboard = require 'alpha.themes.dashboard'

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
startify.section.top_buttons.val = {
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
  startify.button(
    's',
    'Restore Last Session',
    ':SessionManager load_last_session<CR>'
  ),
  -- startify.button(
  --   't',
  --   'Open daily note',
  --   '<cmd>ZkNew {template="daily.md", dir="daily"}<CR>'
  -- ),
}
startify.section.mru_cwd.val = {}

alpha.setup(startify.opts)
