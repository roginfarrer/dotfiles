return {
	{
		"stevearc/conform.nvim",
		optional = true,
		config = function(_, opts)
			opts.formatters_by_ft.json = { "fracjson" }
			opts.formatters_by_ft.jsonc = { "fracjson" }
			opts.formatters_by_ft.json5 = { "fracjson" }
			require("conform").setup(opts)
		end,
	},
}
