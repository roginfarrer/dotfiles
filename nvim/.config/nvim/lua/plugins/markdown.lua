return {
  {
    'OXY2DEV/markview.nvim',
    -- ft = { 'markdown', 'mdx' },
    -- cmd = 'Markview',
    lazy = false,
    name = 'markview',
    dependencies = { 'echasnovski/mini.icons' },
    opts = function()
      return {
        modes = { 'n' },
        -- callbacks = {
        --   on_enable = function(_, win)
        --     vim.wo[win].conceallevel = 2
        --     vim.wo[win].concealcursor = 'c'
        --   end,
        -- },
        list_items = {
          enable = false,
          marker_minus = {
            add_padding = false,
            text = '',
          },
        },
        checkboxes = {
          enable = false,
        },
        headings = require('markview.presets').headings.glow,
      }
    end,
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
