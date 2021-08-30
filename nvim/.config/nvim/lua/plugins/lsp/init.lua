local u = require('utils')
local null_ls = require('plugins.lsp.null-ls')
local tsserver = require('plugins.lsp.tsserver')
local lua_ls = require('plugins.lsp.lua-ls')

local lsp = vim.lsp

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
	lsp.diagnostic.on_publish_diagnostics,
	{
		underline = true,
		signs = true,
		virtual_text = false,
	}
)

local on_attach = function(client)
	vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

	require('lspsaga.diagnostic').show_cursor_diagnostics()

	u.nnoremap(
		'<leader>gd',
		'<cmd> lua vim.lsp.buf.definition()<CR>',
		{ buffer = true }
	)
	u.nnoremap('gh', ':Lspsaga lsp_finder<CR>', { buffer = true })
	u.nnoremap('gs', ':Lspsaga signature_help<CR>', { buffer = true })
	u.nnoremap('gd', ':Lspsaga preview_definition<CR>', { buffer = true })
	u.nnoremap('[g', ':Lspsaga diagnostic_jump_prev<CR>', { buffer = true })
	u.nnoremap(']g', ':Lspsaga diagnostic_jump_next<CR>', { buffer = true })
	u.nnoremap('<leader>lr', ':Lspsaga rename<CR>', { buffer = true })
	u.nnoremap('K', ':Lspsaga hover_doc<CR>', { buffer = true })
	u.nnoremap(
		'<C-F>',
		"<cmd> lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
		{ buffer = true }
	)
	u.nnoremap(
		'<C-B>',
		"<cmd> lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
		{ buffer = true }
	)
	u.nnoremap('<leader>do', ':Lspsaga code_action<CR>', { buffer = true })
	u.vnoremap(
		'<leader>do',
		':<C-U>Lspsaga range_code_action<CR>',
		{ buffer = true }
	)

	if client.resolved_capabilities.document_formatting then
		vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
		vim.cmd('command! Format lua vim.lsp.buf.formatting()')
	end
end

require('lspsaga').init_lsp_saga({
	code_action_keys = {
		quit = '<esc>',
	},
	rename_action_keys = {
		quit = '<esc>',
	},
})

require('lspinstall').setup()

require('lspconfig').typescript.setup(tsserver(on_attach))
require('lspconfig').lua.setup(lua_ls(on_attach))

-- Servers without configs
local servers = { 'vim', 'bash', 'css' }
for _, server in pairs(servers) do
	require('lspconfig')[server].setup({
		on_attach = on_attach,
	})
end

null_ls.setup(on_attach)
