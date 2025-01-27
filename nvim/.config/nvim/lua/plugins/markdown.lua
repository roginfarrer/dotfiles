return {
  {
    'OXY2DEV/markview.nvim',
    cond = not vim.g.disable_treesitter,
    -- ft = { 'markdown', 'mdx' },
    -- cmd = 'Markview',
    lazy = false,
    name = 'markview',
    dependencies = { 'echasnovski/mini.icons' },
    opts = function()
      return {
        preview = { modes = { 'n' } },
        -- callbacks = {
        --   on_enable = function(_, win)
        --     vim.wo[win].conceallevel = 2
        --     vim.wo[win].concealcursor = 'c'
        --   end,
        -- },
        markdown = {
          list_items = {
            enable = false,
            marker_minus = {
              add_padding = false,
              text = '',
            },
          },
          headings = require('markview.presets').headings.glow,
        },
        checkboxes = {
          enable = false,
        },
      }
    end,
  },
}
