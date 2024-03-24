return {
  {
    'piersolenski/wtf.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {},
    cmd = { 'Wtf', 'WtfSearch' },
    keys = {
      {
        '<leader>da',
        function()
          require('wtf').ai()
        end,
        desc = 'Debug with WTF',
      },
    },
  },
}
