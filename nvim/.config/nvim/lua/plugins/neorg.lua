return {
  'nvim-neorg/neorg',
  -- enabled = false,
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
      -- ['core.gtd.base'] = {
      --   config = {
      --     workspace = '~/neorg/gtd',
      --   },
      -- },
      ['core.norg.completion'] = {
        config = {
          engine = 'nvim-cmp',
        },
      },
    },
  },
}
