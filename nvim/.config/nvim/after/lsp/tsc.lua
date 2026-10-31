return {
	settings = {
		['js/ts'] = {
			tsserver = {
				maxMemory = 8192,
				watchOptions = {
					watchFile = 'useFsEventsOnParentDirectory',
				},
			},
			tsdk = {
				promptToUseWorkspaceVersion = true,
				path = 'node_modules/typescript/lib',
			},
		},
	},
}
