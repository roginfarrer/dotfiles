local dap = require 'dap'

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {
    os.getenv 'HOME' .. '/repos/vscode-node-debug2/out/src/nodeDebug.js',
  },
}
dap.adapters.chrome = {
  type = 'executable',
  command = 'node',
  args = {
    os.getenv 'HOME' .. '/repos/vscode-chrome-debug/out/src/chromeDebug.js',
  },
}

dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    program = '${file}',
    -- program = '${workspaceFolder}/node_modules/.bin/jest',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    sourceMaps = true,
    webRoot = '${workspaceFolder}',
  },
}

local dir = '~/repos/rainbow-sprinkles/packages/rainbow-sprinkles'

dap.configurations.typescript = {
  {
    type = 'node2',
    request = 'launch',
    program = 'node',
    cwd = '${workspaceFolder}',
    sourceMaps = true,
    console = 'integratedTerminal',
    outFiles = {
      '${workspaceFolder}/**/*.js',
    },
    skipFiles = {
      '<node_internals>/**',
    },
    program = '${workspaceFolder}/node_modules/jest/bin/jest.js',
    args = { '--runInBand' },
    internalConsoleOptions = 'neverOpen',
    disableOptimisticBPs = true,
  },
}

require('dapui').setup {}

-- dap.defaults.fallback.terminal_win_cmd = ':ToggleTerm'
