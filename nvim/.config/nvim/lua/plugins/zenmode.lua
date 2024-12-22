return {
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    opts = {
      wezterm = { enabled = true },
      window = { width = 80, options = { number = false, relativenumber = false } },
      plugins = { kitty = { enabled = true } },
    },
  },
}
