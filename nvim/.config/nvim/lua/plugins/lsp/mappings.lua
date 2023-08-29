local wk = require 'which-key'

local map = require('config.util').map

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

  lsp_cmd('LspGoToDefinition', 'vim.lsp.buf.definition')
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

  local leader = {
    l = {
      name = 'LSP',
      a = { '<cmd>LspCodeAction<CR>', 'Code Action' },
      r = {
        function()
          require 'inc_rename'
          return ':IncRename '
          -- return ':IncRename ' .. vim.fn.expand '<cword>'
        end,
        'Rename',
        -- cond = cap.renameProvider,
        expr = true,
      },
      q = { '<cmd>lua vim.diagnostic.setloclist()<cr>', 'Quickfix' },
      R = { '<cmd>Telescope lsp_references<cr>', 'References' },
      s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
      S = {
        '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
        'Workspace Symbols',
      },
    },
  }

  if pcall(require, 'lsp_lines') then
    leader.l.l = { require('lsp_lines').toggle, 'Toggle lsp_lines' }
  end

  local visual = {
    l = {
      name = 'LSP',
      a = { ':<c-u>LspRangeCodeAction<CR>', 'Code Action' },
    },
  }

  wk.register(leader, { prefix = '<leader>' })
  wk.register(visual, { prefix = '<leader>', mode = 'x' })

  local function showDocs()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
      if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
        vim.fn.execute('h ' .. vim.fn.expand '<cword>')
      elseif require('regexplainer.utils.treesitter').get_regexp_pattern_at_cursor() then
        require('regexplainer').show()
        require('config.util').autocmd('CursorMoved', {
          group = 'regexplainer_hover',
          once = true,
          callback = function()
            require('regexplainer').hide()
          end,
        })
      else
        -- if client.supports_method 'textDocument/hover' then
        vim.fn.execute 'LspHover'
        -- end
      end
    end
  end

  bufmap('n', 'gD', vim.lsp.buf.definition, { desc = 'goto definition' })
  bufmap('n', 'gd', '<cmd>Glance definitions<CR>', { desc = 'preview definitions' })
  -- bufmap('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>')
  bufmap('n', 'gr', '<cmd>Glance references<CR>', { desc = 'lsp references' })
  -- bufmap('n', 'gR', '<cmd>Telescope lsp_references<CR>')
  -- bufmap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
  bufmap('n', 'gI', '<cmd>Glance implementations<CR>')
  -- bufmap('n', 'gs', '<cmd>LspSignatureHelp<CR>')
  bufmap('n', 'gy', '<cmd>Glance type_definitions<CR>')
  bufmap('n', 'gY', '<cmd>Telescope lsp_type_definitions<CR>')
  -- bufmap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
  -- bufmap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
  bufmap('n', '[d', '<cmd>LspPrevDiagnostic<CR>')
  bufmap('n', ']d', '<cmd>LspNextDiagnostic<CR>')
  bufmap('n', 'K', showDocs)
  bufmap('n', 'gK', luaDocs)
end

return M
