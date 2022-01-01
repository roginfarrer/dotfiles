local cmp = require 'cmp'
local luasnip = require 'luasnip'
-- require 'user.plugins.cmp-zk'

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require('lspkind').presets.default[vim_item.kind]
        .. ' '
        .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        latex_symbols = '[Latex]',
      })[entry.source.name]
      return vim_item
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<c-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources {
    -- { name = 'zk' },
    { name = 'luasnip' },
    { name = 'npm' },
    { name = 'cmp_git' },
    { name = 'nvim_lua' },
    { name = 'neorg' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}
