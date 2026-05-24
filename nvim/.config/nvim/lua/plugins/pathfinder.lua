return {
	{
		'HawkinsT/pathfinder.nvim',
		opts = {
			remap_default_keys = false,
			tmux_mode = true,
		},
		init = function()
			vim.api.nvim_create_autocmd('FileType', {
				pattern = { 'scss', 'sass' },
				callback = function()
					local bufdir = vim.fn.expand '%:p:h'
					local nm = vim.fs.find('node_modules', { upward = true, path = bufdir, type = 'directory' })[1]
					if nm then
						vim.opt_local.path:append(nm .. '/**')
					end
				end,
			})
		end,
		keys = {
			{
				'gx',
				function()
					require('pathfinder').gx()
				end,
			},
			{
				'gf',
				function()
					require('pathfinder').gf()
				end,
			},
			{
				'gF',
				function()
					require('pathfinder').gF()
				end,
				desc = 'Go to file under cursor (with line #)',
			},
		},
	},
}
