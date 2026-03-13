return {
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'mdx' },
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
		tsserver = { globalPlugins = {} },
	},
	before_init = function(params, config)
		local plugins = { '@mdx-js/typescript-plugin', 'ts-lit-plugin' }
		for index, plugin in ipairs(plugins) do
			local result = vim.system({ 'npm', 'list', '-g', plugin }):wait()
			if result.stdout:find(plugin, nil, true) ~= nil then
				local location = result.stdout:match '([^\r\n]*)'
				table.insert(config.settings.tsserver.globalPlugins, {
					name = plugin,
					location = location .. '/node_modules/' .. plugin,
					languages = { 'mdx', 'typescript' },
					configNamespace = 'typescript',
					enableForWorkspaceTypeScriptVersions = true,
				})
			end
		end
	end,
}
