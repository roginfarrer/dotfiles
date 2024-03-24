return {
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        css = { 'stylelint' },
        scss = { 'stylelint' },
        lua = { 'luacheck' },
        vim = { 'vint' },
        bash = { 'shellcheck' },
        sh = { 'shellcheck' },
      },
    },
    config = function(_, opts)
      require('lint').setup(opts)
      require('util').autocmd({ 'BufWritePost', 'InsertLeave' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
