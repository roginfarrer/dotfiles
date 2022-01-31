local wk = require 'which-key'

wk.setup {
  triggers = 'auto',
  plugins = {
    spelling = {
      enabled = true,
    },
  },
  key_labels = { ['<leader>'] = 'SPC', ['<tab>'] = 'TAB' },
  -- operators = {
  --   d = 'Delete',
  --   c = 'Change',
  --   y = 'Yank',
  --   ['g~'] = 'Toggle case',
  --   ['gu'] = 'Lowercase',
  --   ['gU'] = 'Uppercase',
  --   v = 'Visual Character Mode',
  --   gc = 'Comment',
  --   gb = 'Line Comment',
  --   sa = 'Sandwich Add',
  --   sd = 'Sandwich Delete',
  --   sr = 'Sandwich Replace',
  -- },
}

local function searchDotfiles()
  require('telescope.builtin').live_grep {
    cwd = '~/dotfiles',
    prompt_title = '~ Dotfiles ~',
  }
end
local function findDotfiles()
  require('telescope.builtin').git_files {
    cwd = '~/dotfiles',
    prompt_title = '~ Dotfiles ~',
  }
end
local function project_files()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('telescope.builtin').find_files(opts)
  end
end

local leader = {
  [';'] = { '<cmd>Telescope buffers<CR>', 'Buffers' },
  q = { ':q<cr>', 'Quit' },
  w = { ':w<CR>', 'Save' },
  x = { ':wq<cr>', 'Save and Quit' },
  -- a = { 'Swap next function paramater' },
  -- A = { 'Swap previous function parameter' },
  [' '] = 'which_key_ignore',
  y = 'which_key_ignore',
  Y = 'which_key_ignore',
  p = 'which_key_ignore',
  P = 'which_key_ignore',
  g = {
    name = 'Git',
    g = { '<cmd>Neogit<CR>', 'NeoGit' },
    c = { ':GitCopyToClipboard<CR>', 'Copy GitHub URL to Clipboard' },
    o = { ':GitOpenInBrowser<CR>', 'Open File in Browser' },
    b = { '<Cmd>Telescope git_branches<CR>', 'Checkout Branch' },
    C = {
      '<cmd>Telescope git_bcommits<cr>',
      'Checkout commit(for current file)',
    },
    d = { '<cmd>DiffviewOpen<cr>', 'DiffView' },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next Hunk' },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev Hunk' },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", 'Blame' },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", 'Preview Hunk' },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", 'Reset Hunk' },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", 'Reset Buffer' },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", 'Stage Hunk' },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      'Undo Stage Hunk',
    },
  },
  t = {
    name = 'Test',
    -- n = {
    --   function()
    --     require('jester').run {
    --       cmd = vim.g['test#javascript#jest#executable']
    --         .. " -t '$result' -- $file",
    --     }
    --   end,
    --   'Test Nearest',
    -- },
    -- j = {
    --   function()
    --     require('jester').debug {
    --       path_to_jest = './node_modules/jest/bin/jest.js',
    --     }
    --   end,
    --   'Test File',
    -- },
    -- -- l = { require('jester').run_last, 'Test Nearest' },
    n = { '<cmd>TestNearest<CR>', 'Test Nearest' },
    f = { '<cmd>TestFile<CR>', 'Test File' },
    s = { '<cmd>TestSuite<CR>', 'Test Suite' },
    l = { '<cmd>TestLast<CR>', 'Test Last' },
    g = { '<cmd>TestVisit<CR>', 'Test Visit' },
    -- e = { '<cmd>vs<CR>:terminal fish<CR>', 'New Terminal' },
  },
  d = {
    name = 'Configuration',
    d = { findDotfiles, 'Find Dotfiles' },
    g = { searchDotfiles, 'Search Dotfiles' },
    n = {
      ':e ~/dotfiles/nvim/.config/nvim/lua/user/plugins.lua<CR>',
      'Open Neovim Config',
    },
    l = {
      name = 'Local files',
      f = {
        '<cmd> e $HOME/.config/fish/local-config.fish',
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
    r = { reloadConfig, 'Reload Configuration' },
    p = {
      name = 'Plugins',
      p = { '<cmd>PackerSync<cr>', 'Sync' },
      s = { '<cmd>PackerStatus<cr>', 'Status' },
      i = { '<cmd>PackerInstall<cr>', 'Install' },
      c = { '<cmd>PackerCompile<cr>', 'Compile' },
      C = { '<cmd>PackerClean<cr>', 'Clean' },
      l = { '<cmd>PackerLoad<cr>', 'Load' },
      u = { '<cmd>PackerUpdate<cr>', 'Update' },
      P = { '<cmd>PackerProfile<cr>', 'Profile' },
    },
  },
  f = {
    name = 'Find',
    t = { ':Telescope<Space>', 'Telescope' },
    p = { project_files, 'Git Files' },
    P = { '<cmd>Telescope projects<CR>', 'Change Project' },
    b = { '<cmd>Telescope buffers<CR>', 'Buffers' },
    f = { '<cmd>Telescope find_files<CR>', 'All Files' },
    ['.'] = {
      function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.expand '%:p:h',
          prompt_title = vim.fn.expand '%:~:.:p:h',
        }
      end,
      'Find in current directory',
    },
    d = { findDotfiles, 'Dotfiles' },
    h = { '<cmd>Telescope oldfiles<CR>', 'Old Files' },
    H = { '<cmd>Telescope help_tags<CR>', 'Help tags' },
    g = { '<cmd>Telescope live_grep<CR>', 'Live Grep' },
    G = {
      function()
        require('telescope.builtin').live_grep { cwd = vim.fn.expand '%:p:h' }
      end,
      'Live Grep',
    },
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
    t = { '<cmd>Telescope builtin<cr>', 'Telescope' },
    c = { '<cmd>Telescope commands<cr>', 'Commands' },
    h = { '<cmd>Telescope help_tags<cr>', 'Help Pages' },
    m = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
    k = { '<cmd>Telescope keymaps<cr>', 'Key Maps' },
    s = { '<cmd>Telescope highlights<cr>', 'Search Highlight Groups' },
    f = { '<cmd>Telescope filetypes<cr>', 'File Types' },
    o = { '<cmd>Telescope vim_options<cr>', 'Options' },
    a = { '<cmd>Telescope autocommands<cr>', 'Auto Commands' },
  },
  W = {
    name = 'Window',
    ['<Up>'] = { '<cmd>resize +5<CR>', 'Increase window height' },
    ['<Down>'] = { '<cmd>resize -5<CR>', 'Decrease window height' },
    ['<Left>'] = { '<cmd>vertical resize -5<CR>', 'Decrease window width' },
    ['<Right>'] = { '<cmd>vertical resize +5<CR>', 'Increase window width' },
  },
}

