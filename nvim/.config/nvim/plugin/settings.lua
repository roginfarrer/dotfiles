vim.o.breakindent = true
vim.o.breakindentopt = 'shift:2'
vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.expandtab = true
vim.o.foldexpr = [[nvim_treesitter#foldexpr()]]
vim.o.foldlevel = 99
-- vim.o.foldmethod = 'expr'
vim.o.foldmethod = 'syntax'
vim.o.foldnestmax = 10
vim.o.grepprg = 'rg --vimgrep --hidden --smart-case --glob !.git'
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.inccommand = 'nosplit'
vim.o.lazyredraw = true
vim.o.linebreak = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.pumblend = 10
vim.o.scrolloff = 10
vim.o.shell = 'zsh'
vim.o.shiftwidth = 2
vim.o.showbreak = '↳ '
vim.o.showcmd = false
vim.o.showmode = false
vim.o.sidescroll = 5
vim.o.sidescrolloff = 15
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.timeoutlen = 500
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.wildmode = 'longest,full'
vim.o.wildoptions = 'pum'

vim.g.python3_host_prog = '/usr/local/bin/python3'

-- https://github.com/mhinz/neovim-remote
if vim.fn.executable 'nvr' then
  vim.cmd [[ let $GIT_EDITOR = 'nvr -cc split --remote-wait' ]]
  vim.cmd [[autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete]]
end
