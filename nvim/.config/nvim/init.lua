_G.global = {}
require 'core.utils'
require 'core.filetype'
require 'core.options'
require 'core.lazy'

require 'core.commands'
require 'core.mappings'
require 'core.context_menu'
require 'local-config'

if vim.fn.has 'gui_running' then
  require 'core.gui'
end

vim.cmd.colorscheme 'catppuccin'
