local null_ls = require('null-ls')
local b = null_ls.builtins
local vimp = require('vimp')

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
			vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
			vimp.map_command('Format', function()
				vim.lsp.buf.formatting()
			end)
		end
	end,
})
