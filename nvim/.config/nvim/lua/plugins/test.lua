return {
  -- testing integration
  {
    'nvim-neotest/neotest',
    dependencies = {
      { 'guivazcabral/neotest-jest' },
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace 'neotest'
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)
      require('neotest').setup {
        adapters = {
          require 'neotest-jest' {
            cwd = function(path)
              local cwd = require('neotest-jest.util').find_package_json_ancestor(path)
              return cwd
            end,
            env = { CI = true },
          },
        },
        log_level = 2,
        icons = require('ui.icons').lazy.test,
        output = { open_on_run = true },
        quickfix = {
          open = function()
            if require('util').has 'trouble.nvim' then
              vim.cmd 'Trouble quickfix'
            else
              vim.cmd 'copen'
            end
          end,
        },
      }
    end,
    -- stylua: ignore
    keys = {
      { '<leader>tn', function() require("neotest").run.run() end, desc = 'Nearest Test' },
      { '<leader>tf', function() require("neotest").run.run(vim.fn.expand("%")) end, desc = 'Test File' },
      { '<leader>tl', function() require("neotest").run.run_last() end, desc = 'Last Test' },
       { "<leader>tw", function() require('neotest').run.run({ jestCommand = 'jest --watch ' }) end, desc = "Run Watch" },
      -- { 't<C-s>', function() require("neotest").summary.toggle() end, desc = 'Test Summary' },
      -- { 't<C-o>', function() require("neotest").output.open({enter = true}) end, desc = 'Test Output' },
      -- { '[t', function() require("neotest").jump.prev({ status = "failed" }) end, desc = 'Go to previous failed test' },
      -- { ']t', function() require("neotest").jump.next({ status = "failed" }) end, desc = 'Go to next failed test' },
      -- { 't<C-n>', function() require("neotest").run.run() end, desc = 'Nearest Test' },
      -- { 't<C-f>', function() require("neotest").run.run(vim.fn.expand("%")) end, desc = 'Test File' },
      -- { 't<C-l>', function() require("neotest").run.run_last() end, desc = 'Last Test' },
      -- { 't<C-s>', function() require("neotest").summary.toggle() end, desc = 'Test Summary' },
      -- { 't<C-o>', function() require("neotest").output.open({enter = true}) end, desc = 'Test Output' },
      { '[t', function() require("neotest").jump.prev({ status = "failed" }) end, desc = 'Go to previous failed test' },
      { ']t', function() require("neotest").jump.next({ status = "failed" }) end, desc = 'Go to next failed test' },
    },
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- fancy UI for the debugger
      {
        'rcarriga/nvim-dap-ui',
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
        opts = {},
        config = function(_, opts)
          -- setup dap config by VsCode launch.json file
          -- require("dap.ext.vscode").load_launchjs()
          local dap = require 'dap'
          local dapui = require 'dapui'
          dapui.setup(opts)
          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open {}
          end
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close {}
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close {}
          end
        end,
      },
      -- virtual text for the debugger
      { 'theHamsta/nvim-dap-virtual-text', opts = {} },
      -- {
      --   'mxsdev/nvim-dap-vscode-js',
      --   dependencies = {
      --     {
      --       -- stylua: ignore
      --       { 'microsoft/vscode-js-debug', build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out' },
      --     },
      --   },
      --   opts = {
      --     debugger_path = vim.fn.getenv 'HOME' .. '/.local/share/nvim/lazy/vscode-js-debug',
      --   },
      -- },
      -- mason.nvim integration
      {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = 'mason.nvim',
        cmd = { 'DapInstall', 'DapUninstall' },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            'js-debug-adapter',
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
    },
    opts = function()
      local dap = require 'dap'
      if not dap.adapters['pwa-node'] then
        require('dap').adapters['pwa-node'] = {
          type = 'server',
          host = 'localhost',
          port = '${port}',
          executable = {
            command = 'node',
            -- 💀 Make sure to update this path to point to your installation
            args = {
              require('mason-registry').get_package('js-debug-adapter'):get_install_path()
                .. '/js-debug/src/dapDebugServer.js',
              '${port}',
            },
          },
        }
      end
      for _, language in ipairs { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' } do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              type = 'pwa-node',
              request = 'launch',
              name = 'Launch file',
              program = '${file}',
              cwd = '${workspaceFolder}',
            },
            {
              type = 'pwa-node',
              request = 'attach',
              name = 'Attach',
              processId = require('dap.utils').pick_process,
              cwd = '${workspaceFolder}',
            },
          }
        end
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
