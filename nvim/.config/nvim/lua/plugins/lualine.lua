local function lsp_status()
	if #vim.lsp.buf_get_clients() then
		return require('lsp-status').status_progress()
	end
	return ''
end

-- https://vi.stackexchange.com/a/12294
local function getHighlightTerm(group, term)
	local output = vim.fn.execute('hi ' .. group)
	return vim.fn.matchstr(output, term .. '=\\zs\\S*')
end

local diffAddFg = getHighlightTerm('LspSagaRenameBorder', 'guifg')
local diffChangeFg = getHighlightTerm('LspDiagnosticsHint', 'guifg')
local diffDeleteFg = getHighlightTerm('LspDiagnosticsError', 'guifg')

local function lsp_client_names()
	local msg = 'no active lsp'

	if #vim.lsp.buf_get_clients() then
		local clients = {}
		for _, client in pairs(vim.lsp.buf_get_clients()) do
			table.insert(clients, client.name)
		end

		if next(clients) == nil then
			return msg
		end

		-- local bufnr = vim.api.nvim_get_current_buf()
		-- local count = vim.lsp.diagnostic.get_count(bufnr, 'Error')
		-- count = count + vim.lsp.diagnostic.get_count(bufnr, 'Warning')
		-- count = count + vim.lsp.diagnostic.get_count(bufnr, 'Info')
		-- count = count + vim.lsp.diagnostic.get_count(bufnr, 'Hint')

		-- if count == 0 then
		return ' LSP: ' .. table.concat(clients, ',')
		-- else
		-- 	return ''
		-- end
	end

	return msg
end

local config = {
	options = {
		theme = 'nightfox',
		-- theme = 'tokyonight',
		section_separators = { '', '' },
		-- component_separators = { '', '' },
		component_separators = { '', '' },
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = {
			'branch',
			{
				'diff',
				color_added = { fg = diffAddFg },
				color_removed = { fg = diffDeleteFg },
				color_modified = { fg = diffChangeFg },
			},
		},
		lualine_c = { { 'filename', file_status = true } },
		lualine_x = {
			lsp_status,
			{ 'diagnostics', sources = { 'nvim_lsp', 'coc' } },
		},
		lualine_y = { 'filetype' },
		lualine_z = { lsp_client_names },
	},
}

require('lualine').setup(config)
