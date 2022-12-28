local M = {}

function M.setup(client, bufnr)
  local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

  if client.supports_method 'textDocument/formatting' then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format {
          filter = function(c)
            return c.name == 'null-ls'
          end,
          bufnr = bufnr,
        }
      end,
    })
  end
end

return M
