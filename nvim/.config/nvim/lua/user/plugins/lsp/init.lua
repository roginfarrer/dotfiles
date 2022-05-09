local lspconfig = require 'lspconfig'
local wk = require 'which-key'

local lsp = vim.lsp
local handlers = lsp.handlers

-- local border = 'rounded'
local border = {
  { '🭽', 'FloatBorder' },
  { '▔', 'FloatBorder' },
  { '🭾', 'FloatBorder' },
  { '▕', 'FloatBorder' },
  { '🭿', 'FloatBorder' },
  { '▁', 'FloatBorder' },
  { '🭼', 'FloatBorder' },
  { '▏', 'FloatBorder' },
}

local popup_opts = { border = border }

handlers['textDocument/hover'] = lsp.with(handlers.hover, popup_opts)
handlers['textDocument/signatureHelp'] = lsp.with(
  handlers.signature_help,
  popup_opts
)
vim.diagnostic.config {
  virtual_text = false,
  float = {
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
    max_width = 80,
  },
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

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local function on_attach(client, bufnr)
  if client.supports_method 'textDocument/formatting' then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format {
          filter = function(clients)
            return vim.tbl_filter(function(client)
              return client.name == 'null-ls'
            end, clients)
          end,
          bufnr = bufnr,
        }
      end,
    })
  end

  vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

  local function lsp_cmd(name, func)
    vim.api.nvim_buf_create_user_command(
      bufnr,
      name,
      'lua ' .. func .. '()',
      { force = true }
    )
  end

  lsp_cmd('LspGoToDefinition', 'vim.lsp.buf.definition')
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
      a = { ':LspCodeAction<CR>', 'Code Action' },
      r = { '<cmd>LspRenameSymbol<CR>', 'Rename Symbol' },
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
      a = { ':LspRangeCodeAction<CR>', 'Code Action' },
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

  local function luaDocs()
    if
      vim.bo.filetype == 'lua'
      or vim.bo.filetype == 'help'
      or vim.bo.filetype == 'lua'
    then
      vim.fn.execute('h ' .. vim.fn.expand '<cword>')
    end
  end

  local function bufmap(mode, lhs, rhs)
    map(mode, lhs, rhs, { buffer = true })
  end

  bufmap('n', 'gd', ':LspGoToDefinition<CR>')
  bufmap('n', 'gr', ':LspReferences<CR>')
  bufmap('n', 'gs', ':LspSignatureHelp<CR>')
  bufmap('n', 'gy', ':LspTypeDefinition<CR>')
  bufmap('n', '[g', ':LspPrevDiagnostic<CR>')
  bufmap('n', ']g', ':LspNextDiagnostic<CR>')
  bufmap('n', 'K', showDocs)
  bufmap('n', 'gK', luaDocs)

  bufmap('i', '<c-x><c-x>', '<cmd> LspSignatureHelp<CR>')
end

require('nvim-lsp-installer').setup {
  ensure_installed = {
    'tsserver',
    'sumneko_lua',
    'jsonls',
    'eslint',
    'bashls',
    'cssls',
  },
}

local opts = { on_attach = on_attach, capabilities = capabilities }

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    require('user.plugins.lsp.tsserver').on_attach(client, bufnr)
  end,
}

lspconfig.sumneko_lua.setup(
  vim.tbl_deep_extend('force', opts, require('lua-dev').setup {})
)

lspconfig.jsonls.setup(
  vim.tbl_deep_extend('force', opts, require 'user.plugins.lsp.json')
)

for _, ls in ipairs { 'eslint', 'bashls', 'cssls', 'astro' } do
  lspconfig[ls].setup(opts)
end

require('user.plugins.lsp.null-ls').setup(on_attach)

-- local function setup(server)
--   local opts = {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }

--   if server.name == 'sumneko_lua' then
--     opts = vim.tbl_deep_extend('force', opts, require('lua-dev').setup {})
--   elseif server.name == 'tsserver' then
--     local tsserver_settings = require 'user.plugins.lsp.tsserver'
--     opts = vim.tbl_deep_extend('force', opts, tsserver_settings)
--     opts.on_attach = function(client, bufnr)
--       on_attach(client, bufnr)
--       tsserver_settings.on_attach(client, bufnr)
--     end
--   elseif server.name == 'jsonls' then
--     opts = vim.tbl_deep_extend('force', opts, require 'user.plugins.lsp.json')
--   end

--   server:setup(opts)
--   vim.cmd [[ do User LspAttachBuffers ]]
-- end

-- lspinstaller.on_server_ready(setup)
