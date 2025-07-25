return {
	{
		'echasnovski/mini.surround',
		version = '*',
		keys = function(_, keys)
			-- Populate the keys based on the user's options
			local plugin = require('lazy.core.config').spec.plugins['mini.surround']
			local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
			local mappings = {
				{ opts.mappings.add, desc = 'Add surrounding', mode = { 'n', 'v' } },
				{ opts.mappings.delete, desc = 'Delete surrounding' },
				{ opts.mappings.find, desc = 'Find right surrounding' },
				{ opts.mappings.find_left, desc = 'Find left surrounding' },
				{ opts.mappings.highlight, desc = 'Highlight surrounding' },
				{ opts.mappings.replace, desc = 'Replace surrounding' },
				{ opts.mappings.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
			}
			mappings = vim.tbl_filter(function(m)
				return m[1] and #m[1] > 0
			end, mappings)
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = 'gsa', -- Add surrounding in Normal and Visual modes
				delete = 'gsd', -- Delete surrounding
				find = 'gsf', -- Find surrounding (to the right)
				find_left = 'gsF', -- Find surrounding (to the left)
				highlight = 'gsh', -- Highlight surrounding
				replace = 'gsr', -- Replace surrounding
				update_n_lines = 'gsn', -- Update `n_lines`
				-- add = 'ys', -- Add surrounding in Normal and Visual modes
				-- delete = 'ds', -- Delete surrounding
				-- replace = 'cs', -- Replace surrounding
				-- find = 'ysf', -- Find surrounding (to the right)
				-- find_left = 'ysF', -- Find surrounding (to the left)
				-- highlight = 'ysh', -- Highlight surrounding
				-- update_n_lines = 'ysn', -- Update `n_lines`
			},
		},
		config = function(_, opts)
			require('mini.surround').setup(opts)
		end,
	},
}
