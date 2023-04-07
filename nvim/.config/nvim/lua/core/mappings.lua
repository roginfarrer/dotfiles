local wk = require 'which-key'

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

wk.setup {
  triggers = 'auto',
  plugins = {
    spelling = {
      enabled = true,
    },
  },
  key_labels = { ['<leader>'] = 'SPC', ['<tab>'] = 'TAB' },
}

-- If you like long lines with line wrapping enabled, this solves the problem
-- that pressing down jumpes your cursor “over” the current line to the next
-- line. It changes behaviour so that it jumps to the next row in the editor
-- (much more natural)
-- Display line movements unless preceded by a count whilst also recording jump points for movements larger than five lines
map('n', 'j', function()
  local count = vim.v.count
  if count > 0 then
    return count > 5 and t("m'" .. count .. 'j') or t 'j'
  end
  return t 'gj'
end, { expr = true })
map('n', 'k', function()
  local count = vim.v.count
  if count > 0 then
    return count > 5 and t("m'" .. count .. 'k') or t 'k'
  end
  return t 'gk'
end, { expr = true })
map('', '<leader>y', '"+y', { silent = false })
map('', '<leader>Y', '"+Y', { silent = false })

local general = {
  n = {
    -- When changing, don't save to register
    ['c'] = { '"_c' },
    ['C'] = { '"_C' },

    ['gx'] = {
      function()
        local path = vim.fn.expand '<cfile>'
        require('plenary.job'):new({ command = 'open', args = { path } }):start()
      end,
      'Open URL under cursor',
    },

    -- paste from yank register
    ['yp'] = { '"0p' },
    ['yP'] = { '"0P' },

    -- Put from system clipboard
    ['<leader>p'] = { '"+p' },
    ['<leader>P'] = { '"+P' },

    -- Copy path to clipboard
    ['<leader>yf'] = {
      ':let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>',
      'copy file path to clipboard',
    },

    ['<space><space>'] = { 'za', 'toggle fold' },
    ['<BS>'] = { '<C-^>', 'previous buffer' },
    ['$'] = { 'g$' },
    ['0'] = { 'g^' },

    -- Move entire lines up and down
    -- ['<A-k>'] = { ':m .-2<CR>==', ' move line up' },
    -- ['<A-j>'] = { ':m .+1<CR>==', ' move line up' },
  },

  i = {

    -- go to  beginning and end
    ['<C-b>'] = { '<ESC>^i', '論 beginning of line' },
    ['<C-e>'] = { '<End>', '壟 end of line' },

    -- navigate within insert mode
    -- ['<C-h>'] = { '<Left>', '  move left' },
    -- ['<C-l>'] = { '<Right>', ' move right' },
    -- ['<C-j>'] = { '<Down>', ' move down' },
    -- ['<C-k>'] = { '<Up>', ' move up' },
  },

  v = {

    -- paste from yank register
    ['yp'] = { '"0p' },
    ['yP'] = { '"0P' },

    -- Move entire lines up and down
    ['<A-k>'] = { [[:m '>+1<CR>gv=gv]], ' move line up' },
    ['<A-j>'] = { [[:m '<-2<CR>gv=gv]], ' move line up' },

    -- When changing, don't save to register
    ['c'] = { '"_c' },
    ['C'] = { '"_C' },
  },

  x = {
    ['<leader>p'] = { '"_dP' },
  },

  t = {
    ['<leader><esc>'] = { [[<C-\><C-n>]], 'esc' },
    ['jk'] = { [[<C-\><C-n>]], 'esc' },
  },
}

wk.register(general.n, { mode = 'n' })
wk.register(general.i, { mode = 'i' })
wk.register(general.v, { mode = 'v' })
wk.register(general.x, { mode = 'x' })
wk.register(general.t, { mode = 't' })

local leader = {
  y = 'Yank to clipboard',
  Y = 'Yank to clipboard',
  p = 'Paste from clipboard',
  P = 'Paste from clipboard',
  q = { ':q<cr>', 'Quit' },
  w = { ':w<CR>', 'Save' },
  x = { ':wq<cr>', 'Save and Quit' },
  g = {
    name = 'Git',
  },
  d = {
    name = 'Configuration',
    n = {
      ':e $MYVIMRC<CR>',
      'Open Neovim Config',
    },
    o = { '<cmd>Lazy<cr>', 'Open lazy ui' },
    l = {
      name = 'Local files',
      f = {
        '<cmd> e $HOME/.config/fish/local-config.fish<CR>',
        'Fish',
      },
      n = {
        ':e $HOME/.config/nvim/lua/local-config.lua<CR>',
        'Neovim',
      },
    },
    k = {
      ':e ~/dotfiles/kitty/.config/kitty/kitty.conf<CR>',
      'Open Kitty Config',
    },
    f = {
      ':e ~/dotfiles/fish/.config/fish/config.fish<CR>',
      'Open Fish Config',
    },
  },
  f = {
    name = 'Find',
  },
  ['<tab>'] = {
    name = 'Workspace',
    ['<tab>'] = { '<cmd>tabnew<CR>', 'New Tab' },
    n = { '<cmd>tabnext<CR>', 'Next' },
    d = { '<cmd>tabclose<CR>', 'Close' },
    p = { '<cmd>tabprevious<CR>', 'Previous' },
    [']'] = { '<cmd>tabnext<CR>', 'Next' },
    ['['] = { '<cmd>tabprevious<CR>', 'Previous' },
    f = { '<cmd>tabfirst<CR>', 'First' },
    l = { '<cmd>tablast<CR>', 'Last' },
  },
  H = {
    name = 'Help',
  },
  n = {
    name = 'Noice',
  },
  j = {
    name = 'Join/Split',
  },
}

wk.register(leader, { prefix = '<leader>' })

-- local textobjs = {
--   a = {
--     b = 'a code block (treesitter)',
--     f = 'a function block (treesitter)',
--     C = 'a conditional block (treesitter)',
--     c = 'a comment block (treesitter)',
--     s = 'a statement block (treesitter)',
--     m = 'a call block (treesitter)',
--   },
--   i = {
--     b = 'inside code block (treesitter)',
--     f = 'inside function block (treesitter)',
--     C = 'inside conditional block (treesitter)',
--     c = 'inside comment block (treesitter)',
--     s = 'inside statement block (treesitter)',
--     m = 'inside call block (treesitter)',
--   },
-- }
--
-- wk.register(textobjs, { mode = 'o' })
-- wk.register(textobjs, { mode = 'x' })

-- wk.register {
--   ['[d'] = 'Diagnostic Previous',
--   [']d'] = 'Diagnostic Next',
--   ['[q'] = 'Quickfix Previous',
--   [']q'] = 'Quickfix Next',
--   ['[Q'] = 'Quickfix First',
--   [']Q'] = 'Quickfix Last',
--   ['[l'] = 'Location List Previous',
--   [']l'] = 'Location List Next',
--   ['[L'] = 'Location List First',
--   [']L'] = 'Location List Last',
--   [']m'] = 'Go to beginning of next function',
--   [']]'] = 'Go to beginning of next class',
--   [']M'] = 'Go to end of next function',
--   [']['] = 'Go to end of next class',
--   ['[m'] = 'Go to beginning of previous function',
--   ['[['] = 'Go to end of previous class',
--   ['[M'] = 'Go to end of previous function',
--   ['[]'] = 'Go to end of previous class',
-- }

local function browse(opts)
  require('plenary.job'):new({ 'open', opts.args }):start()
end

vim.api.nvim_create_user_command('Browse', browse, { bang = true, range = true, nargs = 1 })

map('n', 'dd', function()
  if vim.api.nvim_get_current_line():match '^%s*$' then
    return '"_dd'
  else
    return 'dd'
  end
end, { expr = true })
