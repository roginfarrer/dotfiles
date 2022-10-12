require 'core.utils'

-- impatient.nvim will only be required until https://github.com/neovim/neovim/pull/15436 is merged
if not pcall(require, 'impatient') then
  print 'failed to load impatient.nvim'
end

require 'core'
require 'core.options'

_G.global = {}

require('core.packer').bootstrap()
require 'plugins'
require 'ui.theme'
require 'local-config'
