local wk = require 'which-key'

wk.setup {
  triggers = 'auto',
  plugins = {
    spelling = {
      enabled = true,
    },
  },
  key_labels = { ['<leader>'] = 'SPC', ['<tab>'] = 'TAB' },
}

-- local function searchDotfiles()
--   require('telescope.builtin').live_grep {
--     cwd = '~/dotfiles',
--     prompt_title = '~ Dotfiles ~',
--   }
-- end
-- local function findDotfiles()
--   require('telescope.builtin').git_files {
--     cwd = '~/dotfiles',
--     prompt_title = '~ Dotfiles ~',
--   }
-- end
-- local function project_files()
--   local result = require('telescope.utils').get_os_command_output {
--     'git',
--     'rev-parse',
--     '--is-inside-work-tree',
--   }
--   if result[1] == 'false' then
--     require('telescope.builtin').find_files()
--   else
--     require('telescope.builtin').git_files()
--   end
-- end

-- _G.project_files = project_files

local general = {
  n = {

    -- If you like long lines with line wrapping enabled, this solves the problem
    -- that pressing down jumpes your cursor “over” the current line to the next
    -- line. It changes behaviour so that it jumps to the next row in the editor
    -- (much more natural)
    -- Display line movements unless preceded by a count whilst also recording jump points for movements larger than five lines
    ['j'] = {
      [[ v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj' ]],
      expr = true,
    },
    ['k'] = {
      [[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk']],
      expr = true,
    },

    -- When changing, don't save to register
    ['c'] = { '"_c' },
    ['C'] = { '"_C' },

    ['<C-h>'] = { ':SmartCursorMoveLeft<CR>', ' window left' },
    ['<C-l>'] = { ':SmartCursorMoveRight<CR>', ' window right' },
    ['<C-j>'] = { ':SmartCursorMoveDown<CR>', ' window down' },
    ['<C-k>'] = { ':SmartCursorMoveUp<CR>', ' window up' },
    ['gx'] = {
      function()
        local path = vim.fn.expand '<cfile>'
        require('plenary.job'):new({ command = 'open', args = { path } }):start()
      end,
      'Open URL under cursor',
    },

    -- Yank to system clipboard
    ['<leader>y'] = { '"+y:echo "yanked to clipboard"<cr>' },
    ['<leader>Y'] = { '"+Y:echo "yanked to clipboard"<cr>' },

    -- Put from system clipboard
    ['<leader>p'] = { '"+p' },
    ['<leader>P'] = { '"+P' },

    -- Copy path to clipboard
    ['<leader>yf'] = {
      ':let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>',
      'copy file path to clipboard',
    },

    ['<leader><leader>'] = { 'za', 'toggle fold' },
    ['<BS>'] = { '<C-^>', 'previous buffer' },
    ['$'] = { 'g$' },
    ['0'] = { 'g^' },

    -- Move entire lines up and down
    ['<A-k>'] = { ':m .-2<CR>==', ' move line up' },
    ['<A-j>'] = { ':m .+1<CR>==', ' move line up' },

    ['<S-Left>'] = { ':SmartResizeLeft<CR>', 'resize window left' },
    ['<S-Up>'] = { ':SmartResizeUp<CR>', 'resize window up' },
    ['<S-Down>'] = { ':SmartResizeDown<CR>', 'resize window down' },
    ['<S-Right>'] = { ':SmartResizeRight<CR>', 'resize window right' },
  },

  i = {

    -- go to  beginning and end
    ['<C-b>'] = { '<ESC>^i', '論 beginning of line' },
    ['<C-e>'] = { '<End>', '壟 end of line' },

    -- navigate within insert mode
    ['<C-h>'] = { '<Left>', '  move left' },
    ['<C-l>'] = { '<Right>', ' move right' },
    ['<C-j>'] = { '<Down>', ' move down' },
    ['<C-k>'] = { '<Up>', ' move up' },
  },

  v = {

    -- Yank to system clipboard
    ['<leader>y'] = { '"+y:echo "yanked to clipboard"<cr>' },
    ['<leader>Y'] = { '"+Y:echo "yanked to clipboard"<cr>' },

    -- Move entire lines up and down
    ['<A-k>'] = { [[:m '>+1<CR>gv=gv]], ' move line up' },
    ['<A-j>'] = { [[:m '<-2<CR>gv=gv]], ' move line up' },

    -- When changing, don't save to register
    ['c'] = { '"_c' },
    ['C'] = { '"_C' },
  },

  t = {

    ['<leader><esc>'] = { [[<C-\><C-n>]], 'esc' },
    ['jk'] = { [[<C-\><C-n>]], 'esc' },
    ['<C-h>'] = {
      function()
        require('smart-splits').move_cursor_left()
      end,
      ' window left',
    },
    ['<C-l>'] = {
      function()
        require('smart-splits').move_cursor_right()
      end,
      ' window right',
    },
    ['<C-j>'] = {
      function()
        require('smart-splits').move_cursor_down()
      end,
      ' window down',
    },
    ['<C-k>'] = {
      function()
        require('smart-splits').move_cursor_up()
      end,
      ' window up',
    },
  },
}

wk.register(general.n, { mode = 'n' })
wk.register(general.i, { mode = 'i' })
wk.register(general.v, { mode = 'v' })
wk.register(general.t, { mode = 't' })

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
    -- g = { '<cmd>Neogit<CR>', 'NeoGit' },
    c = { ':GBrowse!<CR>', 'Copy GitHub URL to Clipboard' },
    o = { ':GBrowse<CR>', 'Open File in Browser' },
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
  d = {
    name = 'Configuration',
    d = {
      ':lua require("plugins.configs.telescope").findDotfiles()<CR>',
      'Find Dotfiles',
    },
    g = {
      ':lua require("plugins.configs.telescope").searchDotfiles()<CR>',
      'Search Dotfiles',
    },
    n = {
      ':e $MYVIMRC<CR>',
      'Open Neovim Config',
    },
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
    t = { ':Telescope builtin include_extensions=true<CR>', 'Telescope' },
    p = {
      ':lua require("plugins.configs.telescope").project_files()<CR>',
      'Git Files',
    },
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
    d = {
      ':lua require("plugins.configs.telescope").findDotfiles()<CR>',
      'Dotfiles',
    },
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
}

wk.register(leader, { prefix = '<leader>' })

local visual = {
  y = 'which_key_ignore',
  Y = 'which_key_ignore',
  g = {
    name = 'Git',
    c = { [[:'<,'>GBrowse!<CR>]], 'Copy GitHub URL to Clipboard' },
    o = { [[:'<,'>GBrowse<CR>]], 'Open In Browser' },
  },
}

wk.register(visual, { prefix = '<leader>', mode = 'x' })

wk.register({
  ['<C-n>'] = { ':lua require("neotest").run.run()<CR>', 'Nearest Test' },
  ['<C-f>'] = {
    ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>',
    'Test File',
  },
  ['<C-l>'] = { ':lua require("neotest").run.run_last()<CR>', 'Last Test' },
  ['<C-s>'] = {
    ':lua require("neotest").summary.toggle()<CR>',
    'Test Summary',
  },
  -- ['<C-c>'] = { ':UltestClear<CR>', 'Clear Results' },
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
  -- ['[g'] = 'Diagnostic Previous',
  -- [']g'] = 'Diagnostic Next',
  ['[d'] = 'Diagnostic Previous',
  [']d'] = 'Diagnostic Next',
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
  ['[t'] = {
    '<cmd>lua require("neotest").jump.prev({ status = "failed" })<CR>',
    'Go to previous failed test',
  },
  [']t'] = {
    '<cmd>lua require("neotest").jump.next({ status = "failed" })<CR>',
    'Go to next failed test',
  },
}

-- wk.register({
--   h = {
--     a = { ':lua require("harpoon.mark").add_file()<CR>', 'Harpoon Add File' },
--     h = {
--       ':lua require("harpoon.ui").toggle_quick_menu()<CR>',
--       'Harpoon Open Menu',
--     },
--     u = {
--       ':lua require("harpoon.ui").nav_file(1)<CR>',
--       'Harpoon 1',
--     },
--     i = {
--       ':lua require("harpoon.ui").nav_file(2)<CR>',
--       'Harpoon 2',
--     },
--     o = {
--       ':lua require("harpoon.ui").nav_file(3)<CR>',
--       'Harpoon 3',
--     },
--     p = {
--       ':lua require("harpoon.ui").nav_file(4)<CR>',
--       'Harpoon 4',
--     },
--   },
-- }, {
--   prefix = '<leader>',
-- })

if packer_plugins['neo-tree.nvim'] then
  map('n', '-', ':Neotree filesystem reveal current<CR>')
end

local function browse(opts)
  require('plenary.job'):new({ 'open', opts.args }):start()
end

vim.api.nvim_create_user_command(
  'Browse',
  browse,
  { bang = true, range = true, nargs = 1 }
)
