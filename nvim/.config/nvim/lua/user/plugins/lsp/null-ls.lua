local null_ls = require 'null-ls'
local b = null_ls.builtins

local M = {}

M.setup = function(on_attach)
  null_ls.setup {
    debug = true,
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
        -- autocmd('BufWritePre', {
        --   buffer = 0,
        --   callback = function()
        --     vim.lsp.buf.formatting_sync()
        --   end,
        -- }, 'LspFormatting')
        vim.cmd [[
            augroup LspFormatting
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
          ]]
      end
    end,
  }
end

return M
