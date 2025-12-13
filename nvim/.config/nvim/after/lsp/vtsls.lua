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
			preferences = {
				importModuleSpecifierPreference = 'non-relative',
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
			preferences = {
				importModuleSpecifierPreference = 'non-relative',
				preferTypeOnlyAutoImports = true,
			},
		},
		-- tsserver = { globalPlugins = {} },
	},
	-- before_init = function(params, config)
	-- local result = vim.system({ 'npm', 'list', '-g', 'ts-scope-trimmer-plugin' }):wait()
	-- if result.stdout:find('ts-scope-trimmer-plugin', nil, true) ~= nil then
	-- 	local location = result.stdout:match '([^\r\n]*)'
	-- 	table.insert(config.settings.tsserver.globalPlugins, {
	-- 		name = 'ts-scope-trimmer-plugin',
	-- 		location = location .. '/node_modules/ts-scope-trimmer-plugin',
	-- 		languages = { 'javascript', 'typescript' },
	-- 		configNamespace = 'typescript',
	-- 		enableForWorkspaceTypeScriptVersions = true,
	-- 	})
	-- 	vim.print(config.settings.tsserver.globalPlugins)
	-- end
	-- end,
}
