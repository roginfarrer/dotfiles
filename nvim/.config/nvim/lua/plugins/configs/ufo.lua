require('which-key').register {
  zR = {
    function()
      require('ufo').openAllFolds()
    end,
    'Open all folds (UFO)',
  },
  zM = {
    function()
      require('ufo').closeAllFolds()
    end,
    'Close all folds (UFO)',
  },
}

require('ufo').setup {
  provider_selector = function(bufnr, filetype)
    return { 'treesitter', 'indent' }
  end,
}
