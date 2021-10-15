local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {
    os.getenv('HOME') .. '/repos/vscode-node-debug2/out/src/nodeDebug.js',
  },
}
dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}
dap.adapters.chrome = {
  type = 'executable',
  command = 'node',
  args = {
    os.getenv('HOME') .. '/repos/vscode-chrome-debug/out/src/chromeDebug.js',
  },
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
  {
    type = 'chrome',
    request = 'attach',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    port = 9222,
    webRoot = '${workspaceFolder}',
  },
}

dap.configurations.typescriptreact = { -- change to typescript if needed
  {
    type = 'chrome',
    request = 'attach',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    port = 9222,
    webRoot = '${workspaceFolder}',
  },
}
