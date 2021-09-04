local u = require('utils')
local lspconfig = require('lspconfig')
local lspinstall = require('lspinstall')
local ts_utils = require('nvim-lsp-ts-utils')
local wk = require('which-key')

local lsp = vim.lsp
local cmd = vim.cmd

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local function buf_nnoremap(keys, command)
	return u.nnoremap(keys, command, { buffer = true })
end

lsp.handlers['textDocument/publishDiagnostics'] = lsp.with(
	lsp.diagnostic.on_publish_diagnostics,
	{
		underline = true,
		signs = true,
		virtual_text = false,
	}
)

local capabilities = lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	},
}

-- _G makes this function available to vimscript lua calls
_G.lsp_organize_imports = function()
	local params = {
		command = '_typescript.organizeImports',
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = '',
	}
	lsp.buf.execute_command(params)
end

local function on_attach(client)
	vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

	require('lspsaga.diagnostic').show_cursor_diagnostics()
	require('lspsaga.diagnostic').show_line_diagnostics()

	cmd([[command! LspGoToDefinition lua vim.lsp.buf.definition()]])
	cmd([[command! LspOrganize lua lsp_organize_imports()]])
	cmd([[command! Format lua vim.lsp.buf.formatting()]])
	cmd([[command! FormatSync lua vim.lsp.buf.formatting_sync()]])

	local leader = {
		l = {
			name = 'LSP',
			a = { ':Lspsaga code_action<CR>', 'Code Action' },
			r = { ':Lspsaga rename<CR>', 'Rename Symbol' },
			f = { ':Format<CR>', 'Format Document' },
			x = { ':TroubleToggle<CR>', 'Trouble' },
		},
	}

	local visual = {
		l = {
			name = 'LSP',
			a = { ':<C-U>Lspsaga range_code_action<CR>', 'Code Action' },
		},
	}

	wk.register(leader, { prefix = '<leader>' })
	wk.register(visual, { prefix = '<leader>', mode = 'v' })

	buf_nnoremap('gd', ':Lspsaga preview_definition<CR>')
	buf_nnoremap('gD', ':LspGoToDefinition<CR>')
	buf_nnoremap('gh', ':Lspsaga lsp_finder<CR>')
	buf_nnoremap('gs', ':Lspsaga signature_help<CR>')
	buf_nnoremap('[g', ':Lspsaga diagnostic_jump_prev<CR>')
	buf_nnoremap(']g', ':Lspsaga diagnostic_jump_prev<CR>')
	buf_nnoremap('K', ':Lspsaga hover_doc<CR>')
	-- buf_nnoremap(
	-- 	'<C-f>',
	-- 	"<cmd> lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"
	-- )
	-- buf_nnoremap(
	-- 	'<C-b>',
	-- 	"<cmd> lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>"
	-- )
	-- u.vnoremap(
	-- 	'<leader>do',
	-- 	':<C-U>Lspsaga range_code_action<CR>',
	-- 	{ buffer = true }
	-- )

	if client.resolved_capabilities.document_formatting then
		vim.cmd('autocmd BufWritePre <buffer> FormatSync')
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

-- install these servers by default
local function install_servers()
	local required_servers = { 'lua', 'typescript', 'bash' }
	local installed_servers = lspinstall.installed_servers()
	for _, server in pairs(required_servers) do
		if not vim.tbl_contains(installed_servers, server) then
			lspinstall.install_server(server)
		end
	end
end

local function setup_servers()
	lspinstall.setup()
	local servers = lspinstall.installed_servers()

	for _, lang in pairs(servers) do
		if lang == 'lua' then
			lspconfig[lang].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						runtime = {
							version = 'LuaJIT',
							-- Setup your lua path
							path = runtime_path,
						},
						diagnostics = {
							globals = {
								-- Get the language server to recognize the `vim` global
								'vim',
							},
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file('', true),
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			})
		elseif lang == 'typescript' then
			lspconfig[lang].setup({
				capabilities = capabilities,
				on_attach = function(client)
					client.resolved_capabilities.document_formatting = false
					on_attach(client)

					ts_utils.setup({
						-- debug = true,
						enable_import_on_completion = true,
						complete_parens = true,
						signature_help_in_parens = true,
						update_imports_on_move = true,
						-- eslint
						eslint_bin = 'eslint_d',
						eslint_opts = {
							condition = function(utils)
								return utils.root_has_file('.eslintrc.js')
									or utils.root_has_file('.eslintrc')
									or utils.root_has_file('.eslintrc.json')
							end,
							diagnostics_format = '#{m} [#{c}]',
						},
						-- formatting
						formatter = 'prettierd',
						-- Currently handled by null-ls directly
						enable_formatting = false,
					})
					ts_utils.setup_client(client)
				end,
			})
		else
			lspconfig[lang].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end
	end
end

local null_ls = require('null-ls')
local null_ls_builtins = null_ls.builtins

require('null-ls').config({
	sources = {
		null_ls_builtins.formatting.prettierd.with({
			filetypes = {
				'javascript',
				'javascriptreact',
				'typescript',
				'typescriptreact',
				'vue',
				'svelte',
				'css',
				'scss',
				'html',
				'json',
				'yaml',
				'markdown',
				'markdown.mdx',
			},
		}),
		null_ls_builtins.formatting.stylua,
		null_ls_builtins.formatting.fish_indent,
		null_ls_builtins.formatting.shfmt,
	},
})
lspconfig['null-ls'].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

install_servers()
setup_servers()

lspinstall.post_install_hook = function()
	setup_servers()
	vim.cmd([[bufdo e]])
end
