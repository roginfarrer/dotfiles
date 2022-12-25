require 'core.utils'

-- impatient.nvim will only be required until https://github.com/neovim/neovim/pull/15436 is merged
-- if not pcall(require, 'impatient') then
--   print 'failed to load impatient.nvim'
-- end

require 'core.options'
require 'core.commands'

_G.global = {}

require('core.lazy').bootstrap()
require 'plugins.lazy_init'
require 'ui.theme'
require 'local-config'
