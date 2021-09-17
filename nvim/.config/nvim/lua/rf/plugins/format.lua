local prettierd = function()
	return {
		exe = 'prettierd',
		args = { vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end

local prettier = prettierd

require('formatter').setup({
	logging = false,
	filetype = {
		javascript = { prettier },
		javascriptreact = { prettier },
		typescript = { prettier },
		typescriptreact = { prettier },
		css = { prettier },
		markdown = { prettier },
		['markdown.mdx'] = { prettier },
		scss = { prettier },
		html = { prettier },
		json = { prettier },
		yaml = { prettier },
		yml = { prettier },
		lua = {
			function()
				return {
					exe = 'luafmt',
					args = { '--indent-count', 2, '--stdin' },
					stdin = true,
				}
			end,
		},
	},
})

vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.tsx,*.md,*.mdx,*.css,*.scss,*.yaml,*.yml,*.json,*.jsx,*.lua FormatWrite
augroup END
]],
	true
)
