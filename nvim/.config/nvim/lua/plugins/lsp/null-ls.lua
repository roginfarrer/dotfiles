local null_ls = require 'null-ls'
local b = null_ls.builtins

local M = {}

M.setup = function(on_attach)
  null_ls.setup {
    debug = false,
    autostart = true,
    sources = {
      b.formatting.prettier.with {
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
          'astro',
        },
        -- For astro
        -- https://docs.astro.build/en/editor-setup/#prettier
        extra_args = { '--plugin-search-dir=.' },
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
    on_attach = on_attach,
  }
end

return M
