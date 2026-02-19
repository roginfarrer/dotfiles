return {
	cmd = { vim.fn.expand '$HOME' .. '/development/ts-bridge/target/release/ts-bridge' },
	filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
	root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
	settings = {
		['ts-bridge'] = {
			separate_diagnostic_server = true, -- launch syntax + semantic tsserver
			publish_diagnostic_on = 'insert_leave',
			enable_inlay_hints = true,
			tsserver = {
				locale = nil,
				log_directory = nil,
				log_verbosity = nil,
				max_old_space_size = 8192,
				global_plugins = {},
				plugin_probe_dirs = {},
				extra_args = {},
				preferences = {},
				format_options = {},
			},
		},
	},
}
