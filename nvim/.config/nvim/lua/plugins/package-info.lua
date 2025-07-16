return {
  {
    'vuki656/package-info.nvim',
    opts = {},
    dependencies = { 'MunifTanjim/nui.nvim' },
    ft = 'json',
    keys = {
      { '<leader>ns', "<cmd>lua require('package-info').show()<cr>", desc = '(package-info) Display latest' },
      { '<leader>np', "<cmd>lua require('package-info').change_version()<cr>", desc = '(package-info) Change version' },
    },
    init = function()
      if (require 'util').has 'which-key.nvim' then
        require('which-key').add {
          { '<leader>n', group = 'package-info' },
        }
      end
    end,
  },
  -- {
  --   'mini.clue',
  --   optional = true,
  --   opts = function(_, opts)
  --     return vim.tbl_deep_extend('keep', opts, {
  --       clues = {
  --         { mode = 'n', keys = '<leader>n', desc = '+package-info' },
  --       },
  --     })
  --   end,
  -- },
}
