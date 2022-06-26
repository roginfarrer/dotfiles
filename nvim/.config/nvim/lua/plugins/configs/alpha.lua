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

dashboard.section.header.val = {
  [[███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
  [[████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
  [[██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
  [[██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
  [[██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
  [[╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
}
dashboard.section.buttons.val = {
  dashboard.button('p', '  Find file', ':lua _G.project_files()<CR>'),
  dashboard.button(
    'h',
    '  Recently opened files',
    ':Telescope old_files<CR>'
  ),
  -- dashboard.button("SPC t l", "  Find word"),
  -- dashboard.button("SPC t F", "  File browser"),
  dashboard.button(
    'w',
    '  Load git worktree',
    ':Telescope git_worktree git_worktrees<CR>'
  ),
  dashboard.button(
    's',
    '  Restore last session',
    ':SessionManager load_last_session<CR>'
  ),
  -- dashboard.button("SPC c n", "  New file"),
  dashboard.button('u', '  Update plugins', ':PackerSync<CR>'),
  -- dashboard.button('q', '  Quit', ':qa<CR>'),
  dashboard.button(
    'v',
    'Open Neovim Plugins',
    '<cmd>e ~/dotfiles/nvim/.config/nvim/lua/user/plugins.lua<CR>'
  ),
  dashboard.button(
    'k',
    'Open Kitty Config',
    '<cmd>e ~/dotfiles/kitty/.config/kitty/kitty.conf<CR>'
  ),
  dashboard.button(
    'f',
    'Open Fish Config',
    '<cmd>e ~/dotfiles/fish/.config/fish/config.fish<CR>'
  ),
}

-- dynamic header padding
local fn = vim.fn
local marginTopPercent = 0.3
local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }
dashboard.opts.layout[1] = { type = 'padding', val = headerPadding }

alpha.setup(dashboard.opts)
