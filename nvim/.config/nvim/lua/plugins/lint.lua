local ft = { 'vim', 'bash', 'zsh', 'sh' }

return {
  {
    'mfussenegger/nvim-lint',
    -- ft = ft,
    config = function(_, opts)
      require('lint').linters_by_ft = {
        -- css = { 'stylelint' },
        -- scss = { 'stylelint' },
        -- lua = { 'luacheck' },
        vim = { 'vint' },
        bash = { 'shellcheck' },
        zsh = { 'shellcheck' },
        sh = { 'shellcheck' },
      }
      require('util').autocmd({ 'BufEnter', 'BufWritePost' }, {
        group = 'lint',
        pattern = 'vim,sh,zsh',
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
