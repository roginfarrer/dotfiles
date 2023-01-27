return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'folke/which-key.nvim', event = 'VeryLazy' },
  {
    'glacambre/firenvim',
    lazy = false,
    enabled = false,
    build = function()
      vim.fn['firenvim#install'](0)
    end,
  },

  { 'ellisonleao/glow.nvim', cmd = 'Glow' },
}
