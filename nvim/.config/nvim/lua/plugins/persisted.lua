return {
  'olimorris/persisted.nvim',
  event = 'BufReadPre',
  cmd = { 'SessionLoad', 'SessionStop', 'SessionLoadLatest' },
  opts = {
    use_git_branch = true,
  },
}
