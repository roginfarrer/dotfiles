local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
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
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes(
						'<Plug>luasnip-expand-or-jump',
						true,
						true,
						true
					),
					''
				)
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true),
					''
				)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'nvim_lua' },
		{ name = 'buffer' },
		{ name = 'path' },
	},
})
