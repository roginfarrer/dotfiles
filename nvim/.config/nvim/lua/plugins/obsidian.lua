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
    -- event = {
    --   'BufReadPre ' .. vim.fn.expand '~' .. '/**.md',
    --   'BufNewFile ' .. vim.fn.expand '~' .. '/**.md',
    -- },
    ft = { 'markdown' },
    cond = function()
      return require('plenary.path').is_dir(require('plenary.path'):new '~/Obsidian/ObsidianSync')
    end,
    cmd = cmds,
    opts = {
      workspaces = {
        {
          name = 'ObsidianSync',
          path = '~/Obsidian/ObsidianSync',
        },
      },
      daily_notes = {
        folder = 'daily-notes',
        date_format = '%Y-%m-%d-%a',
        template = 'Daily Note Template',
      },
      templates = {
        folder = 'templates',
        date_format = '%Y-%m-%d-%a',
        substitutions = {
          yesterday = function()
            return os.date('%Y-%m-%d', os.time() - 86400)
          end,
          tomorrow = function()
            return os.date('%Y-%m-%d', os.time() + 86400)
          end,
          yesterday_daily_note = function()
            return os.date('%Y-%m-%d-%a', os.time() - 86400)
          end,
          tomorrow_daily_note = function()
            return os.date('%Y-%m-%d-%a', os.time() + 86400)
          end,
        },
      },
    },
    keys = function()
      local function key(mapping, cmd, opts)
        local base = { '<leader>o' .. mapping, '<cmd>Obsidian' .. cmd .. '<CR>' }
        if opts then
          for k, v in pairs(opts) do
            base[k] = v
          end
          return base
        end
      end
      return {
        key('o', 'Open', { desc = 'Open' }),
        key('n', 'New', { desc = 'New' }),
        key('q', 'QuickSwitch', { desc = 'Quick Switch' }),
        key('b', 'Backlinks', { desc = 'Backlinks' }),
        key('tt', 'Today', { desc = 'Today' }),
        key('to', 'Tomorrow', { desc = 'Tomorrow' }),
        key('y', 'Yesterday', { desc = 'Yesterday' }),
        key('tg', 'Tags', { desc = 'Tags' }),
        key('T', 'Template', { desc = 'Template' }),
        key('s', 'Search', { desc = 'Search' }),
        key('l', 'Link', { desc = 'Link' }),
        key('<CR>', 'ToggleCheckbox', { desc = 'Toggle Checkbox' }),
      }
    end,
    -- config = function(_, opts)
    --   local util = require 'util'
    --   util.autocmd('FileType', {
    --     pattern = { 'markdown' },
    --     group = 'obsidian_md',
    --     callback = function(event)
    --       print('event', vim.print(event))
    --       if util.has 'markview' then
    --         require('markview').setup {
    --           checkboxes = { enable = false },
    --           list_items = { enable = false },
    --         }
    --         vim.cmd 'Markview enable'
    --       end
    --     end,
    --   })
    --   require('markview').setup(opts)
    -- end,
  },
}
