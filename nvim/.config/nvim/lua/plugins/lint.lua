return {
	{
		'mfussenegger/nvim-lint',
		event = 'BufReadPost',
		-- ft = ft,
		config = function(_, opts)
			require('lint').linters_by_ft = {
				fish = { 'fish' },
				-- css = { 'stylelint' },
				-- scss = { 'stylelint' },
				-- lua = { 'luacheck' },
				vim = { 'vint' },
				bash = { 'shellcheck' },
				zsh = { 'shellcheck' },
				sh = { 'shellcheck' },
				php = { 'phpcs' },
			}
			local phpcs = require('lint').linters.phpcs
			phpcs.args = {
				'-q',
				'--report=json',
				'--standard=/home/rfarrer/development/Etsyweb/tests/standards/stable-ruleset.xml',
				'-', -- need `-` at the end for stdin support
			}
			-- require('util').autocmd({ 'BufEnter', 'BufWritePost' }, {
			--   group = 'lint',
			--   callback = function()
			--     vim.print 'try lint'
			--     require('lint').try_lint()
			--   end,
			-- })
		end,
	},
}
