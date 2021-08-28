-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local settings = {
	Lua = {
		-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
		runtime = {
			version = 'LuaJIT',
			-- Setup your lua path
			path = runtime_path,
		},
		diagnostics = {
			globals = {
				-- Get the language server to recognize the `vim` global
				'vim',
			},
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = vim.api.nvim_get_runtime_file('', true),
		},
		-- Do not send telemetry data containing a randomized but unique identifier
		telemetry = {
			enable = false,
		},
	},
}

local M = function(on_attach)
	return {
		on_attach = function(client, bufnr)
			on_attach(client)

			vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
		end,
		settings = settings,
	}
end

return M
