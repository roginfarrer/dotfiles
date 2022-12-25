local M = {}

M.fidget = function()
  require('fidget').setup {}
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
  require('leap').set_default_keymaps {}
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

M.tabline = function()
  require('tabline').setup {
    enable = false,
    options = { show_filename_only = true },
  }
end

M.jabs = function()
  require('jabs').setup {
    position = 'center',
    offset = {
      bottom = 2,
    },
    preview_position = 'bottom',
  }
end

M.template_string = function()
  require('template-string').setup { remove_template_string = true }
end

M['live-command'] = function()
  require('live-command').setup {
    commands = {
      Norm = { cmd = 'norm' },
    },
  }
end

M.grapple = function()
  local grapple = require 'grapple'
  grapple.setup()
  map('n', '<leader>fk', function()
    grapple.select {}
  end, { desc = 'Select a mark' })

  map('n', '<leader>k', function()
    grapple.toggle {}
  end, { desc = 'Toggle a mark' })

  map('n', ']g', ':GrappleJumpForward')
  map('n', '[g', ':GrappleJumpBackward')
end

M.yanky = function()
  require('yanky').setup {
    preserve_cursor_position = {
      enabled = true,
    },
  }
  vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
  vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
  vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
  vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
  vim.keymap.set('n', '<c-n>', '<Plug>(YankyCycleForward)')
  vim.keymap.set('n', '<c-p>', '<Plug>(YankyCycleBackward)')
  require('telescope').load_extension 'yank_history'
end

return M
