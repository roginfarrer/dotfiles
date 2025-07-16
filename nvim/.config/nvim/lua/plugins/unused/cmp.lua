return {
  {
    'hrsh7th/nvim-cmp',
    enabled = false,
    event = 'InsertEnter',
    version = false,
    dependencies = {
      -- 'zbirenbaum/copilot-cmp',
      -- 'saadparwaiz1/cmp_luasnip',
      {
        'petertriho/cmp-git',
        opts = {},
        init = function()
          table.insert(require('cmp').get_config().sources, { name = 'git' })
        end,
      },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      -- 'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'mtoohey31/cmp-fish',
      -- 'lukas-reineke/cmp-under-comparator',
      { 'roginfarrer/cmp-css-variables', dev = true },
      'roobert/tailwindcss-colorizer-cmp.nvim',
    },
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
      local cmp = require 'cmp'
      local defaults = require 'cmp.config.default'()

      return {
        completion = {
          -- Fix autocompletion breaking when using '$'
          keyword_pattern = [[\k\+]],
        },
        window = {
          completion = cmp.config.window.bordered {
            scrollbar = true,
          },
          documentation = cmp.config.window.bordered {
            scrollbar = true,
          },
        },
        -- snippet = {
        --   expand = function(args)
        --     require('luasnip').lsp_expand(args.body)
        --   end,
        -- },
        formatting = {
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', require('ui.icons').lazy.kinds[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
              -- buffer = '[Buffer]',
              -- nvim_lsp = '[LSP]',
              -- luasnip = '[LuaSnip]',
              -- nvim_lua = '[Lua]',
              -- latex_symbols = '[LaTeX]',
              copilot = '[Copilot]',
            })[entry.source.name]
            local ok, tailwind = pcall(require, 'tailwind-colorizer-cmp')
            if ok then
              return tailwind.formatter(entry, vim_item)
            end
            return vim_item
          end,
        },
        -- sorting = defaults.sorting,
        -- sorting = {
        --   comparators = {
        --     cmp.config.compare.offset,
        --     cmp.config.compare.exact,
        --     cmp.config.compare.score,
        --     cmp.config.compare.recently_used,
        --     require('cmp-under-comparator').under,
        --     cmp.config.compare.kind,
        --   },
        -- },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item {
            behavior = cmp.SelectBehavior.Insert,
          },
          ['<C-p>'] = cmp.mapping.select_prev_item {
            behavior = cmp.SelectBehavior.Insert,
          },
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
          ['<c-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
        },
        sources = cmp.config.sources({
          -- { name = 'css-variables' },
          { name = 'codecompanion' },
          { name = 'nvim_lsp' },
          -- { name = 'luasnip', keyword_length = 1 },
          { name = 'cmp_git' },
          -- { name = 'nvim_lua' },
          {
            name = 'lazydev',
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          },
          { name = 'neorg' },
          { name = 'orgmode' },
          { name = 'path' },
          { name = 'fish' },
        }, {
          { name = 'buffer', keyword_length = 4 },
        }),
      }
    end,
  },

  {
    'nvim-cmp',
    dependencies = {
      {
        'garymjr/nvim-snippets',
        opts = {
          friendly_snippets = true,
          create_cmp_source = true,
        },
        dependencies = { 'rafamadriz/friendly-snippets' },
        keys = {
          {
            '<Tab>',
            function()
              if vim.snippet.active { direction = 1 } then
                vim.schedule(function()
                  vim.snippet.jump(1)
                end)
                return
              end
              return '<Tab>'
            end,
            expr = true,
            silent = true,
            mode = 'i',
          },
          {
            '<Tab>',
            function()
              vim.schedule(function()
                vim.snippet.jump(1)
              end)
            end,
            expr = true,
            silent = true,
            mode = 's',
          },
          {
            '<S-Tab>',
            function()
              if vim.snippet.active { direction = -1 } then
                vim.schedule(function()
                  vim.snippet.jump(-1)
                end)
                return
              end
              return '<S-Tab>'
            end,
            expr = true,
            silent = true,
            mode = { 'i', 's' },
          },
        },
      },
    },
  },
}
