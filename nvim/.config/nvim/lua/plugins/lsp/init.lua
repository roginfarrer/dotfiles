local u = require('utils')
local null_ls = require('plugins.lsp.null-ls')
local tsserver = require('plugins.lsp.tsserver')
local lua_ls = require('plugins.lsp.lua-ls')

local api = vim.api
local lsp = vim.lsp

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
	lsp.diagnostic.on_publish_diagnostics,
	{
		underline = true,
		signs = true,
		virtual_text = false,
	}
)

local on_attach = function(client, bufnr)
	require('lspsaga.diagnostic').show_cursor_diagnostics()
	-- require("lsp_signature").on_attach(
	--   {
	--     use_lspsaga = true
	--   }
	-- )

	-- bindings
	u.buf_map(
		'n',
		'<leader>gd',
		'<cmd> lua vim.lsp.buf.definition()<CR>',
		nil,
		bufnr
	)
	u.buf_map('n', 'gh', ':Lspsaga lsp_finder<CR>', nil, bufnr)
	u.buf_map('n', 'gs', ':Lspsaga signature_help<CR>', nil, bufnr)
	u.buf_map('n', 'gd', ':Lspsaga preview_definition<CR>', nil, bufnr)
	u.buf_map('n', '[g', ':Lspsaga diagnostic_jump_prev<CR>', nil, bufnr)
	u.buf_map('n', ']g', ':Lspsaga diagnostic_jump_next<CR>', nil, bufnr)
	u.buf_map('n', '<leader>lr', ':Lspsaga rename<CR>', nil, bufnr)
	u.buf_map('n', 'K', ':Lspsaga hover_doc<CR>', nil, bufnr)
	u.buf_map(
		'n',
		'<C-F>',
		"<cmd> lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>",
		nil,
		bufnr
	)
	u.buf_map(
		'n',
		'<C-B>',
		"<cmd> lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>",
		nil,
		bufnr
	)
	u.buf_map('n', '<leader>do', ':Lspsaga code_action<CR>', nil, bufnr)
	u.buf_map(
		'v',
		'<leader>do',
		':<C-U>Lspsaga range_code_action<CR>',
		nil,
		bufnr
	)

	if client.resolved_capabilities.document_formatting then
		vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
		require('vimp').map_command('Format', function()
			vim.lsp.buf.formatting()
		end)
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
local servers = { 'vim', 'bash' }
for _, server in pairs(servers) do
	require('lspconfig')[server].setup({
		on_attach = on_attach,
	})
end

null_ls.setup(on_attach)
