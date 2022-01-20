local actions = require 'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require 'lir.clipboard.actions'
local utils = require 'lir.utils'

map('n', '-', function()
  if vim.fn.expand '%' == '' then
    vim.fn.execute [[edit .]]
  else
    vim.fn.execute [[edit %:h]]
  end
end)

-- https://github.com/tamago324/lir.nvim/wiki/Custom-actions#input_newfile
local no_confirm_patterns = {
  '^LICENSE$',
  '^Makefile$',
}

local need_confirm = function(filename)
  for _, pattern in ipairs(no_confirm_patterns) do
    if filename:match(pattern) then
      return false
    end
  end
  return true
end

local function input_newfile()
  local save_curdir = vim.fn.getcwd()
  -- lcd(lir.get_context().dir)
  vim.cmd(string.format(':lcd %s', lir.get_context().dir))
  local name = vim.fn.input('New file: ', '', 'file')
  vim.cmd(string.format(':lcd %s', save_curdir))
  -- lcd(save_curdir)

  if name == '' then
    return
  end

  if name == '.' or name == '..' then
    utils.error('Invalid file name: ' .. name)
    return
  end

  -- If I need to check, I will.
  if need_confirm(name) then
    -- '.' is not included or '/' is not included, then
    -- I may have entered it as a directory, I'll check.
    if not name:match '%.' and not name:match '/' then
      if vim.fn.confirm('Directory?', '&No\n&Yes', 1) == 2 then
        name = name .. '/'
      end
    end
  end

  local path = require('plenary.path'):new(lir.get_context().dir .. name)
  if string.match(name, '/$') then
    -- mkdir
    name = name:gsub('/$', '')
    path:mkdir {
      parents = true,
      mode = tonumber('700', 8),
      exists_ok = false,
    }
  else
    -- touch
    path:touch {
      parents = true,
      mode = tonumber('644', 8),
    }
  end

  -- If the first character is '.' and show_hidden_files is false, set it to true
  if name:match [[^%.]] and not lir.config.values.show_hidden_files then
    lir.config.values.show_hidden_files = true
  end

  actions.reload()

  -- Jump to a line in the parent directory of the file you created.
  local lnum = lir.get_context():indexof(name:match '^[^/]+')
  if lnum then
    vim.cmd(tostring(lnum))
  end
end

lir.setup {
  show_hidden_files = true,
  devicons_enable = true,
  mappings = {
    ['<CR>'] = actions.edit,
    ['l'] = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,
    ['h'] = actions.up,
    ['-'] = actions.up,
    ['q'] = actions.quit,
    -- ['I'] = actions.mkdir,
    -- ['i'] = actions.newfile,
    ['a'] = input_newfile,
    ['r'] = actions.rename,
    ['@'] = actions.cd,
    ['yf'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,
    ['d'] = actions.delete,
    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd 'normal! j'
    end,
    ['c'] = clipboard_actions.copy,
    ['x'] = clipboard_actions.cut,
    ['p'] = clipboard_actions.paste,
  },
  hide_cursor = true,
}

require('lir.git_status').setup {
  show_ignored = false,
}

-- use visual mode
function _G.LirSettings()
  map(
    'x',
    'J',
    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
    { buffer = true, silent = true }
  )

  -- echo cwd
  vim.api.nvim_echo({ { vim.fn.expand '%:p', 'Normal' } }, false, {})
end

vim.cmd [[augroup lir-settings]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd Filetype lir :lua LirSettings()]]
vim.cmd [[augroup END]]
