return {
	{
		'nvim-mini/mini.notify',
		enabled = false,
		version = false,
		opts = {},
		event = 'VeryLazy',
	},

	{
		'nvim-mini/mini.splitjoin',
		version = false,
		opts = {
			mappings = {
				toggle = 'J',
			},
		},
		keys = { 'J' },
	},

	{
		'nvim-mini/mini.visits',
		version = false,
		opts = {},
		keys = function()
			local map_branch = function(keys, action, desc)
				local rhs = function()
					local branch = vim.fn.system 'git rev-parse --abbrev-ref HEAD'
					if vim.v.shell_error ~= 0 then
						return nil
					end
					branch = vim.trim(branch)
					require('mini.visits')[action](branch)
				end
				return { keys, rhs, desc = desc }
			end

			return {
				map_branch('<leader>vb', 'add_label', 'Add branch label'),
				map_branch('<leader>vB', 'remove_label', 'Remove branch label'),
				{
					'<leader>vF',
					function()
						local branch = vim.fn.system 'git rev-parse --abbrev-ref HEAD'
						if vim.v.shell_error ~= 0 then
							return nil
						end
						branch = vim.trim(branch)
						MiniVisits.select_path(vim.fn.getcwd(), { filter = branch })
					end,
					desc = 'Visits branch menu',
				},
				{ '<leader>vv', '<Cmd>lua MiniVisits.add_label("core")<CR>', desc = 'Add "core" label' },
				{ '<leader>vV', '<Cmd>lua MiniVisits.remove_label("core")<CR>', desc = 'Remove "core" label' },
				{ '<leader>vl', '<Cmd>lua MiniVisits.add_label()<CR>', desc = 'Add label' },
				{ '<leader>vL', '<Cmd>lua MiniVisits.remove_label()<CR>', desc = 'Remove label' },
				{
					'<leader>vc',
					'<Cmd>lua MiniVisits.select_path("")<CR>',
					desc = 'Visits fzf menu',
				},
			}
		end,
	},
}
