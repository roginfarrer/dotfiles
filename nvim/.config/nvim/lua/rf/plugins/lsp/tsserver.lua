local M = {}

M.on_attach = function(client, bufnr)
  local ts_utils = require 'nvim-lsp-ts-utils'

  print('this was called')

  ts_utils.setup_client(client)

  local leader = {
    l = {
      o = { ':TSLspOrganize<CR>', '(TS) Organize Imports' },
      i = { ':TSLspImportAll<CR>', '(TS) Import Missing Imports' },
      R = { ':TSLspRenameFile<CR>', '(TS) Rename File' },
    },
  }
  require('which-key').register(leader, { prefix = '<leader>', buffer = bufnr })
end

return M
