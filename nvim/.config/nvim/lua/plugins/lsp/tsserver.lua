local ts_utils = require('nvim-lsp-ts-utils')

local ts_utils_settings = {
	-- debug = true,
	enable_import_on_completion = true,
	complete_parens = true,
	signature_help_in_parens = true,
	update_imports_on_move = true,
	-- eslint
	eslint_bin = 'eslint_d',
	eslint_enable_diagnostics = true,
	eslint_show_rule_id = true,
	eslint_disable_if_no_config = true,
	-- formatting
	formatter = 'prettierd',
	enable_formatting = false,
}

local M = function(on_attach)
	return {
		-- cmd = cmd,
		on_attach = function(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			on_attach(client)

			ts_utils.setup(ts_utils_settings)
			ts_utils.setup_client(client)

			-- u.buf_map("n", "gs", ":TSLspOrganize<CR>", nil, bufnr)
			-- u.buf_map("n", "gI", ":TSLspRenameFile<CR>", nil, bufnr)
			-- u.buf_map("n", "gt", ":TSLspImportAll<CR>", nil, bufnr)
			-- u.buf_map("n", "qq", ":TSLspFixCurrent<CR>", nil, bufnr)
			-- u.buf_map("i", ".", ".<C-x><C-o>", nil, bufnr)

			vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
		end,
	}
end

return M
