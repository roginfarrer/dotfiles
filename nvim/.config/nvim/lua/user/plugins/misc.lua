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

M.lspkind = function()
  require('lspkind').init { preset = 'codicons' }
end

M.mini = function()
  require('mini.surround').setup {}
end

M.colorizer = function()
  vim.o.termguicolors = true
  require('colorizer').setup({}, {
    css = true,
    css_fn = true,
  })
end

M.neoscroll = function()
  if not has_gui then
    require('neoscroll').setup()
  end
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

return M
