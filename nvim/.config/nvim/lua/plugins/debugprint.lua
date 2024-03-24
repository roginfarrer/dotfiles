return {
  -- Debugging utils
  {
    'andrewferrier/debugprint.nvim',
    dependencies = {
      {
        'folke/which-key.nvim',
        opts = function(_, opts)
          opts.defaults = opts.defaults or {}
          opts.defaults['g?'] = { name = '+debugprint' }
        end,
      },
    },
    opts = {},
    -- Remove the following line to use development versions,
    -- not just the formal releases
    version = '*',
    keys = {
      { 'g?p', desc = 'Plain debug below' },
      { 'g?P', desc = 'Plain debug above' },
      { 'g?v', desc = 'Variable debug below', mode = { 'v', 'n' } },
      { 'g?V', desc = 'Variable debug above', mode = { 'v', 'n' } },
      { 'g?o', desc = 'Variable debug below', mode = 'o' },
      { 'g?O', desc = 'Variable debug above', mode = 'o' },
    },
  },
}
