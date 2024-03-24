return {
  {
    'olimorris/persisted.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      use_git_branch = true,
      should_autosave = function()
        if vim.bo.filetype == 'noice' then
          return false
        end
        return true
      end,
    },
  },
}
