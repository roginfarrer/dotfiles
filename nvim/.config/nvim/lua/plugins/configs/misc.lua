local M = {}

M.fidget = function()
  require('fidget').setup {}
end

M.stabilize = function()
  require('stabilize').setup()
end

M.devicons = function()
  require('nvim-web-devicons').setup {
    override = {
      lir_folder_icon = {
        icon = '',
        color = '#7ebae4',
        name = 'LirFolderNode',
      },
    },
  }
end

M.colorizer = function()
  vim.o.termguicolors = true
  require('colorizer').setup({}, {
    css = true,
    css_fn = true,
  })
end

M.neoscroll = function()
  -- if not has_gui then
  --   require('neoscroll').setup()
  -- end
end

M.dirbuf = function()
  require('dirbuf').setup {
    sort_order = function(l, r)
      local isdir = vim.fn.isdirectory
      if isdir(l.path) and not isdir(r.path) then
        return -1
      end
      if not isdir(l.path) and isdir(r.path) then
        return 1
      end
      return l.fname:lower() < r.fname:lower()
    end,
  }
end

M.neoclip = function()
  require('neoclip').setup {}
end

M.leap = function()
  require('leap').set_default_keymaps { force = true }
end

-- M.auto_session = function()
--   local HOME = vim.fn.expand '$HOME'
--   require('auto-session').setup {
--     -- auto_sesion_enable_last_session = true,
--     auto_session_use_git_branch = true,
--     auto_session_enable_last_session = false,
--     auto_save_enabled = true,
--     auto_restore_enabled = false,
--     auto_session_suppress_dirs = { '/etc', '/tmp', HOME, HOME .. '/projects' },
--   }
--   require('session-lens').setup {}
-- end

M['git-conflict'] = function()
  require('git-conflict').setup()
end

return M
