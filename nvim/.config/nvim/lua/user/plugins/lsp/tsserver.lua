local M = {}

M.init_options = require('nvim-lsp-ts-utils').init_options

M.on_attach = function(client, bufnr)
  local ts_utils = require 'nvim-lsp-ts-utils'

  ts_utils.setup {
    enable_import_on_completion = true,
    always_organize_imports = false,
    update_imports_on_move = true,
    require_confirmation_on_move = true,
  }
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

M.flags = {
  debounce_text_changes = 500,
}

return M
