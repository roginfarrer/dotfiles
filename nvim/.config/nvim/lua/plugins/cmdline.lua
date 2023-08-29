return {
  {
    'smjonas/live-command.nvim',
    version = '1.*',
    event = 'CmdlineEnter',
    opts = {
      commands = {
        Norm = { cmd = 'norm' },
      },
    },
    config = function(_, opts)
      require('live-command').setup(opts)
    end,
  },
  -- { 'jghauser/mkdir.nvim', event = 'CmdlineEnter' },
  -- { 'tpope/vim-eunuch', event = 'CmdlineEnter' },
  { 'tpope/vim-abolish', event = 'CmdlineEnter' },
  { 'smjonas/inc-rename.nvim', lazy = true, config = true },

  -- Terminal management
  {
    'akinsho/toggleterm.nvim',
    -- tag = '*',
    keys = { [[<C-\>]] },
    cmd = { 'ToggleTerm', 'ToggleTermToggleAll', 'TermExec' },
    opts = {
      shell = 'fish',
      open_mapping = [[<C-\>]],
      direction = 'float',
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)
      local Terminal = require('toggleterm.terminal').Terminal

      local lazygit = Terminal:new {
        cmd = 'lazygit',
        direction = 'float',
      }

      local function toggleLazyGit()
        if vim.fn.executable 'lazygit' == 1 then
          lazygit:toggle()
        else
          print 'Please install lazygit (brew install lazygit)'
        end
      end

      vim.keymap.set('n', '<leader>gt', toggleLazyGit, { desc = 'lazygit' })
    end,
  },

  -- {
  --   'boltlessengineer/bufterm.nvim',
  --   enabled = false,
  --   cmd = { 'BufTermEnter', 'BufTermPrev', 'BufTermNext' },
  --   keys = { { [[<C-\>]], '<cmd>BufTermEnter<CR>', desc = 'Terminal' } },
  --   config = function(_, opts)
  --     require('bufterm').setup(opts)

  --     -- this will add Terminal to the list (not starting job yet)
  --     local Terminal = require('bufterm.terminal').Terminal
  --     local ui = require 'bufterm.ui'

  --     local lazygit = Terminal:new {
  --       cmd = 'lazygit',
  --       buflisted = false,
  --       termlisted = false, -- set this option to false if you treat this terminal as single independent terminal
  --     }
  --     vim.keymap.set('n', '<leader>gt', function()
  --       -- spawn terminal (terminal won't be spawned if self.jobid is valid)
  --       lazygit:spawn()
  --       -- open floating window
  --       ui.toggle_float(lazygit.bufnr)
  --     end, {
  --       desc = 'Open lazygit in floating window',
  --     })
  --   end,
  -- },

  -- Open files from neovim terminals in current neovim instance
  {
    'willothy/flatten.nvim',
    opts = {},
    lazy = false,
    priority = 1001,
  },
}
