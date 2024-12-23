return {
  {
    'Goose97/timber.nvim',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    opts = {
      default_keymaps_disabled = true,
      keymaps = {
        insert_log_below = 'glj',
        insert_log_above = 'glk',
        insert_plain_log_below = 'glo',
        insert_plain_log_above = 'gl<S-o>',
        insert_batch_log = 'glb',
        add_log_targets_to_batch = 'gla',
        insert_log_below_operator = 'g<S-l>j',
        insert_log_above_operator = 'g<S-l>k',
        insert_batch_log_operator = 'g<S-l>b',
        add_log_targets_to_batch_operator = 'g<S-l>a',
      },
    },
    keys = {
      'glj',
      'glk',
      'glo',
      'gl<S-o>',
      'glb',
      'gla',
      'g<S-l>j',
      'g<S-l>k',
      'g<S-l>b',
      'g<S-l>a',
    },
  },
  {
    'folke/which-key.nvim',
    optional = true,
    config = function()
      require('which-key').add { { 'gl', group = 'log', { 'gL', group = 'log batch' } } }
    end,
  },
}
