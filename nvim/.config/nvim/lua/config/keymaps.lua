local map = require('util').keymap

-- If you like long lines with line wrapping enabled, this solves the problem
-- that pressing down jumpes your cursor “over” the current line to the next
-- line. It changes behaviour so that it jumps to the next row in the editor
-- (much more natural)
-- Display line movements unless preceded by a count whilst also recording jump points for movements larger than five lines
map { 'j', "v:count == 0 ? 'gj' : 'j'", 'Down', expr = true, mode = { 'n', 'x' } }
map { 'k', "v:count == 0 ? 'gk' : 'k'", 'Up', expr = true, mode = { 'n', 'x' } }

-- Improve line jumping
map { '$', 'g$', desc = 'Jump to the end of the line' }
map { '0', 'g^', desc = 'Jump to the beginning of the line' }

-- Don't save to register when "changing"
map { 'c', '"_c', mode = { 'n', 'v' } }
map { 'C', '"_C', mode = { 'n', 'v' } }

-- Buffers
map { '<S-h>', '<cmd>bprevious<cr>', desc = 'Prev buffer' }
map { '<S-l>', '<cmd>bnext<cr>', desc = 'Next buffer' }
map { '[b', '<cmd>bprevious<cr>', desc = 'Prev buffer' }
map { ']b', '<cmd>bnext<cr>', desc = 'Next buffer' }

-- tabs
map { '<leader><tab>l', '<cmd>tablast<cr>', desc = 'Last Tab' }
map { '<leader><tab>f', '<cmd>tabfirst<cr>', desc = 'First Tab' }
map { '<leader><tab><tab>', '<cmd>tabnew<cr>', desc = 'New Tab' }
map { '<leader><tab>]', '<cmd>tabnext<cr>', desc = 'Next Tab' }
map { '<leader><tab>d', '<cmd>tabclose<cr>', desc = 'Close Tab' }
map { '<leader><tab>[', '<cmd>tabprevious<cr>', desc = 'Previous Tab' }

-- Add undo break-points
-- map { ',', ',<c-g>u', mode = 'i' }
-- map { '.', '.<c-g>u', mode = 'i' }
-- map { ';', ';<c-g>u', mode = 'i' }

-- Terminal
map { '<leader><esc>', [[<C-\><C-n>]], desc = 'Enter normal mode', mode = 't' }

-- Misc QOL
map { '<space><space>', 'za', desc = 'Toggle fold' }
map { '<BS>', '<C-^>', desc = 'Previous buffer' }
map { 'gw', '*N', desc = 'Search word under cursor', mode = { 'n', 'x' } }

map {
	'<leader>yf',
	':let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>',
	desc = 'Copy file path to clipboard',
}
-- Clipboard yanking and pasting
map { '<leader>y', '"+y', desc = 'Yank to clipboard' }
map { '<leader>Y', '"+Y', desc = 'Yank to clipboard' }
-- map { '<leader>yp', '"+p', desc = 'Put from clipboard' }
-- map { '<leader>yP', '"+P', desc = 'Put from clipboard' }
map { '<leader>yp', '"_dP', mode = 'x' }
-- map { 'yp', '"0p', desc = 'Paste from yank register', mode = { 'n', 'v' } }
-- map { 'yP', '"0P', desc = 'Paste from yank register', mode = { 'n', 'v' } }

map { '<leader>q', ':q<CR>', desc = 'Quit' }
map { '<leader>w', ':w<CR>', desc = 'Save' }

-- Don't save empty lines to register
map {
	'dd',
	function()
		if vim.api.nvim_get_current_line():match '^%s*$' then
			return '"_dd'
		else
			return 'dd'
		end
	end,
	expr = true,
}
