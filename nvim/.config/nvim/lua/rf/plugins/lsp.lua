local u = require('rf.utils')
local lspconfig = require('lspconfig')
local lspinstall = require('lspinstall')
local lspstatus = require('lsp-status')
local wk = require('which-key')

local lsp = vim.lsp
local cmd = vim.cmd

lspstatus.register_progress()

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

lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = 'single',
})
lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
	vim.lsp.handlers.signature_help,
	{
		border = 'single',
	}
)

local icons = {
	Class = ' ',
	Color = ' ',
	Constant = ' ',
	Constructor = ' ',
	Enum = '了 ',
	EnumMember = ' ',
	Field = ' ',
	File = ' ',
	Folder = ' ',
	Function = ' ',
	Interface = 'ﰮ ',
	Keyword = ' ',
	Method = 'ƒ ',
	Module = ' ',
	Property = ' ',
	Snippet = '﬌ ',
	Struct = ' ',
	Text = ' ',
	Unit = ' ',
	Value = ' ',
	Variable = ' ',
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
	kinds[i] = icons[kind] or kind
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
if isPackageLoaded('cmp_nvim_lsp') then
	capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end
capabilities = vim.tbl_extend('keep', capabilities, lspstatus.capabilities)
capabilities.textDocument.completion.completionItem.documentationFormat = {
	'markdown',
	'plaintext',
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
	true
capabilities.textDocument.completion.completionItem.tagSupport = {
	valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	},
}

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
	vim.fn.sign_define(
		'LspDiagnosticsSign' .. name,
		{ text = icon, numhl = 'LspDiagnosticsDefault' .. name }
	)
end

lspSymbol('Error', '')
lspSymbol('Information', '')
lspSymbol('Hint', '')
lspSymbol('Warning', '')

local function on_attach(client)
	lspstatus.on_attach(client)

	vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

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
			q = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', 'Quickfix' },
			s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
			S = {
				'<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
				'Workspace Symbols',
			},
		},
	}

	local visual = {
		l = {
			name = 'LSP',
			a = { ':LspRangeCodeAction<CR>', 'Code Action' },
		},
	}

	wk.register(leader, { prefix = '<leader>' })
	wk.register(visual, { prefix = '<leader>', mode = 'x' })

	local function showDocs()
		if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
			vim.fn.execute('h ' .. vim.fn.expand('<cword>'))
		else
			vim.fn.execute('LspHover')
		end
	end

	buf_nnoremap('gd', ':LspGoToDefinition<CR>')
	buf_nnoremap('gD', ':LspGoToDeclaration<CR>')
	buf_nnoremap('gi', ':LspImplementations<CR>')
	buf_nnoremap('gr', ':LspReferences<CR>')
	buf_nnoremap('gs', ':LspSignatureHelp<CR>')
	buf_nnoremap('[g', ':LspPrevDiagnostic<CR>')
	buf_nnoremap(']g', ':LspNextDiagnostic<CR>')
	buf_nnoremap('K', showDocs)

	if client.resolved_capabilities.document_formatting then
		vim.cmd('autocmd BufWritePre <buffer> FormatSync')
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
		null_ls_builtins.diagnostics.vint.with({
			args = { '--enable-neovim', '-s', '-j', '$FILENAME' },
		}),
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
      elseif lang == 'json' then
			config.json = {
				on_attach = function(client)
          on_attach(client)
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
        end,
				capabilities = capabilities,
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
			lspconfig[lang].setup(require('coq').lsp_ensure_capabilities(config[lang]))
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