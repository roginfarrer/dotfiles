return {
  'kevinhwang91/nvim-ufo',
  event = 'BufReadPost',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  keys = {
    {
      'zR',
      function()
        require('ufo').openAllFolds()
      end,
      desc = 'Open all folds (UFO)',
    },
    {
      'zM',
      function()
        require('ufo').closeAllFolds()
      end,
      desc = 'Close all folds (UFO)',
    },
  },
  opts = {
    provider_selector = function()
      return { 'treesitter', 'indent' }
    end,
  },
}
