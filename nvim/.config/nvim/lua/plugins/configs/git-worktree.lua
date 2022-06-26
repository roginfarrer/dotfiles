local Worktree = require 'git-worktree'
local Job = require 'plenary.job'
local scan = require 'plenary.scan'

-- function get_node_modules()
--   return scan.scan_dir(vim.env.HOME .. '/projects/homebase-bare/main', {
--     respect_gitignore = false,
--     only_dirs = true,
--     search_pattern = function(entry)
--       return entry:match '(.*)node_modules$'
--         and not entry:match '(.*)node_modules(.*)node_modules'
--     end,
--   })
-- end

-- Worktree.on_tree_change(function(op, metadata)
--   if op == Worktree.Operations.Create then
--     local path = Worktree.Operations.Create.path
--     if path:match 'homebase-bare' then
--       Job:new {
--         cmd = 'yarn',
--         cwd = path,
--       }
--     end
--   end
-- end)
