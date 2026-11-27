Util.on_event('BufEnter', function()
	local methods = vim.lsp.protocol.Methods

	vim.pack.add {
		'https://github.com/folke/lazydev.nvim',
		'https://github.com/DrKJeff16/wezterm-types',
		'https://github.com/mason-org/mason-lspconfig.nvim',
		'https://github.com/neovim/nvim-lspconfig',
		'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
		'https://github.com/Bilal2453/luvit-meta',
		'https://github.com/mason-org/mason.nvim',
	}

	require('lazydev').setup {
		library = {
			{ path = 'u', words = { 'Util' } },
			{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			{ path = 'LazyVim', words = { 'LazyVim' } },
			{ path = 'snacks.nvim', words = { 'Snacks' } },
			-- Needs `justinsgithub/wezterm-types` to be installed
			{ path = 'wezterm-types', mods = { 'wezterm' } },
		},
	}

	---@param client vim.lsp.Client
	---@param bufnr integer
	local function on_attach(client, bufnr)
		---@param v KeymapUtil
		local function map(v)
			Util.keymap(vim.tbl_deep_extend('force', v, { buffer = bufnr }))
		end

		if vim.lsp.document_color then
			vim.lsp.document_color.enable(true)
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

	require('mason').setup()
	require('mason-lspconfig').setup {
		ensure_installed = {
			'lua_ls',
			'tsc',
			'eslint',
			'bashls',
			'html',
			'jsonls',
			'intelephense',
			'somesass_ls',
			'copilot',
		},
		automatic_enable = {
			exclude = { 'copilot', 'wc_ls', 'cssls', 'mdx_analyzer' },
		},
	}

	require('mason-tool-installer').setup {
		run_on_start = true,
		ensure_installed = { 'stylua', 'oxfmt' },
	}

	Util.autocmd('LspAttach', {
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

	local register_capability = vim.lsp.handlers[methods.client_registerCapability]
	vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
		local client = vim.lsp.get_client_by_id(ctx.client_id)
		if not client then
			return
		end

		on_attach(client, vim.api.nvim_get_current_buf())

		return register_capability(err, res, ctx)
	end
end)
