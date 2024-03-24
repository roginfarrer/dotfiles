return {
  { 'folke/zen-mode.nvim', cmd = 'ZenMode', opts = { wezterm = { enabled = true } } },

  {
    'anuvyklack/windows.nvim',
    enabled = false,
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    event = 'BufAdd',
    init = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
    end,
    opts = {
      animation = {
        fps = 40,
        duration = 200,
      },
    },
  },
}
