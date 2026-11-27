vim.pack.add { 'https://github.com/nvim-mini/mini.surround' }

require('mini.surround').setup {
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
}
