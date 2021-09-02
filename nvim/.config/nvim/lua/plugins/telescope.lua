local actions = require('telescope.actions')

require('telescope').setup({
	defaults = {
		layout_config = {
			horizontal = {
				prompt_position = 'top',
			},
		},
		sorting_strategy = 'ascending',
		mappings = {
			-- insert mode
			i = {
				['<esc>'] = actions.close,
			},
			-- normal mode
			n = {
				['<esc>'] = actions.close,
			},
		},
		color_devicons = true,
		set_env = { ['COLORTERM'] = 'truecolor' },
		pickers = {
			buffers = {
				ignore_current_buffer = true,
				sort_mru = true,
				-- selection_strategy = 'closest',
			},
		},
	},
})
-- require("telescope").load_extension("fzy_native")
require('telescope').load_extension('fzf_writer')
