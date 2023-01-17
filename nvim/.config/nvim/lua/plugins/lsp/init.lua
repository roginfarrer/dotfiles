local M = {
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'folke/which-key.nvim',
    -- 'glepnir/lspsaga.nvim',
    'folke/neodev.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/typescript.nvim',
  },
}

function M.config()
  vim.diagnostic.config {
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    virtual_text = false,
    float = {
      border = 'rounded',
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

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local function on_attach(client, bufnr)
    require('plugins.lsp.formatting').setup(client, bufnr)
    require('plugins.lsp.mappings').setup(client, bufnr)
  end

  local options = { on_attach = on_attach, capabilities = capabilities }

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

  -- vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

  local servers = {
    sumneko_lua = {},
    tsserver = {},
    eslint = {},
    bashls = {},
    cssls = {},
    astro = {},
    marksman = {},
    html = {},
    jsonls = require 'plugins.lsp.json',
    stylelint_lsp = {
      filetypes = { 'css', 'less', 'scss' },
    },
  }

  require('neodev').setup {}

  for server, opts in pairs(servers) do
    opts = vim.tbl_deep_extend('force', {}, options, opts or {})
    if server == 'tsserver' then
      require('typescript').setup { server = opts }
    else
      require('lspconfig')[server].setup(opts)
    end
  end

  require('plugins.lsp.null-ls').setup(on_attach)
end

return M
