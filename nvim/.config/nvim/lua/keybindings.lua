local vimp = require('vimp')

local nnoremap = vimp.nnoremap
local nmap = vimp.nmap
local vnoremap = vimp.vnoremap
local xnoremap = vimp.xnoremap
local tnoremap = vimp.tnoremap

nmap('<C-c>', '"+y')
nnoremap('<Leader>y', '"+y')
xnoremap('<Leader>y', '"+y')
nnoremap('<Leader>p', '"+p')
xnoremap('<Leader>p', '"+p')
nnoremap('<Leader>P', '"+P')
xnoremap('<Leader>P', '"+P')

-- Make Y behave like it should
nmap('Y', 'y$')

-- When changing, don't save to register
nnoremap('c', '"_c')
vnoremap('c', '"_c')

nmap('<C-j>', '<C-W>j')
nmap('<C-k>', '<C-W>k')
nmap('<C-h>', '<C-W>h')
nmap('<C-l>', '<C-W>l')

-- nmap('<leader>w', [[:w!<CR>]])
-- nmap('<leader>q', [[:q<CR>]])
-- nmap('<leader>x', [[:wq<CR>]])

-- newline without insert
nmap('<CR>', 'o<Esc>"_cc<Esc>')

-- If you like long lines with line wrapping enabled, this solves the problem that pressing down jumpes your cursor “over” the current line to the next line. It changes behaviour so that it jumps to the next row in the editor (much more natural)
nnoremap('j', 'gj')
nnoremap('k', 'gk')

nmap('0', '^')

nnoremap('<A-k>', [[:m .-2<CR>==]])
nnoremap('<A-j>', [[:m .+1<CR>==]])
vnoremap('<A-j>', [[:m '>+1<CR>gv=gv]])
vnoremap('<A-k>', [[:m '<-2<CR>gv=gv]])

-- Toggle folds
-- nnoremap('<Space><Space>', 'za')

-- nnoremap('<leader>ek', [[:vsp $HOME/.config/kitty/kitty.conf<CR>]])
-- nnoremap('<leader>ev', [[:vsp $HOME/.config/nvim/init.lua<CR>]])

-- nnoremap({"silent"}, "<leader>go", [[:GBrowse<CR>]])
-- vnoremap({"silent"}, "<leader>go", [[:'<,'>GBrowse<CR>]])
-- nnoremap({"silent"}, "<leader>gc", [[:GBrowse!<CR>]])
-- vnoremap({"silent"}, "<leader>gc", [[:'<,'>GBrowse!<CR>]])
-- vimp complains about duplicate mapping
vim.api.nvim_set_keymap(
	'n',
	'<leader>yf',
	[[:let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>]],
	{ noremap = true }
)

nmap('gx', '<Plug>(open-url-browser)')
-- nmap('<leader>gs', [[:G<CR>]])

-- TERMINAL --
-- To map <Esc> to exit terminal-mode: >
tnoremap('<leader><Esc>', [[<C-\><C-n>]])
tnoremap('<leader>j', [[<C-\><C-n>]])

-- Open a new split with a terminal
-- nnoremap('<leader>te', [[:vs<CR>:terminal fish<CR>]])

-- a paste from register chord
tnoremap({ 'expr' }, '<A-r>', [['<C-/>']])
