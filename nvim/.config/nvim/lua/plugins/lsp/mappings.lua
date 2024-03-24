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

  map('n', '<leader>la', '<cmd>LspCodeAction<CR>', { desc = 'Code Action' })
  map('x', '<leader>la', ':<c-u>LspRangeCodeAction<CR>', { desc = 'Code Action' })
  map('n', '<leader>lr', function()
    require 'inc_rename'
    return ':IncRename ' .. vim.fn.expand '<cword>'
  end, { desc = 'Rename', expr = true })
  map('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Quickfix' })
  map('n', '<leader>lR', '<cmd>FzfLua lsp_references<CR>', { desc = 'References' })
  map('n', '<leader>ls', '<cmd>FzfLua lsp_document_symbols<CR>', { desc = 'Document Symbols' })
  map('n', '<leader>lS', '<cmd>FzfLua lsp_dynamic_workspace_symbols<CR>', { desc = 'Workspace Symbols' })

  -- local _, has_lsp_lines = pcall(require, 'lsp_lines')
  -- if has_lsp_lines then
  --   map('n', '<leader>ll', require('lsp_lines').toggle, { desc = 'Toggle lsp_lines' })
  -- end

  -- local miniclue = require("mini.clue")
  -- require('mini.clue').setup {
  --   opts = function(_, opts)
  --     vim.print(opts.clues)
  --     table.insert(opts.clues, { mode = 'n', keys = '<leader>l', desc = '+LSP' })
  --     table.insert(opts.clues, { mode = 'x', keys = '<leader>l', desc = '+LSP' })
  --     return opts
  --   end,
  -- }

  local leader = {
    l = {
      name = 'LSP',
    },
  }

  -- if pcall(require, 'lsp_lines') then
  --   leader.l.l = { require('lsp_lines').toggle, 'Toggle lsp_lines' }
  -- end

  local visual = {
    l = {
      name = 'LSP',
    },
  }

  wk.register(leader, { prefix = '<leader>' })
  wk.register(visual, { prefix = '<leader>', mode = 'x' })

  local function showDocs()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
      if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
        vim.fn.execute('h ' .. vim.fn.expand '<cword>')
      -- elseif require('regexplainer.utils.treesitter').get_regexp_pattern_at_cursor() then
      --   require('regexplainer').show()
      --   require('config.util').autocmd('CursorMoved', {
      --     group = 'regexplainer_hover',
      --     once = true,
      --     callback = function()
      --       require('regexplainer').hide()
      --     end,
      --   })
      else
        -- if client.supports_method 'textDocument/hover' then
        vim.fn.execute 'Lspsaga hover_doc'
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
  bufmap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
  bufmap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
  bufmap('n', 'K', showDocs)
  bufmap('n', 'gK', luaDocs)
  if vim.lsp.inlay_hint then
    bufmap('n', '<leader>lh', function()
      vim.lsp.inlay_hint(0, nil)
    end, { desc = 'Toggle Inlay Hints' })
  end
end

return M
