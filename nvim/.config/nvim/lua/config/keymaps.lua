local Util = require 'config.util'

local map = Util.map

-- If you like long lines with line wrapping enabled, this solves the problem
-- that pressing down jumpes your cursor “over” the current line to the next
-- line. It changes behaviour so that it jumps to the next row in the editor
-- (much more natural)
-- Display line movements unless preceded by a count whilst also recording jump points for movements larger than five lines
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Improve line jumping
map('n', '$', 'g$', { desc = 'Jump to the end of the line' })
map('n', '0', 'g^', { desc = 'Jump to the beginning of the line' })
map('i', '<C-b>', '<ESC>^i', { desc = 'Jump to the beginning of the line' })
map('i', '<C-e>', '<END>', { desc = 'Jump to the end of the line' })

-- Clipboard yanking and pasting
map('', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
map('', '<leader>Y', '"+Y', { desc = 'Yank to clipboard' })
map('n', '<leader>p', '"+p', { desc = 'Put from clipboard' })
map('n', '<leader>P', '"+P', { desc = 'Put from clipboard' })
map('x', '<leader>p', '"_dP')
map({ 'n', 'v' }, 'yp', '"0p', { desc = 'Paste from yank register' })
map({ 'n', 'v' }, 'yP', '"0P', { desc = 'Paste from yank register' })

-- Don't save to register when "changing"
map({ 'n', 'v' }, 'c', '"_c')
map({ 'n', 'v' }, 'C', '"_C')

-- Buffers
map('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
map('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })

-- tabs
map('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- Terminal
map('t', '<leader><esc>', [[<C-\><C-n>]], { desc = 'Enter normal mode' })

-- Misc QOL
map('n', '<space><space>', 'za', { desc = 'Toggle fold' })
map('n', '<BS>', '<C-^>', { desc = 'Previous buffer' })
map({ 'n', 'x' }, 'gw', '*N', { desc = 'Search word under cursor' })
map('n', 'gx', function()
  local path = vim.fn.expand '<cfile>'
  require('plenary.job'):new({ command = 'open', args = { path } }):start()
end, { desc = 'Open URL under cursor' })
map(
  'n',
  '<leader>yf',
  ':let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>',
  { desc = 'Copy file path to clipboard' }
)
map('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
map('n', '<leader>w', ':w<CR>', { desc = 'Save' })
-- Don't save empty lines to register
map('n', 'dd', function()
  if vim.api.nvim_get_current_line():match '^%s*$' then
    return '"_dd'
  else
    return 'dd'
  end
end, { expr = true })
