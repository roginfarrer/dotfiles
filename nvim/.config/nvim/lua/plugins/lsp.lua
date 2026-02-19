local methods = vim.lsp.protocol.Methods

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
	---@param v KeymapUtil
	local function map(v)
		require('util').keymap(vim.tbl_deep_extend('force', v, { buffer = bufnr }))
	end

	map {
		'K',
		function()
			local winid = require('ufo').peekFoldedLinesUnderCursor()
			if not winid then
				if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
					vim.fn.execute('h ' .. vim.fn.expand '<cword>')
				else
					vim.lsp.buf.hover()
				end
			end
		end,
		desc = 'Hover Docs',
	}
	map {
		'gK',
		function()
			if vim.bo.filetype == 'lua' or vim.bo.filetype == 'help' or vim.bo.filetype == 'lua' then
				vim.fn.execute('h ' .. vim.fn.expand '<cword>')
			end
		end,
		desc = 'Neovim Docs',
	}

	if vim.lsp.document_color then
		vim.lsp.document_color.enable(true, bufnr)
	end
	if client:supports_method 'textDocument/documentColor' then
		map {
			'grc',
			function()
				vim.lsp.document_color.color_presentation()
			end,
			desc = 'vim.lsp.document_color.color_presentation()',
			mode = { 'n', 'x' },
		}
	end

	if client:supports_method(methods.textDocument_documentHighlight) then
		local under_cursor_highlights_group =
			vim.api.nvim_create_augroup('rfarrer/cursor_highlights', { clear = false })
		vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
			group = under_cursor_highlights_group,
			desc = 'Highlight references under the cursor',
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
			group = under_cursor_highlights_group,
			desc = 'Clear highlight references',
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

---@param command string
local function get_ts_bridge_cmd(command)
	local function ensure_ts_bridge_daemon()
		if vim.g.ts_bridge_daemon_started then
			return
		end
		vim.g.ts_bridge_daemon_started = true
		vim.fn.jobstart({
			command,
			'daemon',
			'--listen',
			'127.0.0.1:7007', -- choose your port
			'--idle-ttl',
			'30m',
		}, {
			detach = true,
			env = { RUST_LOG = 'info' },
		})
	end

	local function wait_for_daemon(host, port, timeout_ms)
		local addr = string.format('%s:%d', host, port)
		local function is_ready()
			local ok, chan = pcall(vim.fn.sockconnect, 'tcp', addr, { rpc = false })
			if not ok then
				return false
			end
			if type(chan) == 'number' and chan > 0 then
				vim.fn.chanclose(chan)
				return true
			end
			return false
		end
		return vim.wait(timeout_ms, is_ready, 50)
	end

	local function daemon_cmd(dispatchers)
		ensure_ts_bridge_daemon()
		-- Built-in LSP has no `on_new_config`, and `before_init` runs after `cmd`, so
		-- start + wait here to avoid a first-attach connection refusal.
		wait_for_daemon('127.0.0.1', 7007, 2000)
		return vim.lsp.rpc.connect('127.0.0.1', 7007)(dispatchers)
	end
end

