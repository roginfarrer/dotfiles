return {
	cmd = { 'mise', 'exec', 'node@24', '--', 'some-sass-language-server', '--stdio' },
	filetypes = { 'sass', 'scss', 'css' },
	root_markers = { '.git', 'package.json' },
	settings = {
		somesass = {
			scss = {
				completion = {
					suggestFromUseOnly = true,
					-- mixinStyle = 'bracket',
				},
			},
		},
	},
}
