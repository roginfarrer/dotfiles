local lsputil = require 'lspconfig.util'
local p = lsputil.path

local yarn_lock_name = 'yarn.lock'
local npm_lock_name = 'package-lock.json'
local pnpm_lock_name = 'pnpm-lock.yaml'

local jestCmd = 'jest'

local function getJestTestCmd()
  local cwd = vim.loop.cwd()
  -- path of the current buffer, relative to the cwd
  local currentBufferFilePath = vim.fn.expand '%:~:.'

  local pkgJsonParentDir =
    lsputil.find_package_json_ancestor(currentBufferFilePath)

  if not pkgJsonParentDir then
    vim.b.jest_test_cmd = jestCmd
  end

  local pkgJsonPath = p.join(cwd, pkgJsonParentDir, 'package.json')

  local file = io.open(pkgJsonPath, 'r')

  if file then
    -- Determine whether or not the directory that contains the package.json
    -- also contains a yarn/npm lock file. This is a janky way of determining
    -- whether or not the workspace is a monorepo
    -- (which means we need to adjust the command accordingly)
    local pathHasLockFile = p.exists(
      p.join(cwd, pkgJsonParentDir, yarn_lock_name)
    ) or p.exists(p.join(cwd, pkgJsonParentDir, npm_lock_name)) or p.exists(
      p.join(cwd, pkgJsonParentDir, pnpm_lock_name)
    )
    local isMonorepo = not pathHasLockFile

    local cmd_root

    if p.is_file(p.join(cwd, 'yarn.lock')) then
      cmd_root = isMonorepo and 'yarn --cwd ' .. pkgJsonParentDir or 'yarn'
    elseif p.is_file(p.join(cwd, 'pnpm-lock.yaml')) then
      cmd_root = isMonorepo and 'pnpm ' .. pkgJsonParentDir or 'pnpm'
    else
      cmd_root = isMonorepo and 'npm --cwd ' .. pkgJsonParentDir or 'npm'
    end

    jestCmd = cmd_root .. ' jest' or ' jest'

    vim.b.jest_test_cmd = jestCmd

    io.close(file)
  end
end

-- _G.getJestTestCmd = getJestTestCmd

local setJestCmd = function()
  if vim.b.jest_test_cmd == nil then
    getJestTestCmd()
  end
  vim.g.neotest_jest_cmd = vim.b.jest_test_cmd
end

-- autocmd('BufRead', {
--   pattern = '*.test.*',
--   callback = function()
--     setJestCmd()
--   end,
--   group = 'set_jest_cmd',
-- })

require('neotest').setup {
  icons = {
    -- passed = '',
    -- failed = '',
    -- running = '',
    -- skipped = '',
    -- unknown = '?',
    -- failed = '',
    failed = '',
    passed = '',
    running = '',
    skipped = '',
    unknown = '?',
  },
  adapters = {
    require 'neotest-jest' {
      cwd = function(path)
        local cwd =
          require('neotest-jest.util').find_package_json_ancestor(path)
        return cwd
      end,
    },
  },
}
