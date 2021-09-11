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
			'diff',
		},
		lualine_c = { 'filename' },
		lualine_x = {
			{ 'diagnostics', sources = { 'nvim_lsp', 'coc' } },
		},
		lualine_y = { 'filetype' },
		lualine_z = { 'progress' },
	},
}

-- if isPackageLoaded('coc.nvim') then
-- 	-- config.sections.lualine_x = {"diagnostics", source = {"coc"}}
-- 	config.sections.lualine_x = { 'g:coc_status' }
-- end

require('lualine').setup(config)
