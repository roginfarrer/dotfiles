local wk = require 'which-key'

local map = require('util').map

local function luaDocs()
  if vim.bo.filetype == 'lua' or vim.bo.filetype == 'help' or vim.bo.filetype == 'lua' then
    vim.fn.execute('h ' .. vim.fn.expand '<cword>')
  end
end

local function bufmap(mode, lhs, rhs, opts)
  map(mode, lhs, rhs, vim.tbl_deep_extend('keep', { buffer = true }, opts or {}))
end

local M = {}

function M.setup(client, bufnr)
  local function lsp_cmd(name, func)
    vim.api.nvim_buf_create_user_command(bufnr, name, 'lua ' .. func .. '()', { force = true })
  end

  -- lsp_cmd('LspGoToDefinition', 'vim.lsp.buf.definition')
  vim.api.nvim_buf_create_user_command(bufnr, 'LspGoToDefinition', function()
    if client.name == 'tsserver' then
      vim.fn.execute 'TypescriptGoToSourceDefinition'
    else
      vim.lsp.buf.definition()
    end
  end, { force = true })

  lsp_cmd('LspGoToDeclaration', 'vim.lsp.buf.declaration')
  lsp_cmd('LspHover', 'vim.lsp.buf.hover')
  lsp_cmd('LspImplementations', 'vim.lsp.buf.implementation')
  lsp_cmd('LspSignatureHelp', 'vim.lsp.buf.signature_help')
  lsp_cmd('LspTypeDefinition', 'vim.lsp.buf.type_definition')
  lsp_cmd('LspRenameSymbol', 'vim.lsp.buf.rename')
  lsp_cmd('LspCodeAction', 'vim.lsp.buf.code_action')
  lsp_cmd('LspRangeCodeAction', 'vim.lsp.buf.range_code_action')
  lsp_cmd('LspReferences', 'vim.lsp.buf.references')
  lsp_cmd('LspPrevDiagnostic', 'vim.diagnostic.goto_prev')
  lsp_cmd('LspNextDiagnostic', 'vim.diagnostic.goto_next')

  map('n', '<leader>la', '<cmd>LspCodeAction<CR>', { desc = 'Code Action' })
  map('x', '<leader>la', ':<c-u>LspRangeCodeAction<CR>', { desc = 'Code Action' })
  map('n', '<leader>lr', function()
    require 'inc_rename'
    return ':IncRename ' .. vim.fn.expand '<cword>'
  end, { desc = 'Rename', expr = true })
  map('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Quickfix' })
  -- map('n', '<leader>lR', '<cmd>FzfLua lsp_references<CR>', { desc = 'References' })
  map('n', '<leader>ls', '<cmd>FzfLua lsp_document_symbols<CR>', { desc = 'Document Symbols' })
  map('n', '<leader>lS', '<cmd>FzfLua lsp_dynamic_workspace_symbols<CR>', { desc = 'Workspace Symbols' })

  wk.add {
    {
      mode = { 'x', 'n' },
      { '<leader>l', group = 'LSP' },
    },
  }

  local function showDocs()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
      if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
        vim.fn.execute('h ' .. vim.fn.expand '<cword>')
      else
        vim.fn.execute 'LspHover'
      end
    end
  end

  bufmap('n', 'gD', vim.lsp.buf.definition, { desc = 'goto definition' })
  -- bufmap('n', 'gd', '<cmd>Glance definitions<CR>', { desc = 'preview definitions' })
  -- bufmap('n', 'gr', '<cmd>Glance references<CR>', { desc = 'lsp references' })
  -- bufmap('n', 'gI', '<cmd>Glance implementations<CR>')
  -- bufmap('n', 'gy', '<cmd>Glance type_definitions<CR>')
  bufmap('n', 'gd', '<cmd>LspGoToDefinition<CR>', { desc = 'preview definitions' })
  bufmap('n', 'gr', '<cmd>FzfLua lsp_references<CR>', { desc = 'lsp references' })
  bufmap('n', 'gI', '<cmd>FzfLua lsp_implementations<CR>')
  bufmap('n', 'gy', '<cmd>FzfLua lsp_definitions<CR>')
  bufmap('n', '[d', '<cmd>LspPrevDiagnostic<CR>')
  bufmap('n', ']d', '<cmd>LspNextDiagnostic<CR>')
  bufmap('n', 'K', showDocs)
  bufmap('n', 'gK', luaDocs)
  if vim.lsp.inlay_hint then
    bufmap('n', '<leader>lh', function()
      vim.lsp.inlay_hint(0, nil)
    end, { desc = 'Toggle Inlay Hints' })
  end
end

return M
