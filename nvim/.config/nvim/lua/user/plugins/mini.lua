require('mini.surround').setup {}

local starter = require 'mini.starter'
starter.setup {
  evaluate_single = true,
  items = {
    -- starter.sections.builtin_actions(),
    starter.sections.recent_files(5, false),
    starter.sections.recent_files(5, true),
    {
      action = [[:e ~/dotfiles/fish/.config/fish/config.fish]],
      name = 'Fish Config',
      section = 'Actions',
    },
    {
      action = [[:e ~/dotfiles/nvim/.config/nvim/lua/user/plugins.lua]],
      name = 'Neovim Config',
      section = 'Actions',
    },
    {
      action = [[:e ~/dotfiles/kitty/.config/kitty/kitty.conf]],
      name = 'Kitty Config',
      section = 'Actions',
    },
    -- Use this if you set up 'mini.sessions'
    -- starter.sections.sessions(5, true)
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.indexing('all', { 'Builtin actions' }),
    starter.gen_hook.padding(3, 2),
  },
}

autocmd('FileType', {
  pattern = 'starter',
  callback = function()
    map('n', '-', ':e expand("%:h")')
  end,
  group = 'starter',
})
