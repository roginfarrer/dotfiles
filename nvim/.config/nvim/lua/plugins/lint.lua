return {
	{
		'mfussenegger/nvim-lint',
		event = 'BufReadPost',
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
		end,
	},
}
