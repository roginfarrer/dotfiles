return {
	settings = {
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			experimental = {
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
		javascript = {
			format = {
				enable = false,
			},
		},
		typescript = {
			format = {
				enable = false,
			},
			suggest = {
				completeFunctionCalls = true,
			},
			tsserver = {
				maxTsServerMemory = 8192,
			},
		},
	},
}
