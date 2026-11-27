vim.pack.add {
	Util.gh 'mfussenegger/nvim-lint',
}

local lint = require 'lint'

lint.linters_by_ft = {
	fish = { 'fish' },
	vim = { 'vint' },
	bash = { 'shellcheck' },
	zsh = { 'shellcheck' },
	sh = { 'shellcheck' },
	php = { 'phpcs' },
}

Util.autocmd({ 'InsertLeave', 'TextChanged' }, {
	group = 'lint',
	callback = function(args)
		lint.try_lint()
	end,
})
