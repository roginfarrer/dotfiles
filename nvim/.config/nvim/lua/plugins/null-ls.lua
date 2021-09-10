local null_ls = require('null-ls')
local b = null_ls.builtins
local cmd = vim.cmd

null_ls.config({
	sources = {
		b.formatting.prettierd.with({
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
		b.formatting.stylua,
		b.formatting.fish_indent,
		b.formatting.shfmt,
	},
})

require('lspconfig')['null-ls'].setup({
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			cmd('command! Format lua vim.lsp.buf.formatting()')
			cmd('command! FormatSync lua vim.lsp.buf.formatting_sync()')
			cmd('autocmd BufWritePre <buffer> FormatSync')
		end
	end,
})
