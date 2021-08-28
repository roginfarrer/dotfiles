local function lsp_progress()
	local messages = vim.lsp.util.get_progress_messages()
	if #messages == 0 then
		return
	end
	local status = {}
	for _, msg in pairs(messages) do
		table.insert(status, (msg.percentage or 0) .. '%% ' .. (msg.title or ''))
	end
	local spinners = {
		'⠋',
		'⠙',
		'⠹',
		'⠸',
		'⠼',
		'⠴',
		'⠦',
		'⠧',
		'⠇',
		'⠏',
	}
	local ms = vim.loop.hrtime() / 1000000
	local frame = math.floor(ms / 120) % #spinners
	return table.concat(status, ' | ') .. ' ' .. spinners[frame + 1]
end

require('lualine').setup({
	options = {
		theme = 'tokyonight',
		section_separators = { '', '' },
		-- component_separators = { '', '' },
		component_separators = { '', '' },
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = {
			'branch',
			'diff',
			{ 'diagnostics', sources = { 'nvim_lsp', 'coc' } },
		},
		lualine_c = { 'filename' },
		lualine_x = { lsp_progress },
		lualine_y = { 'filetype' },
		lualine_z = { 'progress' },
	},
})
