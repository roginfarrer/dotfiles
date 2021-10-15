_G.global = {}

-- Safely require it, in case it doesn't exist
pcall(require, 'local-config')

require('rf.packerInit')
