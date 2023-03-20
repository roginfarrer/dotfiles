local M = {}

function M.setup(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
    vim.lsp.buf.format {
      filter = function(c)
        if c.name == 'rust_analyzer' then
          return true
        end
        return c.name == 'null-ls'
      end,
      bufnr = bufnr,
    }
  end, {})

  if client.supports_method 'textDocument/formatting' then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('LspFormatting.' .. bufnr, {}),
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
