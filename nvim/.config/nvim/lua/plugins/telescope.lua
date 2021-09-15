local actions = require('telescope.actions')

require('telescope').setup({
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--hidden',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
		},
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
	},
	pickers = {
		buffers = {
			ignore_current_buffer = true,
			sort_mru = true,
		},
	},
})

require('project_nvim').setup({})
require('telescope').load_extension('fzf_writer')
require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')
