local alpha = require 'alpha'

local function btn(sc, txt, keybind)
  local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

  local opts = {
    position = 'center',
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = 'right',
    -- hl = 'Keyword',
  }

  if keybind then
    opts.keymap = { 'n', sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = 'button',
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, 'normal', false)
    end,
    opts = opts,
  }
end

local options = {}

local ascii = {
  [[███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
  [[████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
  [[██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
  [[██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
  [[██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
  [[╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
}

options.header = {
  type = 'text',
  val = ascii,
  opts = {
    position = 'center',
    hl = 'Character',
  },
}

options.buttons = {
  type = 'group',
  val = {
    btn(
      'p',
      '  Find file',
      ':lua require("plugins.configs.telescope").project_files()<CR>'
    ),
    btn('h', '  Recently opened files', ':Telescope old_files<CR>'),
    btn(
      'w',
      '  Load git worktree',
      ':Telescope git_worktree git_worktrees<CR>'
    ),
    btn(
      's',
      '  Restore last session',
      ':SessionManager load_last_session<CR>'
    ),
    btn('u', '  Update plugins', ':PackerSync<CR>'),
    btn(
      'v',
      'Open Neovim Plugins',
      '<cmd>e ~/dotfiles/nvim/.config/nvim/lua/user/plugins.lua<CR>'
    ),
    btn(
      'k',
      'Open Kitty Config',
      '<cmd>e ~/dotfiles/kitty/.config/kitty/kitty.conf<CR>'
    ),
    btn(
      'f',
      'Open Fish Config',
      '<cmd>e ~/dotfiles/fish/.config/fish/config.fish<CR>'
    ),
  },
  opts = {
    spacing = 1,
  },
}

-- dynamic header padding
local fn = vim.fn
local marginTopPercent = 0.3
local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }

alpha.setup {
  layout = {
    { type = 'padding', val = headerPadding },
    options.header,
    { type = 'padding', val = 2 },
    options.buttons,
  },
  opts = {},
}
