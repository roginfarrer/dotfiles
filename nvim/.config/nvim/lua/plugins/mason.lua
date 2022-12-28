local M = {
  'williamboman/mason.nvim',
  dependencies = { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
}

function M.config()
  require('mason').setup {}
  require('mason-tool-installer').setup {
    ensure_installed = {
      -- language servers
      'typescript-language-server',
      'lua-language-server',
      'json-lsp',
      'eslint-lsp',
      'bash-language-server',
      'css-lsp',
      'stylelint-lsp',
      'marksman',
      'yaml-language-server',
      -- Formatters
      'prettierd',
      'stylua',
      'shfmt',
      -- Linters
      'vint',
    },
    -- automatic_installation = true,
  }
end

return M
