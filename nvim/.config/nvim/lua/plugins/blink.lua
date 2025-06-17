return {
  {
    'saghen/blink.cmp',
    enabled = true,
    events = 'InsertEnter',
    -- optional: provides snippets for the snippet source
    dependencies = {
      -- 'rafamadriz/friendly-snippets',
      -- 'L3MON4D3/LuaSnip',
      {
        'Kaiser-Yang/blink-cmp-git',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
      -- 'MahanRahmati/blink-nerdfont.nvim',
      'ribru17/blink-cmp-spell',
    },
    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    opts = {
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },
      sources = {
        default = { --[[ 'git',  ]]
          'lsp',
          'path',
          'snippets',
          'buffer',
          -- 'nerdfont',
          'spell',
        },
        providers = {
          -- git = {
          --   module = 'blink-cmp-git',
          --   name = 'Git',
          --   opts = {
          --     -- options for the blink-cmp-git
          --   },
          -- },
          -- nerdfont = {
          --   module = 'blink-nerdfont',
          --   name = 'Nerd Fonts',
          --   score_offset = 15, -- Tune by preference
          --   opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
          -- },
          spell = {
            name = 'Spell',
            module = 'blink-cmp-spell',
          },
        },
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = {
          draw = {
            treesitter = { 'lsp' },
          },
        },
      },
      keymap = {
        -- preset = 'enter',
        ['<C-y>'] = { 'select_and_accept' },
      },
      -- snippets = { preset = 'luasnip' },
    },
  },
}
