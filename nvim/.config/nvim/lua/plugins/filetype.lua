return {
	-- { 'mustache/vim-mustache-handlebars', ft = 'mustache' },
	{ 'jxnblk/vim-mdx-js', enabled = false, ft = 'mdx' },
	{ 'fladson/vim-kitty', ft = 'kitty' },
	{ 'Amar1729/skhd-vim-syntax', ft = 'skhd' },
	{ 'camnw/lf-vim', ft = 'lf' },
	{
		'nvim-neorg/neorg',
		enabled = false,
		ft = 'norg',
		cmd = { 'Neorg' },
		build = ':Neorg sync-parsers', -- This is the important bit!
		opts = {
			-- Tell Neorg what modules to load
			load = {
				['core.defaults'] = {}, -- Load all the default modules
				['core.concealer'] = {}, -- Allows for use of icons
				['core.dirman'] = { -- Manage your directories with Neorg
					config = {
						workspaces = {
							main = '~/Dropbox (Maestral)/neorg',
						},
					},
				},
				['core.journal'] = {
					config = {
						workspace = 'main',
					},
				},
				['core.completion'] = {
					config = {
						engine = 'nvim-cmp',
					},
				},
			},
		},
	},
}
