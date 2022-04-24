local null_ls = require 'null-ls'
local b = null_ls.builtins

local M = {}

local formatting_callback = function(client)
  local params = vim.lsp.util.make_formatting_params {}
  local bufnr = vim.api.nvim_get_current_buf()
  local result, err = client.request_sync(
    'textDocument/formatting',
    params,
    10000,
    bufnr
  )
  if result and result.result then
    vim.lsp.util.apply_text_edits(result.result, bufnr)
  end
end

M.setup = function(on_attach)
  null_ls.setup {
    debug = false,
    autostart = true,
    sources = {
      b.formatting.prettierd.with {
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
      },
      b.formatting.stylua,
      b.formatting.fish_indent,
      b.formatting.shfmt,
      b.diagnostics.vint.with {
        args = { '--enable-neovim', '-s', '-j', '$FILENAME' },
      },
      b.formatting.trim_newlines.with {
        filtetypes = { 'vim' },
      },
      b.formatting.trim_whitespace.with {
        filtetypes = { 'vim' },
      },
      b.code_actions.gitsigns,
    },
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      if client.resolved_capabilities.document_formatting then
        autocmd('BufWritePre', {
          buffer = bufnr,
          callback = vim.lsp.buf.formatting_sync,
        })
      end
    end,
  }
end

return M
