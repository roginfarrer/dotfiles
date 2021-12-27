local u = require 'user.utils'
local lspinstaller = require 'nvim-lsp-installer'
local wk = require 'which-key'

local lsp = vim.lsp
local handlers = lsp.handlers
local cmd = vim.cmd

local border = 'rounded'

local popup_opts = {
  border = border,
  focusable = false,
  max_width = 80,
  close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
}

require('user.plugins.lsp.fancy_rename').setup()
handlers['textDocument/hover'] = lsp.with(handlers.hover, popup_opts)
handlers['textDocument/signatureHelp'] = lsp.with(
  handlers.signature_help,
  popup_opts
)
vim.diagnostic.config {
  virtual_text = false,
  float = mergetable(popup_opts, {
    format = function(diagnostic)
      if diagnostic.source == 'eslint' then
        return string.format(
          '%s [%s]',
          diagnostic.message,
          -- shows the name of the rule
          diagnostic.user_data.lsp.code
        )
      end
      return string.format('%s [%s]', diagnostic.message, diagnostic.source)
    end,
    severity_sort = true,
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
  }),
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
  vim.fn.sign_define(
    'DiagnosticSign' .. name,
    { text = icon, numhl = 'DiagnosticDefault' .. name }
  )
end

lspSymbol('Error', '')
lspSymbol('Information', '')
lspSymbol('Hint', '')
lspSymbol('Info', '')
lspSymbol('Warn', '')

local function buf_nnoremap(keys, command)
  return u.nnoremap(keys, command, { buffer = true })
end

local function on_attach(client, bufnr)
  -- All formatting handled by null-ls
  if client.name ~= 'null-ls' then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  -- require('lsp_signature').on_attach({
  --   bind = true, -- This is mandatory, otherwise border config won't get registered.
  --   hint_prefix = '● ',
  --   handler_opts = {
  --     border = popup_opts.border,
  --   },
  -- }, bufnr)

  vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

  cmd 'command! LspGoToDefinition lua vim.lsp.buf.definition()'
  cmd 'command! LspGoToDeclaration lua vim.lsp.buf.declaration()'
  cmd 'command! LspHover lua vim.lsp.buf.hover()'
  cmd 'command! LspImplementations lua vim.lsp.buf.implementation()'
  cmd 'command! LspSignatureHelp lua vim.lsp.buf.signature_help()'
  cmd 'command! LspTypeDefinition lua vim.lsp.buf.type_definition()'
  cmd 'command! LspRenameSymbol lua vim.lsp.buf.rename.float()'
  cmd 'command! LspCodeAction lua vim.lsp.buf.code_action()'
  cmd 'command! LspRangeCodeAction lua vim.lsp.buf.range_code_action()'
  cmd 'command! LspReferences lua vim.lsp.buf.references()'
  cmd 'command! LspPrevDiagnostic lua vim.diagnostic.goto_prev()'
  cmd 'command! LspNextDiagnostic lua vim.diagnostic.goto_next()'
  cmd 'command! Format lua vim.lsp.buf.formatting()'
  cmd 'command! FormatSync lua vim.lsp.buf.formatting_sync()'

  local leader = {
    l = {
      name = 'LSP',
      a = { ':CodeActionMenu<CR>', 'Code Action' },
      r = { '<cmd>LspRenameSymbol<CR>viW', 'Rename Symbol' },
      f = { ':Format<CR>', 'Format Document' },
      x = { ':TroubleToggle<CR>', 'Trouble' },
      q = { '<cmd>lua vim.diagnostic.setloclist()<cr>', 'Quickfix' },
      R = { '<cmd>Telescope lsp_references<cr>', 'References' },
      s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
      S = {
        '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
        'Workspace Symbols',
      },
    },
  }

  local visual = {
    l = {
      name = 'LSP',
      a = { ':CodeActionMenu<CR>', 'Code Action' },
    },
  }

  wk.register(leader, { prefix = '<leader>' })
  wk.register(visual, { prefix = '<leader>', mode = 'x' })

  local function showDocs()
    if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
      vim.fn.execute('h ' .. vim.fn.expand '<cword>')
    else
      vim.fn.execute 'LspHover'
    end
  end

  buf_nnoremap('gd', ':LspGoToDefinition<CR>')
  buf_nnoremap('gi', ':LspImplementations<CR>')
  buf_nnoremap('gr', ':LspReferences<CR>')
  buf_nnoremap('gs', ':LspSignatureHelp<CR>')
  buf_nnoremap('gy', ':LspTypeDefinition<CR>')
  buf_nnoremap('[g', ':LspPrevDiagnostic<CR>')
  buf_nnoremap(']g', ':LspNextDiagnostic<CR>')
  buf_nnoremap('K', showDocs)

  u.inoremap('<c-x><c-x>', '<cmd> LspSignatureHelp<CR>', { buffer = true })

  -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(0, {scope = 'cursor'})]]
end

local function setup(server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server.name == 'sumneko_lua' then
    opts = vim.tbl_deep_extend('force', opts, require('lua-dev').setup {})
  elseif server.name == 'tsserver' then
    local tsserver_settings = require 'user.plugins.lsp.tsserver'
    opts = vim.tbl_deep_extend('force', opts, tsserver_settings)
    opts.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      tsserver_settings.on_attach(client, bufnr)
    end
  elseif server.name == 'jsonls' then
    opts = vim.tbl_deep_extend('force', opts, require 'user.plugins.lsp.json')
  end

  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end

require('user.plugins.lsp.null-ls').setup(on_attach)

lspinstaller.on_server_ready(setup)
