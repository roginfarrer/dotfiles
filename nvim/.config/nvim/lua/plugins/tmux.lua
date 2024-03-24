return {
  {
    'aserowy/tmux.nvim',
    lazy = false,
    opts = {
      -- Conflicts with Yanky, generally slows things down
      copy_sync = { enable = false },
      resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = false,
        resize_step_x = 5,
        resize_step_y = 5,
      },
    },
    keys = {
      { '<C-h>', [[<cmd>lua require'tmux'.move_left()<cr>]], desc = 'move bottom' },
      { '<C-j>', [[<cmd>lua require'tmux'.move_bottom()<cr>]], desc = 'move left' },
      { '<C-k>', [[<cmd>lua require'tmux'.move_top()<cr>]], desc = 'move top' },
      { '<C-l>', [[<cmd>lua require'tmux'.move_right()<cr>]], desc = 'move right' },
      { '<S-Left>', [[<cmd>lua require("tmux").resize_left()<cr>]], desc = 'resize left' },
      { '<S-Down>', [[<cmd>lua require("tmux").resize_down()<cr>]], desc = 'resize down' },
      { '<S-Up>', [[<cmd>lua require("tmux").resize_up()<cr>]], desc = 'resize up' },
      { '<S-Right>', [[<cmd>lua require("tmux").resize_right()<cr>]], desc = 'resize right' },
    },
  },
}
