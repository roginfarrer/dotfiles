local u = require('rf.utils')
local lspconfig = require('lspconfig')
local lspinstaller = require('nvim-lsp-installer')
local lspstatus = require('lsp-status')
local wk = require('which-key')

local lsp = vim.lsp
local handlers = lsp.handlers
local cmd = vim.cmd

lspstatus.register_progress()

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local function buf_nnoremap(keys, command)
  return u.nnoremap(keys, command, { buffer = true })
end

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

local popup_opts = {
  border = border,
  focusable = false,
}
_G.global.popup_opts = popup_opts

handlers['textDocument/hover'] = lsp.with(handlers.hover, popup_opts)
handlers['textDocument/signatureHelp'] = lsp.with(
  handlers.signature_help,
  popup_opts
)
handlers['textDocument/publishDiagnostics'] = lsp.with(
  lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    signs = true,
    virtual_text = false,
  }
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
if isPackageLoaded('cmp_nvim_lsp') then
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
end
capabilities = vim.tbl_extend('keep', capabilities, lspstatus.capabilities)

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

local function on_attach(client, bufnr)
  lspstatus.on_attach(client)
  require('lsp_signature').on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    hint_prefix = '● ',
    handler_opts = {
      border = popup_opts.border,
    },
  }, bufnr)

  vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

  cmd('command! LspGoToDefinition lua vim.lsp.buf.definition()')
  cmd('command! LspGoToDeclaration lua vim.lsp.buf.declaration()')
  cmd('command! LspHover lua vim.lsp.buf.hover()')
  cmd('command! LspImplementations lua vim.lsp.buf.implementation()')
  cmd('command! LspSignatureHelp lua vim.lsp.buf.signature_help()')
  cmd('command! LspTypeDefinition lua vim.lsp.buf.type_definition()')
  cmd('command! LspRenameSymbol lua vim.lsp.buf.rename()')
  cmd('command! LspCodeAction lua vim.lsp.buf.code_action()')
  cmd('command! LspRangeCodeAction lua vim.lsp.buf.range_code_action()')
  cmd('command! LspReferences lua vim.lsp.buf.references()')
  cmd(
    'command! LspPrevDiagnostic lua vim.diagnostic.goto_prev({popup_opts = global.popup_opts})'
  )
  cmd(
    'command! LspNextDiagnostic lua vim.diagnostic.goto_next({popup_opts = global.popup_opts})'
  )
  cmd('command! Format lua vim.lsp.buf.formatting()')
  cmd('command! FormatSync lua vim.lsp.buf.formatting_sync()')

  local leader = {
    l = {
      name = 'LSP',
      a = { ':CodeActionMenu<CR>', 'Code Action' },
      r = { ':LspRenameSymbol<CR>', 'Rename Symbol' },
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
      vim.fn.execute('h ' .. vim.fn.expand('<cword>'))
    else
      vim.fn.execute('LspHover')
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

  -- vim.cmd(
  -- 	[[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics(global.popup_opts)]]
  -- )
  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
      augroup Formatter
        autocmd!
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]])
  end
end

local null_ls = require('null-ls')
local null_ls_builtins = null_ls.builtins

require('null-ls').config({
  debug = true,
  sources = {
    null_ls_builtins.formatting.prettierd.with({
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
        'svelte',
        'css',
        'scss',
        'html',
        'json',
        'yaml',
        'markdown',
        'markdown.mdx',
      },
    }),
    null_ls_builtins.formatting.stylua,
    null_ls_builtins.formatting.fish_indent,
    null_ls_builtins.formatting.shfmt,
    null_ls_builtins.diagnostics.vint.with({
      args = { '--enable-neovim', '-s', '-j', '$FILENAME' },
    }),
    -- null_ls_builtins.formatting.trim_newlines.with({
    --   filtetypes = { 'vim' },
    -- }),
    null_ls_builtins.formatting.trim_whitespace.with({
      filtetypes = { 'vim' },
    }),
    null_ls_builtins.code_actions.gitsigns,
  },
})
lspconfig['null-ls'].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

local function setup(server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server.name == 'sumneko_lua' then
    opts.settings = {
      Lua = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        runtime = {
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          globals = {
            -- Get the language server to recognize the `vim` global
            'vim',
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  elseif server.name == 'tsserver' then
    opts.on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      on_attach(client, bufnr)

      local ts_utils = require('nvim-lsp-ts-utils')

      ts_utils.setup({
        debug = false,
        -- eslint
        enable_import_on_completion = true,
        eslint_enable_code_actions = false,
        eslint_bin = 'eslint_d',
        eslint_enable_diagnostics = false,
        eslint_opts = {
          condition = function(utils)
            return utils.root_has_file('.eslintrc.js')
              or utils.root_has_file('.eslintrc.json')
              or utils.root_has_file('.git')
              or utils.root_has_file('package.json')
              or utils.root_has_file('tasconfig.json')
          end,
          diagnostics_format = '#{m} [#{c}]',
        },
      })
      ts_utils.setup_client(client)

      local leader = {
        l = {
          o = { ':TSLspOrganize<CR>', '(TS) Organize Imports' },
          i = { ':TSLspImportAll<CR>', '(TS) Import Missing Imports' },
          R = { ':TSLspRenameFile<CR>', '(TS) Rename File' },
        },
      }
      wk.register(leader, { prefix = '<leader>', buffer = bufnr })
    end
  elseif server.name == 'jsonls' then
    opts.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end
  server:setup(opts)
  vim.cmd([[ do User LspAttachBuffers ]])
end

lspinstaller.on_server_ready(setup)
