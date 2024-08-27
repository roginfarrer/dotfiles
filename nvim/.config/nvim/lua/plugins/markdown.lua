return {
  {
    'OXY2DEV/markview.nvim',
    ft = { 'markdown', 'mdx' },
    cmd = 'Markview',
    name = 'markview',
    dependencies = { 'echasnovski/mini.icons' },
    opts = {
      modes = { 'n' },
    },
  },

  {
    'MeanderingProgrammer/markdown.nvim',
    enabled = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('render-markdown').setup {}
    end,
    ft = { 'markdown', 'mdx' },
  },
}
