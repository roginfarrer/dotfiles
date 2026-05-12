return {
	{
		'folke/trouble.nvim',
		cmd = { 'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh' },
		opts = function()
			if require('util').has 'fzf-lua' then
				local config = require 'fzf-lua.config'
				local actions = require('trouble.sources.fzf').actions
				config.defaults.actions.files['ctrl-t'] = actions.open
			end
			return {
				use_diagnostic_signs = true,
				{
					modes = {
						test = {
							mode = 'diagnostics',
							preview = {
								type = 'split',
								relative = 'win',
								position = 'right',
								size = 0.3,
							},
						},
					},
				},
			}
		end,
		keys = {
			{ '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
			{ '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
			{ '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
			{ '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
			{
				'[q',
				function()
					if require('trouble').is_open() then
						require('trouble').previous { skip_groups = true, jump = true }
					else
						vim.cmd.cprev()
					end
				end,
				desc = 'Previous trouble/quickfix item',
			},
			{
				']q',
				function()
					if require('trouble').is_open() then
						require('trouble').next { skip_groups = true, jump = true }
					else
						vim.cmd.cnext()
					end
				end,
				desc = 'Next trouble/quickfix item',
			},
		},
	},
}
