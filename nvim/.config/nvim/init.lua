vim.loader.enable()

pcall(require, 'local-config')
require 'config.lazy'
require 'config.filetype'
