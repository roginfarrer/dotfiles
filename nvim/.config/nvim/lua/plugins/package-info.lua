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
      require('which-key').add {
        { '<leader>n', group = 'package-info' },
      }
    end,
  },
}
