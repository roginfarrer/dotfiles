vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local o = vim.o

vim.cmd 'setlocal conceallevel=2'
o.autowrite = true
o.breakindent = true
o.breakindentopt = 'shift:2'
-- o.cmdheight = 0
o.completeopt = 'menuone,noselect,noinsert'
o.confirm = true
-- o.cursorline = true
o.exrc = true
o.expandtab = true
o.formatoptions = 'jcroqlnt' -- tcqj
o.formatexpr = "v:lua.require'conform'.formatexpr({'timeout_ms': 2000})"
o.hidden = true
o.hlsearch = false
o.ignorecase = true
o.inccommand = 'nosplit'
o.laststatus = 3
o.linebreak = true
o.mouse = 'a'
o.number = true
o.pumblend = 10
o.pumheight = 10
o.relativenumber = true
o.ruler = false
o.scrolloff = 5
o.shell = 'fish'
o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'
o.shiftwidth = 4
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
-- o.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
-- o.suffixesadd = o.suffixesadd .. '.js,.ts,.tsx,.jsx'
o.swapfile = false
o.tabstop = 4
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

vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = false,
  -- For lsp_lines
  virtual_lines = false,
  float = {
    filetype = 'markdown',
    focusable = true,
    border = { '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏' },
    format = function(diagnostic)
      if diagnostic.source == 'eslint' then
        return string.format(
          '%s [%s]',
          diagnostic.message,
          -- shows the name of the rule
          diagnostic.user_data.lsp.code
        )
      end
      return string.format('%s [%s]', diagnostic.message, diagnostic.source)
    end,
    severity_sort = true,
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
    max_width = 80,
  },
}

if require('jit').arch == 'arm64' then
  vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
  vim.g.python_host_prog = '/opt/homebrew/bin/python'
else
  vim.g.python3_host_prog = '/usr/local/bin/python3'
  vim.g.python_host_prog = '/usr/bin/python'
end

-- https://github.com/wez/wezterm/issues/4607
if vim.env.TERM_PROGRAM == 'WezTerm' and not vim.env.TMUX then
  o.termsync = false
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

if os.getenv 'SSH_CLIENT' ~= nil or os.getenv 'SSH_TTY' ~= nil then
  local function paste()
    return {
      vim.split(vim.fn.getreg '', '\n'),
      vim.fn.getregtype '',
    }
  end
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    },
  }
end
