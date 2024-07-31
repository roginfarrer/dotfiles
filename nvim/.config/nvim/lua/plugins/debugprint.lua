return {
  -- Debugging utils
  {
    'andrewferrier/debugprint.nvim',
    config = function()
      require('debugprint').setup()
      require('which-key').add {
        { 'g?', group = 'debugprint' },
      }
    end,
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
