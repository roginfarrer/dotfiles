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
map { '<leader>y', '"+y', desc = 'Yank to clipboard', mode = { 'n', 'x', 'v' } }
map { '<leader>Y', '"+Y', desc = 'Yank to clipboard', mode = { 'n', 'x', 'v' } }
map { '<leader>P', '"+P', desc = 'Paste from clipboard', mode = { 'n', 'x', 'v' } }
map { '<leader>p', '"+P', desc = 'Paste from clipboard', mode = { 'n', 'x', 'v' } }

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

-- diagnostic
local diagnostic_goto = function(next, severity)
	return function()
		vim.diagnostic.jump {
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		}
	end
end
map { ']d', diagnostic_goto(true), desc = 'Next Diagnostic' }
map { '[d', diagnostic_goto(false), desc = 'Prev Diagnostic' }
map { ']e', diagnostic_goto(true, 'ERROR'), desc = 'Next Error' }
map { '[e', diagnostic_goto(false, 'ERROR'), desc = 'Prev Error' }
map { ']w', diagnostic_goto(true, 'WARN'), desc = 'Next Warning' }
map { '[w', diagnostic_goto(false, 'WARN'), desc = 'Prev Warning' }

-- git conflicts
map {
	'<leader>gq',
	function()
		vim.cmd 'cexpr system("git diff --check --relative")'
		vim.cmd 'copen'
	end,
	desc = 'Git conflicts to quickfix',
}
