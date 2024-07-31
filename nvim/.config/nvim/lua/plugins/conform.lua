return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
    keys = {
      {
        '=',
        function()
          require('conform').format { async = true, lsp_fallback = true }
          vim.notify('Buffer formatted!', vim.log.levels.INFO)
        end,
        desc = 'Format buffer',
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = function()
      local prettier = { 'prettier' }
      return {
        formatters_by_ft = {
          lua = { 'stylua' },
          -- Use a sub-list to run only the first available formatter
          javascript = { prettier },
          javascriptreact = { prettier },
          typescript = { prettier },
          typescriptreact = { prettier },
          css = { prettier },
          html = { prettier },
          markdown = { prettier },
          mdx = { prettier },
          astro = { 'prettier' },
          scss = { prettier },
          yaml = { prettier },
          json = { prettier },
          jsonc = { prettier },
          bash = { 'beautysh' },
          sh = { 'beautysh' },
          zsh = { 'beautysh' },
          fish = { 'fish_indent' },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 1000,
        },
      }
    end,
  },
}
