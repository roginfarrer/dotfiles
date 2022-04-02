
  require('mini.surround').setup {}
  local starter = require("mini.starter")
  starter.setup {
    -- evaluate_single = true,
    items = {
      starter.sections.builtin_actions(),
      starter.sections.recent_files(5, false),
      starter.sections.recent_files(5, true),
      -- Use this if you set up 'mini.sessions'
      -- starter.sections.sessions(5, true)
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.indexing('all', { 'Builtin actions' }),
      starter.gen_hook.padding(3, 2),
    },
  }
