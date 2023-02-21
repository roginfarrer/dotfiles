return {
  { 'moll/vim-bbye', cmd = 'Bdelete' },
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  { 'jxnblk/vim-mdx-js', ft = 'mdx' },
  { 'fladson/vim-kitty', ft = 'kitty' },

  {
    'nvim-neorg/neorg',
    ft = 'norg',
    build = ':Neorg sync-parsers', -- This is the important bit!
    opts = {
      -- Tell Neorg what modules to load
      load = {
        ['core.defaults'] = {}, -- Load all the default modules
        ['core.norg.concealer'] = {}, -- Allows for use of icons
        ['core.norg.dirman'] = { -- Manage your directories with Neorg
          config = {
            workspaces = {
              my_workspace = '~/neorg',
            },
          },
        },
        ['core.norg.completion'] = {
          config = {
            engine = 'nvim-cmp',
          },
        },
      },
    },
  },
  config = function()
    local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

    parser_configs.norg_meta = {
      install_info = {
        url = 'https://github.com/nvim-neorg/tree-sitter-norg-meta',
        files = { 'src/parser.c' },
        branch = 'main',
      },
    }

    parser_configs.norg_table = {
      install_info = {
        url = 'https://github.com/nvim-neorg/tree-sitter-norg-table',
        files = { 'src/parser.c' },
        branch = 'main',
      },
    }
  end,
}
