local u = require('utils')
local lspconfig = require('lspconfig')
local lspinstall = require('lspinstall')
local lsp_status = require('lsp-status')
local wk = require('which-key')

lsp_status.register_progress()

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

local capabilities = lsp_status.capabilities
if packer_plugins['nvim-cmp'] and packer_plugins['nvim-cmp'].loaded then
	capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end

local function on_attach(client)
	vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

  lsp_status.on_attach(client)

	cmd('command! LspGoToDefinition lua vim.lsp.buf.definition()')
	cmd('command! LspGoToDeclaration lua vim.lsp.buf.declaration()')
	cmd('command! LspHover lua vim.lsp.buf.hover()')
	cmd('command! LspImplementations lua vim.lsp.buf.implementation()')
	cmd('command! LspSignatureHelp lua vim.lsp.buf.signature_help()')
	cmd('command! LspTypeDefinition lua vim.lsp.buf.type_definition()')
	cmd('command! LspRenameSymbol lua vim.lsp.buf.rename()')
	cmd('command! LspCodeAction lua vim.lsp.buf.code_action()')
	cmd('command! LspRangeCodeAction lua vim.lsp.buf.range_code_action()')
	cmd('command! LspReferences lua vim.lsp.buf.references()')
	cmd('command! LspPrevDiagnostic lua vim.lsp.diagnostic.goto_prev()')
	cmd('command! LspNextDiagnostic lua vim.lsp.diagnostic.goto_next()')
	cmd('command! Format lua vim.lsp.buf.formatting()')
	cmd('command! FormatSync lua vim.lsp.buf.formatting_sync()')

	local leader = {
		l = {
			name = 'LSP',
			a = { ':LspCodeAction<CR>', 'Code Action' },
			r = { ':LspRenameSymbol<CR>', 'Rename Symbol' },
			f = { ':Format<CR>', 'Format Document' },
			x = { ':TroubleToggle<CR>', 'Trouble' },
		},
	}

	local visual = {
		l = {
			name = 'LSP',
			a = { ':LspRangeCodeAction<CR>', 'Code Action' },
		},
	}

	wk.register(leader, { prefix = '<leader>' })
	wk.register(visual, { prefix = '<leader>', mode = 'v' })

	buf_nnoremap('gd', ':LspGoToDefinition<CR>')
	buf_nnoremap('gD', ':LspGoToDeclaration<CR>')
	-- buf_nnoremap('gh', ':Lspsaga lsp_finder<CR>')
	buf_nnoremap('gs', ':LspSignatureHelp<CR>')
	buf_nnoremap('[g', ':LspPrevDiagnostic<CR>')
	buf_nnoremap(']g', ':LspNextDiagnostic<CR>')
	buf_nnoremap('K', ':LspHover<CR>')

	if client.resolved_capabilities.document_formatting then
		vim.cmd('autocmd BufWritePre <buffer> FormatSync')
	end
end

-- require('lspsaga').init_lsp_saga({
-- 	code_action_keys = {
-- 		quit = '<esc>',
-- 	},
-- 	rename_action_keys = {
-- 		quit = '<esc>',
-- 	},
-- })

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

	local config = {}

	for _, lang in pairs(servers) do
		if lang == 'lua' then
			config.lua = {
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
			}
		elseif lang == 'typescript' then
			config.typescript = {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					client.resolved_capabilities.document_formatting = false
					client.resolved_capabilities.document_range_formatting = false
					on_attach(client)

					local ts_utils = require('nvim-lsp-ts-utils')

					ts_utils.setup({
						-- debug = true,
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

					local leader = {
						l = {
							o = { ':TSLspOrganize<CR>', '(TS) Organize Imports' },
							i = { ':TSLspImportAll<CR>', '(TS) Import Missing Imports' },
							R = { ':TSLspRenameFile<CR>', '(TS) Rename File' },
						},
					}
					wk.register(leader, { prefix = '<leader>', buffer = bufnr })
				end,
			}
		else
			config[lang] = {
				on_attach = on_attach,
				capabilities = capabilities,
			}
		end
	end

	if packer_plugins['coq_nvim'] and packer_plugins['coq_nvim'].loaded then
		for lang in pairs(config) do
			lspconfig[lang].setup(
				require('coq').lsp_ensure_capabilities(config[lang])
			)
		end
	else
		for lang in pairs(config) do
			lspconfig[lang].setup(config[lang])
		end
	end
end

install_servers()
setup_servers()

lspinstall.post_install_hook = function()
	setup_servers()
	vim.cmd([[bufdo e]])
end
