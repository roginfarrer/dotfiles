return {
  -- { 'moll/vim-bbye', cmd = 'Bdelete' },
  -- { 'kevinhwang91/nvim-bqf', ft = 'qf', enabled = false },
  { 'jxnblk/vim-mdx-js', enabled = false, ft = 'mdx' },
  { 'fladson/vim-kitty', ft = 'kitty' },
  { 'Amar1729/skhd-vim-syntax', ft = 'skhd' },
  { 'camnw/lf-vim', ft = 'lf' },
  {
    'nvim-neorg/neorg',
    enabled = false,
    ft = 'norg',
    cmd = { 'Neorg' },
    build = ':Neorg sync-parsers', -- This is the important bit!
    opts = {
      -- Tell Neorg what modules to load
      load = {
        ['core.defaults'] = {}, -- Load all the default modules
        ['core.concealer'] = {}, -- Allows for use of icons
        ['core.dirman'] = { -- Manage your directories with Neorg
          config = {
            workspaces = {
              main = '~/Dropbox (Maestral)/neorg',
            },
          },
        },
        ['core.journal'] = {
          config = {
            workspace = 'main',
          },
        },
        ['core.completion'] = {
          config = {
            engine = 'nvim-cmp',
          },
        },
      },
    },
  },

  -- {
  --   'nvim-orgmode/orgmode',
  --   enabled = false,
  --   -- ft = 'org',
  --   opts = {
  --     org_agenda_files = { '~/Dropbox (Maestral)/org/**/*' },
  --     org_default_notes_file = '~/Dropbox (Maestral)/org/notes.org',
  --   },
  --   -- init = function()
  --   --   autocmd('BufReadPre', {
  --   --     group = 'org_ft',
  --   --     pattern = '*.org',
  --   --     callback = function()
  --   --       vim.cmd 'doautocmd FileType org'
  --   --     end,
  --   --   })
  --   -- end,
  --   config = function(_, opts)
  --     require('orgmode').setup_ts_grammar()
  --     require('orgmode').setup(opts)
  --   end,
  -- },
}
