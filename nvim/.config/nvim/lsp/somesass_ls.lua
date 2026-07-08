return {
	name = 'somesass_ls',
	cmd = { 'mise', 'exec', 'node@24', '--', 'some-sass-language-server', '--stdio' },
	filetypes = { 'sass', 'scss', 'css' },
	root_markers = { '.git', 'package.json' },
	settings = {
		somesass = {
			suggestAllFromOpenDocument = true,
			scss = {
				completion = {
					-- suggestFromUseOnly = true,
					-- mixinStyle = 'bracket',
				},
			},
		},
		--  Optional, if you get suggestions from the current document after namespace.$ (you don't need to type the $ for narrowing down suggestions)
		editor = { wordBasedSuggestions = false },
	},
}
