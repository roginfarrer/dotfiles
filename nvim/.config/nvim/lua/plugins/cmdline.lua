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
  },
  { 'jghauser/mkdir.nvim', event = 'CmdlineEnter' },
  { 'tpope/vim-eunuch', event = 'CmdlineEnter' },
  { 'tpope/vim-abolish', event = 'CmdlineEnter' },
  {
    'smjonas/inc-rename.nvim',
    lazy = true,
    config = true,
  },

  -- Terminal management
  {
    'akinsho/toggleterm.nvim',
    version = 'v2.*',
    keys = { [[<C-\>]] },
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
    config = function()
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

      require('which-key').register {
        ['<leader>gt'] = { toggleLazyGit, 'lazygit' },
      }
    end,

    -- testing integration
    {
      'nvim-neotest/neotest',
      dependencies = { 'haydenmeade/neotest-jest' },
      opts = function()
        return {
          icons = {
            failed = '',
            passed = '',
            running = '',
            skipped = '',
            unknown = '?',
          },
          adapters = {
            require 'neotest-jest' {
              cwd = function(path)
                local cwd = require('neotest-jest.util').find_package_json_ancestor(path)
                return cwd
              end,
            },
          },
        }
      end,
      -- stylua: ignore
      keys = {
        { 't<C-n>', ':lua require("neotest").run.run()<CR>', desc = 'Nearest Test' },
        { 't<C-f>', ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', desc = 'Test File' },
        { 't<C-l>', ':lua require("neotest").run.run_last()<CR>', desc = 'Last Test' },
        { 't<C-s>', ':lua require("neotest").summary.toggle()<CR>', desc = 'Test Summary' },
        { 't<C-o>', ':lua require("neotest").output.open({enter = true})<CR>', desc = 'Test Output' },
        { '[t', '<cmd>lua require("neotest").jump.prev({ status = "failed" })<CR>', desc = 'Go to previous failed test' },
        { ']t', '<cmd>lua require("neotest").jump.next({ status = "failed" })<CR>', desc = 'Go to next failed test' },
      },
    },
  },
}
