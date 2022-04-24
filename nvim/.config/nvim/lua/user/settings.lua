local o = vim.o

o.breakindent = true
o.breakindentopt = 'shift:2'
o.completeopt = 'menuone,noselect,noinsert'
o.expandtab = true
o.foldexpr = [[nvim_treesitter#foldexpr()]]
o.foldlevel = 99
o.foldmethod = 'expr'
o.foldnestmax = 10
o.hidden = true
o.hlsearch = false
o.ignorecase = true
o.inccommand = 'nosplit'
o.laststatus = 3
o.lazyredraw = true
o.linebreak = true
o.mouse = 'a'
o.number = true
o.pumblend = 10
o.scrolloff = 10
o.shell = 'zsh'
o.shiftwidth = 2
o.showbreak = '↳ '
o.showcmd = false
o.showmode = false
o.sidescroll = 5
o.sidescrolloff = 15
o.signcolumn = 'yes'
o.smartcase = true
o.smartindent = true
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.guifont = 'MonoLisa Nerd Font:h16'
o.timeoutlen = 500
o.undofile = true
o.updatetime = 250
o.wildmode = 'longest,full'
vim.cmd [[set path+=**]]
if vim.fn.executable 'rg' then
  o.grepprg = 'rg --vimgrep'
  o.grepformat = '%f:%l:%c:%m'
end

-- vim.g.python3_host_prog = '/usr/local/bin/python3'
-- vim.g.python_host_prog = '/usr/bin/python'

-- https://github.com/mhinz/neovim-remote
if vim.fn.executable 'nvr' then
  vim.cmd [[ let $GIT_EDITOR = 'nvr -cc split --remote-wait' ]]
  vim.cmd [[autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete]]
end
