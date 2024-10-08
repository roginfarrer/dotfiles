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
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        group = vim.api.nvim_create_augroup('RestartPrettierd', { clear = true }),
        pattern = '*prettier*',
        callback = function()
          vim.fn.system 'prettierd restart'
        end,
      })
    end,
    opts = function()
      local prettier = { 'prettier' }
      return {
        stop_after_first = true,
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
          timeout_ms = 2000,
        },
      }
    end,
  },
}
