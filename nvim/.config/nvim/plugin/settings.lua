vim.o.completeopt = 'menuone,noselect'
vim.o.expandtab = true
vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = [[nvim_treesitter#foldexpr()]]
vim.o.foldnestmax = 10
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.inccommand = 'nosplit'
vim.o.lazyredraw = true
vim.o.linebreak = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.scrolloff = 10
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.updatetime = 300
vim.o.shell = 'bash'
vim.o.timeoutlen = 500
vim.o.breakindent = true
vim.o.breakindentopt = 'shift:2'
vim.o.showbreak = '↳'

vim.g.python3_host_prog = '/usr/local/bin/python3'

-- https://github.com/mhinz/neovim-remote
if vim.fn.executable('nvr') then
	vim.cmd([[ let $GIT_EDITOR = 'nvr -cc split --remote-wait' ]])
	vim.cmd(
		[[autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete]]
	)
end

vim.g.mapleader = ' '

local disabled_built_ins = {
	'netrw',
	'netrwPlugin',
	'netrwSettings',
	'netrwFileHandlers',
	'gzip',
	'zip',
	'zipPlugin',
	'tar',
	'tarPlugin',
	'getscript',
	'getscriptPlugin',
	'vimball',
	'vimballPlugin',
	'2html_plugin',
	'logipat',
	'rrhelper',
	'spellfile_plugin',
	'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g['loaded_' .. plugin] = 1
end
