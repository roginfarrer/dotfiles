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
  { 'jghauser/mkdir.nvim', event = 'CmdlineEnter' },
  { 'tpope/vim-eunuch', event = 'CmdlineEnter' },
  { 'tpope/vim-abolish', event = 'CmdlineEnter' },
  { 'smjonas/inc-rename.nvim', lazy = true, config = true },

  -- Terminal management
  {
    'akinsho/toggleterm.nvim',
    version = 'v2.*',
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

  {
    'boltlessengineer/bufterm.nvim',
    enabled = false,
    cmd = { 'BufTermEnter', 'BufTermPrev', 'BufTermNext' },
    keys = { { [[<C-\>]], '<cmd>BufTermEnter<CR>', desc = 'Terminal' } },
    config = function(_, opts)
      require('bufterm').setup(opts)

      -- this will add Terminal to the list (not starting job yet)
      local Terminal = require('bufterm.terminal').Terminal
      local ui = require 'bufterm.ui'

      local lazygit = Terminal:new {
        cmd = 'lazygit',
        buflisted = false,
        termlisted = false, -- set this option to false if you treat this terminal as single independent terminal
      }
      vim.keymap.set('n', '<leader>gt', function()
        -- spawn terminal (terminal won't be spawned if self.jobid is valid)
        lazygit:spawn()
        -- open floating window
        ui.toggle_float(lazygit.bufnr)
      end, {
        desc = 'Open lazygit in floating window',
      })
    end,
  },

  -- Open files from neovim terminals in current neovim instance
  {
    'willothy/flatten.nvim',
    opts = {},
    lazy = false,
    priority = 1001,
  },

  -- testing integration
  {
    'nvim-neotest/neotest',
    dependencies = {
      'haydenmeade/neotest-jest',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = function()
      return {
        log_level = 2,
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
      { '<leader>tn', function() require("neotest").run.run() end, desc = 'Nearest Test' },
      { '<leader>tf', function() require("neotest").run.run(vim.fn.expand("%")) end, desc = 'Test File' },
      { '<leader>tl', function() require("neotest").run.run_last() end, desc = 'Last Test' },
      -- { 't<C-s>', function() require("neotest").summary.toggle() end, desc = 'Test Summary' },
      -- { 't<C-o>', function() require("neotest").output.open({enter = true}) end, desc = 'Test Output' },
      -- { '[t', function() require("neotest").jump.prev({ status = "failed" }) end, desc = 'Go to previous failed test' },
      -- { ']t', function() require("neotest").jump.next({ status = "failed" }) end, desc = 'Go to next failed test' },
      { 't<C-n>', function() require("neotest").run.run() end, desc = 'Nearest Test' },
      { 't<C-f>', function() require("neotest").run.run(vim.fn.expand("%")) end, desc = 'Test File' },
      { 't<C-l>', function() require("neotest").run.run_last() end, desc = 'Last Test' },
      { 't<C-s>', function() require("neotest").summary.toggle() end, desc = 'Test Summary' },
      { 't<C-o>', function() require("neotest").output.open({enter = true}) end, desc = 'Test Output' },
      { '[t', function() require("neotest").jump.prev({ status = "failed" }) end, desc = 'Go to previous failed test' },
      { ']t', function() require("neotest").jump.next({ status = "failed" }) end, desc = 'Go to next failed test' },
    },
  },

  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      {
        'mxsdev/nvim-dap-vscode-js',
        opts = {},
        build = 'npm install --legacy-peer-deps && npm run compile',
      },
    },
    config = function()
      local dap = require 'dap'
      for _, language in ipairs { 'typescript', 'javascript' } do
        require('dap').configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Debug Jest Tests',
            -- trace = true, -- include debugger info
            runtimeExecutable = 'node',
            runtimeArgs = {
              './node_modules/jest/bin/jest.js',
              '--runInBand',
            },
            rootPath = '${workspaceFolder}',
            cwd = '${workspaceFolder}',
            console = 'integratedTerminal',
            internalConsoleOptions = 'neverOpen',
          },
        }
      end
    end,
    --     dap.adapters.node2 = {
    --       type = 'executable',
    --       command = 'node',
    --       args = { os.getenv 'HOME' .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js' },
    --     }
    --     dap.configurations.javascript = {
    --       {
    --         name = 'Launch',
    --         type = 'node2',
    --         request = 'launch',
    --         program = '${file}',
    --         cwd = vim.fn.getcwd(),
    --         sourceMaps = true,
    --         protocol = 'inspector',
    --         console = 'integratedTerminal',
    --       },
    --       {
    --         -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    --         name = 'Attach to process',
    --         type = 'node2',
    --         request = 'attach',
    --         processId = require('dap.utils').pick_process,
    --       },
    --     }
    --     dap.adapters.chrome = {
    --       type = 'executable',
    --       command = 'node',
    --       args = { os.getenv 'HOME' .. '/path/to/vscode-chrome-debug/out/src/chromeDebug.js' }, -- TODO adjust
    --     }
    --     dap.configurations.javascriptreact = { -- change this to javascript if needed
    --       {
    --         type = 'chrome',
    --         request = 'attach',
    --         program = '${file}',
    --         cwd = vim.fn.getcwd(),
    --         sourceMaps = true,
    --         protocol = 'inspector',
    --         port = 9222,
    --         webRoot = '${workspaceFolder}',
    --       },
    --     }
    --     dap.configurations.typescriptreact = { -- change to typescript if needed
    --       {
    --         type = 'chrome',
    --         request = 'attach',
    --         program = '${file}',
    --         cwd = vim.fn.getcwd(),
    --         sourceMaps = true,
    --         protocol = 'inspector',
    --         port = 9222,
    --         webRoot = '${workspaceFolder}',
    --       },
    --     }
    --   end,
  },
}