return {
	{
		'folke/lazydev.nvim',
		ft = 'lua', -- only load on lua files
		cmd = 'LazyDev',
		dependencies = {
			{ 'Bilal2453/luvit-meta', lazy = true },
			{
				'DrKJeff16/wezterm-types',
				lazy = true,
				version = false, -- Get the latest version
			},
		},
		opts = {
			library = {
				{ path = 'luvit-meta/library', words = { 'vim%.uv' } },
				{ path = 'lazy.nvim', words = { 'LazyVim' } },
				{ path = 'snacks.nvim', words = { 'Snacks' } },
				-- Needs `justinsgithub/wezterm-types` to be installed
				{ path = 'wezterm-types', mods = { 'wezterm' } },
			},
		},
	},

	{
		'wc-toolkit/wc-language-server',
		lazy = false,
		dir = vim.fn.expand '$HOME' .. '/development/wc-language-server/packages/neovim',
		-- ft = {
		-- 	'html',
		-- 	'javascript',
		-- 	'typescript',
		-- 	'javascriptreact',
		-- 	'typescriptreact',
		-- 	'astro',
		-- 	'svelte',
		-- 	'vue',
		-- 	'markdown',
		-- 	'mdx',
		-- 	'mustache',
		-- 	'hbs',
		-- },
		-- config = function()
		-- 	require('wc-language-server').setup {
		-- 		filetypes = {
		-- 			'html',
		-- 			'javascript',
		-- 			'typescript',
		-- 			'javascriptreact',
		-- 			'typescriptreact',
		-- 			'astro',
		-- 			'svelte',
		-- 			'vue',
		-- 			'markdown',
		-- 			'mdx',
		-- 			'mustache',
		-- 			'hbs',
		-- 		},
		-- 	}
		-- end,
	},

	{
		'mason-org/mason-lspconfig.nvim',
		lazy = false,
		dependencies = {
			'neovim/nvim-lspconfig',
			'folke/lazydev.nvim',
			{ 'WhoIsSethDaniel/mason-tool-installer.nvim' },
			{ 'Bilal2453/luvit-meta', lazy = true },
			{ 'mason-org/mason.nvim', opts = {} },
			{ 'yioneko/nvim-vtsls', lazy = false },
			{ 'dmmulroy/ts-error-translator.nvim', opts = {} },
		},
		cmd = 'Mason',
		opts = {
			ensure_installed = {
				'lua_ls',
				'vtsls',
				'tsgo',
				'eslint',
				'bashls',
				'cssls',
				'marksman',
				'html',
				'jsonls',
				'stylelint_lsp',
				'intelephense',
				'somesass_ls',
				'copilot',
			},
			automatic_enable = {
				exclude = { 'ts_ls', 'tsgo', 'copilot', 'wc_ls', 'wc_language_server', 'cssls', 'vtsls' },
			},
		},
		config = function(_, opts)
			require('mason-lspconfig').setup(opts)

			require('mason-tool-installer').setup {
				run_on_start = true,
				ensure_installed = { 'stylua', 'shfmt', 'prettier', 'prettierd' },
			}

			if require('util').has 'mason-nvim-dap' then
				require('mason-nvim-dap').setup {
					automatic_installation = false,
					handlers = {},
					ensure_installed = {},
				}
			end

			require('util').autocmd('LspAttach', {
				group = 'lsp-attach',
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					local bufnr = event.buf

					if not client then
						return
					end

					on_attach(client, bufnr)
				end,
			})

			vim.lsp.config('*', {
				capabilities = require('blink.cmp').get_lsp_capabilities(nil, true),
			})

			local ts_bridge_executable = vim.fn.expand '$HOME' .. '/development/ts-bridge/target/release/ts-bridge'

			if vim.fn.executable(ts_bridge_executable) == 1 then
				vim.lsp.config('ts_bridge', {
					cmd = ts_bridge_executable,
				})
				vim.lsp.enable 'ts_bridge'
			else
				vim.lsp.enable 'vtsls'
			end

			-- vim.lsp.enable 'wc-language-server'

			-- require('wc_language_server').setup { filetypes = { 'mustache' } }

			-- Update mappings when registering dynamic capabilities.
			local register_capability = vim.lsp.handlers[methods.client_registerCapability]
			vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
				local client = vim.lsp.get_client_by_id(ctx.client_id)
				if not client then
					return
				end

				on_attach(client, vim.api.nvim_get_current_buf())

				return register_capability(err, res, ctx)
			end
		end,
	},

	{ 'dmmulroy/ts-error-translator.nvim', opts = {} },
	-- {
	-- 	'rachartier/tiny-inline-diagnostic.nvim',
	-- 	event = 'VeryLazy',
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require('tiny-inline-diagnostic').setup()
	-- 		vim.diagnostic.config { virtual_text = false } -- Disable Neovim's default virtual text diagnostics
	-- 	end,
	-- },

	{
		'pmizio/typescript-tools.nvim',
		dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
		enabled = false,
		opts = {
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
			settings = {
				separate_diagnostic_server = true,
				expose_as_code_action = 'all',
				tsserver_max_memory = 8192,
				tsserver_file_preferences = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = 'all',
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
					importModuleSpecifierPreference = 'non-relative',
				},
			},
		},
	},
}
