local o = vim.o

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

o.breakindent = true
o.breakindentopt = 'shift:2'
o.cmdheight = 0
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
o.linebreak = true
o.mouse = 'a'
o.number = true
o.pumblend = 10
o.relativenumber = true
o.scrolloff = 5
o.shell = 'zsh'
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
o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.guifont = 'MonoLisa:h16'
o.timeoutlen = 500
o.undofile = true
o.updatetime = 250
o.wildmode = 'longest,full'
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

if vim.g.started_by_firenvim then
  o.guifont = 'Monolisa Nerd Font:h13'
  o.laststatus = 0
  map('n', 'K', function() end)
end

vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.5

local default_plugins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
  -- "python3_provider",
  -- "python_provider",
  -- "node_provider",
  'ruby_provider',
  'perl_provider',
  'tutor',
  'rplugin',
  'syntax',
  'synmenu',
  'optwin',
  'compiler',
  'bugreport',
  'ftplugin',
}

-- for _, plugin in pairs(default_plugins) do
--   vim.g['loaded_' .. plugin] = 1
-- end
