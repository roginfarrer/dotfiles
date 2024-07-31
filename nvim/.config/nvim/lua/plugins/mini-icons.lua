return {
  {
    'echasnovski/mini.icons',
    lazy = true,
    version = false,
    config = function(_, opts)
      require('mini.icons').setup(opts)
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
