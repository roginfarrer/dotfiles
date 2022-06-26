local cmp = require 'cmp'
local luasnip = require 'luasnip'

local function border(hl_name)
  return {
    { '╭', hl_name },
    { '─', hl_name },
    { '╮', hl_name },
    { '│', hl_name },
    { '╯', hl_name },
    { '─', hl_name },
    { '╰', hl_name },
    { '│', hl_name },
  }
end

local cmp_window = require 'cmp.utils.window'

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
  local info = self:info_()
  info.scrollable = false
  return info
end

cmp.setup {
  window = {
    completion = {
      border = border 'CmpBorder',
      winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
    },
    documentation = {
      border = border 'CmpDocBorder',
    },
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format(
        '%s %s',
        require('ui.icons').lspkind[vim_item.kind],
        vim_item.kind
      ) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        latex_symbols = '[LaTeX]',
        copilot = '[Copilot]',
      })[entry.source.name]
      return vim_item
    end,
  },
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
  sources = cmp.config.sources({
    { name = 'luasnip', keyword_length = 1 },
    { name = 'copilot' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp' },
    { name = 'npm' },
    { name = 'cmp_git' },
    { name = 'nvim_lua' },
    { name = 'neorg' },
    { name = 'path' },
    { name = 'fish' },
  }, {
    { name = 'buffer', keyword_length = 4 },
  }),
  experimental = {
    -- native_menu = false,
    -- ghost_text = true,
  },
}

-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' },
--   },
-- })
-- cmp.setup.cmdline('?', {
--   sources = {
--     { name = 'buffer' },
--   },
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'fuzzy_path', max_item_count = 10 },
--   }, {
--     { name = 'cmdline', max_item_count = 20, keyword_length = 2 },
--   }),
-- })
