local M = {}

M.setup = function(on_attach)
  require('typescript-tools').setup {
    on_attach = function(client, bufnr)
      if on_attach then
        on_attach(client, bufnr)
      end
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
      separate_diagnostic_server = true,
      expose_as_code_action = 'all',
      tsserver_plugins = { '@styled/typescript-styled-plugin' },
      tsserver_file_preferences = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    -- handlers = {
    --   ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
    --     if result.diagnostics == nil then
    --       return
    --     end

    --     -- ignore some tsserver diagnostics
    --     local idx = 1
    --     while idx <= #result.diagnostics do
    --       local entry = result.diagnostics[idx]

    --       local formatter = require('format-ts-errors')[entry.code]
    --       entry.message = formatter and formatter(entry.message) or entry.message

    --       -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
    --       if entry.code == 80001 then
    --         -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
    --         table.remove(result.diagnostics, idx)
    --       else
    --         idx = idx + 1
    --       end
    --     end

    --     vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
    --   end,
    -- },
  }
end

return M
