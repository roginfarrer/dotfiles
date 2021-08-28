local null_ls = require('null-ls')
local b = null_ls.builtins

local sources = {
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
}

local M = {}
M.setup = function(on_attach)
	null_ls.setup({
		-- debug = true,
		on_attach = on_attach,
		sources = sources,
	})
end

return M
