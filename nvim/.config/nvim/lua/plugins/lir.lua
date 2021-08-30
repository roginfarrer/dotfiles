local actions = require('lir.actions')
local mark_actions = require('lir.mark.actions')
local clipboard_actions = require('lir.clipboard.actions')
local u = require('utils')

u.nnoremap('-', ':edit %:h<CR>')

require('lir').setup({
	show_hidden_files = false,
	devicons_enable = true,
	mappings = {
		['<CR>'] = actions.edit,
		['l'] = actions.edit,
		['<C-s>'] = actions.split,
		['<C-v>'] = actions.vsplit,
		['<C-t>'] = actions.tabedit,
		['h'] = actions.up,
		['-'] = actions.up,
		['q'] = actions.quit,
		['I'] = actions.mkdir,
		['i'] = actions.newfile,
		['r'] = actions.rename,
		['@'] = actions.cd,
		['yf'] = actions.yank_path,
		['.'] = actions.toggle_show_hidden,
		['d'] = actions.delete,
		['J'] = function()
			mark_actions.toggle_mark()
			vim.cmd('normal! j')
		end,
		['C'] = clipboard_actions.copy,
		['X'] = clipboard_actions.cut,
		['P'] = clipboard_actions.paste,
	},
	hide_cursor = true,
})

require('lir.git_status').setup({
	show_ignored = false,
})

-- use visual mode
function _G.LirSettings()
	u.xnoremap(
		'J',
		':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
		{ buffer = true, silent = true }
	)

	-- echo cwd
	vim.api.nvim_echo({ { vim.fn.expand('%:p'), 'Normal' } }, false, {})
end

vim.cmd([[augroup lir-settings]])
vim.cmd([[  autocmd!]])
vim.cmd([[  autocmd Filetype lir :lua LirSettings()]])
vim.cmd([[augroup END]])
