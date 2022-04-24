local lsputil = require 'lspconfig.util'
local path = lsputil.path
local exists = path.exists
local join = path.join

local SETTINGS_DIR = '.vim'

local cache = {}

local function load_files(dirname)
  if path.is_dir(dirname) then
    local f = io.popen('ls -d ' .. dirname .. '/*')
    for name in f:lines() do
      print(name)
    end
  else
    print('not a dir', dirname)
  end
end

local function getAbsPath(a, b)
  local cwd = vim.loop.cwd()
  if a and b then
    return path.join(cwd, a, b)
  end
end

local function find_localrc()
  local filepath = vim.fn.expand '%:~:.'
  print('filepath', filepath)
  -- local filepath = vim.fn.expand '<afile>'
  if not filepath then
    return
  end

  local pkgJsonAncestor = lsputil.find_package_json_ancestor(filepath)
  local gitAncestor = lsputil.find_git_ancestor(filepath)

  if pkgJsonAncestor then
    print('packageJsonAncestor', pkgJsonAncestor)
    local dir = getAbsPath(pkgJsonAncestor, SETTINGS_DIR)
    print('is dir', path.is_dir(dir))
    if path.is_dir(getAbsPath(pkgJsonAncestor, SETTINGS_DIR)) then
      print 'made it'
      load_files(getAbsPath(pkgJsonAncestor, SETTINGS_DIR))
    end
  end

  if gitAncestor then
    print('gitAncestor', gitAncestor)
    local dir = getAbsPath(gitAncestor, SETTINGS_DIR)
    print('is dir', path.is_dir(dir))
    if path.is_dir(getAbsPath(gitAncestor, SETTINGS_DIR)) then
      print 'made it'
      load_files(getAbsPath(gitAncestor, SETTINGS_DIR))
    end
  end
end

-- autocmd('BufEnter', {
--   pattern = '*',
--   callback = function()
--     find_localrc()
--   end,
--   group = 'localrc',
-- })
