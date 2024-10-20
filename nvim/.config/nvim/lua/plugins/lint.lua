return {
  {
    'mfussenegger/nvim-lint',
    lazy = true,
    config = function(_, opts)
      require('lint').linters_by_ft = {
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
