local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

local conf = require('telescope.config').values

local vimp = require('vimp')

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

local M = {}

function M.search_dotfiles()
	builtin.find_files({
		-- cwd = "~/.local/share/chezmoi/",
		cwd = '~',
		find_command = {
			'git',
			'--git-dir',
			'/Users/rfarrer/.dotfiles/',
			'--work-tree',
			'/Users/rfarrer/',
			'ls-tree',
			'--full-tree',
			'-r',
			'--name-only',
			'HEAD',
		},
		prompt = '~ dotfiles ~',
	})
end

function M.search_config()
	builtin.find_files({
		shorten_path = true,
		cwd = '~/.config',
		prompt = '~ .config ~',
	})
end

function M.arglist(opts)
	opts = opts or {}
	local locations = vim.fn.argv()

	if vim.tbl_isempty(locations) then
		return
	end

	pickers.new(opts, {
		prompt_title = 'Quickfix',
		finder = finders.new_table(locations),
		previewer = conf.qflist_previewer(opts),
		sorter = conf.generic_sorter(opts),
	}):find()
end

vimp.nnoremap({ 'silent' }, '<Leader>fp', [[<cmd>Telescope git_files<CR>]])
vimp.nnoremap({ 'silent' }, '<Leader>f.', [[<cmd>Telescope find_files<CR>]])
vimp.nnoremap(
	{ 'silent' },
	'<Leader>fg',
	"<cmd> lua require('telescope').extensions.fzf_writer.staged_grep()<CR>"
)
vimp.nnoremap({ 'silent' }, '<leader>fb', [[<cmd>Telescope buffers<CR>]])
vimp.nnoremap({ 'silent' }, '<leader>fd', M.search_dotfiles)
vimp.nnoremap({ 'silent' }, '<leader>fa', M.arglist)
vimp.nnoremap({ 'silent' }, '<Leader>fh', [[<cmd>Telescope oldfiles<CR>]])

vimp.nnoremap({ 'silent' }, '<C-p>', [[<cmd>Telescope git_files<CR>]])
vimp.nnoremap({ 'silent' }, '<leader>;', [[<cmd>Telescope buffers<CR>]])

return setmetatable({}, {
	__index = function(_, k)
		if M[k] then
			return M[k]
		else
			return builtin[k]
		end
	end,
})
