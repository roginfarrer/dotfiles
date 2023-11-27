local cmds = {
  'Open',
  'New',
  'QuickSwitch',
  'FollowLink',
  'Today',
  'Yesterday',
  'Template',
  'Search',
  'Link',
  'LinkNew',
  'Workspace',
}
for idx, value in ipairs(cmds) do
  cmds[idx] = 'Obsidian' .. value
end

return {
  {
    'epwalsh/obsidian.nvim',
    event = {
      'BufReadPre ' .. vim.fn.expand '~' .. '/**.md',
      'BufNewFile ' .. vim.fn.expand '~' .. '/**.md',
    },
    cmd = cmds,
    opts = {
      workspaces = {
        {
          name = 'primary',
          path = '~/Obsidian',
        },
      },
    },
  },
}
