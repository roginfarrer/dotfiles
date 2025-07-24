return {
	{
		'echasnovski/mini.icons',
		lazy = true,
		version = false,
		config = function(_, opts)
			require('mini.icons').setup(opts)
			MiniIcons.mock_nvim_web_devicons()
		end,
		specs = {
			{
				'saghen/blink.cmp',
				opts = function(_, opts)
					return vim.tbl_deep_extend('force', opts or {}, {
						completion = {
							menu = {
								draw = {
									components = {
										kind_icon = {
											ellipsis = false,
											text = function(ctx)
												local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
												return kind_icon
											end,
											-- Optionally, you may also use the highlights from mini.icons
											highlight = function(ctx)
												local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
												return hl
											end,
										},
									},
								},
							},
						},
					})
				end,
			},
		},
	},
}
