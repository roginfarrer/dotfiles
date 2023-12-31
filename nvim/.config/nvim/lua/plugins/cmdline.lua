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
  { 'tpope/vim-abolish', event = 'CmdlineEnter' },
  { 'smjonas/inc-rename.nvim', opts = {} },

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
}
