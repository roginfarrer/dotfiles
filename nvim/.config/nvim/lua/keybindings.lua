local u = require('utils')

local nnoremap = u.nnoremap
local nmap = u.nmap
local vnoremap = u.vnoremap
local xnoremap = u.xnoremap
local tnoremap = u.tnoremap
local inoremap = u.inoremap

inoremap('<C-h>', '<Left>')
inoremap('<C-l>', '<Right>')

nmap('<C-c>', '"+y')
nnoremap('<Leader>y', '"+y')
xnoremap('<Leader>y', '"+y')
nnoremap('<Leader>p', '"+p')
xnoremap('<Leader>p', '"+p')
nnoremap('<Leader>P', '"+P')
xnoremap('<Leader>P', '"+P')

-- When changing, don't save to register
nnoremap('c', '"_c')
vnoremap('c', '"_c')

nmap('<C-j>', '<C-W>j')
nmap('<C-k>', '<C-W>k')
nmap('<C-h>', '<C-W>h')
nmap('<C-l>', '<C-W>l')

nmap('<leader>w', [[:w!<CR>]])
nmap('<leader>q', [[:q<CR>]])
nmap('<leader>x', [[:wq<CR>]])

-- newline without insert
nmap('<CR>', 'o<Esc>"_cc<Esc>')
nmap('<S-CR>', 'O<Esc>"_cc<Esc>')

-- If you like long lines with line wrapping enabled, this solves the problem that pressing down jumpes your cursor “over” the current line to the next line. It changes behaviour so that it jumps to the next row in the editor (much more natural)
nnoremap('j', 'gj')
nnoremap('k', 'gk')

nmap('0', '^')

nnoremap('<A-k>', [[:m .-2<CR>==]])
nnoremap('<A-j>', [[:m .+1<CR>==]])
vnoremap('<A-j>', [[:m '>+1<CR>gv=gv]])
vnoremap('<A-k>', [[:m '<-2<CR>gv=gv]])

nnoremap('<Space><Space>', ':e #<CR>')

nnoremap(
	'<leader>yf',
	[[:let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>]]
)

nmap('gx', '<Plug>(open-url-browser)')

-- TERMINAL --
-- To map <Esc> to exit terminal-mode: >
tnoremap('<leader><Esc>', [[<C-\><C-n>]])
tnoremap('<leader>j', [[<C-\><C-n>]])

-- Open a new split with a terminal
nnoremap('<leader>te', [[:vs<CR>:terminal fish<CR>]])

-- a paste from register chord
tnoremap('<A-r>', [['<C-/>']], { expr = true })
