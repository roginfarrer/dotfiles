vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local o = vim.o

o.breakindent = true
o.breakindentopt = 'shift:2'
-- o.cmdheight = 0
o.completeopt = 'menuone,noselect,noinsert'
o.confirm = true
o.cursorline = true
o.exrc = true
o.expandtab = true
o.formatoptions = 'jcroqlnt' -- tcqj
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
-- o.foldexpr = [[nvim_treesitter#foldexpr()]]
-- o.foldlevel = 99
-- o.foldmethod = 'expr'
-- o.foldnestmax = 10
o.hidden = true
o.hlsearch = false
o.ignorecase = true
o.inccommand = 'nosplit'
o.laststatus = 0
o.linebreak = true
o.mouse = 'a'
o.number = true
o.pumblend = 10
o.pumheight = 10
o.relativenumber = true
o.scrolloff = 5
o.shell = 'fish'
o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'
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
o.splitkeep = 'screen'
o.splitright = true
-- o.suffixesadd = o.suffixesadd .. '.js,.ts,.tsx,.jsx'
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
-- o.guifont = 'MonoLisa:h16'
o.timeoutlen = 500
o.undofile = true
o.updatetime = 250
o.wildmode = 'longest,full'
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[ let &t_Ce = "\e[4:0m" ]]
vim.cmd [[set path+=**]]
if vim.fn.executable 'rg' then
  o.grepprg = 'rg --vimgrep'
  o.grepformat = '%f:%l:%c:%m'
end

if require('jit').arch == 'arm64' then
  vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
  vim.g.python_host_prog = '/opt/homebrew/bin/python'
else
  vim.g.python3_host_prog = '/usr/local/bin/python3'
  vim.g.python_host_prog = '/usr/bin/python'
end

-- if vim.g.started_by_firenvim then
--   o.guifont = 'Monolisa Nerd Font:h13'
--   o.laststatus = 0
--   map('n', 'K', function() end)
-- end

vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.5

if vim.fn.has 'nvim-0.9.0' == 1 then
  o.splitkeep = 'screen'
end
