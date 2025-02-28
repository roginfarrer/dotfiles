return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
    keys = {
      {
        '=',
        function()
          require('conform').format { async = true }
          vim.notify('Buffer formatted!', vim.log.levels.INFO)
        end,
        desc = 'Format buffer',
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      if vim.fn.executable 'prettierd' then
        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
          group = vim.api.nvim_create_augroup('RestartPrettierd', { clear = true }),
          pattern = '*prettier*',
          callback = function()
            vim.fn.system 'prettierd restart'
          end,
        })
      end
    end,
    opts = function()
      local prettier = { 'prettier', stop_after_first = true }
      require('conform').formatters.phpcbf = {
        prepend_args = {
          '--standard=/home/rfarrer/development/Etsyweb/tests/standards/stable-ruleset.xml',
        },
      }
      return {
        formatters = {
          my_auto_indent = {
            format = function(_, ctx, _, callback)
              -- no range, use whole buffer otherwise use selection
              local cmd = ctx.range == nil and 'gg=G' or '='
              vim.cmd.normal { 'm`' .. cmd .. '``', bang = true }
              callback()
            end,
          },
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          -- Use a sub-list to run only the first available formatter
          javascript = prettier,
          javascriptreact = prettier,
          typescript = prettier,
          typescriptreact = prettier,
          css = prettier,
          html = prettier,
          markdown = prettier,
          mdx = prettier,
          astro = { 'prettier' },
          scss = prettier,
          yaml = prettier,
          json = prettier,
          jsonc = prettier,
          bash = { 'beautysh' },
          sh = { 'beautysh' },
          zsh = { 'beautysh' },
          fish = { 'fish_indent' },
          -- php = { lsp_format = 'first', 'phpcbf' },
          php = { 'my_auto_indent', 'trim_newlines', 'phpcbf' },
        },
        default_format_opts = { lsp_format = 'fallback' },
        log_level = vim.log.levels.DEBUG,
        format_on_save = { timeout_ms = 2000 },
      }
    end,
  },
}