wk.register(leader, { prefix = '<leader>' })
map('n', '<S-Left>', '<cmd>vertical resize -5<CR>')
map('n', '<S-Up>', '<cmd>resize +5<CR>')
map('n', '<S-Down>', '<cmd>resize -5<CR>')
map('n', '<S-Right>', '<cmd>vertical resize +5<CR>')

local visual = {
  y = 'which_key_ignore',
  Y = 'which_key_ignore',
  g = {
    name = 'Git',
    c = { [[:'<,'>GitCopyToClipboard<CR>]], 'Copy GitHub URL to Clipboard' },
    o = { [[:'<,'>GitOpenInBrowser<CR>]], 'Open In Browser' },
  },
}

wk.register(visual, { prefix = '<leader>', mode = 'x' })

wk.register({
  ['<C-n>'] = { ':TestNearest<CR>', 'Run nearest test' },
  ['<C-f>'] = { ':TestFile<CR>', 'Test file' },
  ['<C-s>'] = { ':TestSuite<CR>', 'Test suite' },
  ['<C-l>'] = { ':TestLast<CR>', 'Run last test' },
  ['<C-g>'] = { ':TestVisit<CR>' },
}, {
  prefix = 't',
})

local textobjs = {
  a = {
    b = 'a code block (treesitter)',
    f = 'a function block (treesitter)',
    C = 'a conditional block (treesitter)',
    c = 'a comment block (treesitter)',
    s = 'a statement block (treesitter)',
    m = 'a call block (treesitter)',
  },
  i = {
    b = 'inside code block (treesitter)',
    f = 'inside function block (treesitter)',
    C = 'inside conditional block (treesitter)',
    c = 'inside comment block (treesitter)',
    s = 'inside statement block (treesitter)',
    m = 'inside call block (treesitter)',
  },
}

wk.register(textobjs, { mode = 'o' })
wk.register(textobjs, { mode = 'x' })

wk.register {
  ['[g'] = 'Diagnostic Previous',
  [']g'] = 'Diagnostic Next',
  ['[q'] = 'Quickfix Previous',
  [']q'] = 'Quickfix Next',
  ['[Q'] = 'Quickfix First',
  [']Q'] = 'Quickfix Last',
  ['[l'] = 'Location List Previous',
  [']l'] = 'Location List Next',
  ['[L'] = 'Location List First',
  [']L'] = 'Location List Last',
  [']m'] = 'Go to beginning of next function',
  [']]'] = 'Go to beginning of next class',
  [']M'] = 'Go to end of next function',
  [']['] = 'Go to end of next class',
  ['[m'] = 'Go to beginning of previous function',
  ['[['] = 'Go to end of previous class',
  ['[M'] = 'Go to end of previous function',
  ['[]'] = 'Go to end of previous class',
}
