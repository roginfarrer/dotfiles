local lsputil = require 'lspconfig.util'
local p = lsputil.path

-- Our default command
local jestCmd = 'jest'
local cypressCmd = 'cypress'

vim.g['test#javascript#runner'] = 'jest'
vim.g['test#javascript#jest#options'] = '--color=always'
vim.g['test#custom_runners'] = { javascript = { 'vitest' } }

local tt = require 'toggleterm'
local ttt = require 'toggleterm.terminal'

vim.g['test#custom_strategies'] = {
  tterm = function(cmd)
    tt.exec(cmd)
  end,

  tterm_close = function(cmd)
    local term_id = 0
    tt.exec(cmd, term_id)
    print(ttt.get_or_create_term)
    ttt.get_or_create_term(term_id):close()
  end,
}

vim.g['test#strategy'] = 'tterm_close'

local yarn_lock_name = 'yarn.lock'
local npm_lock_name = 'package-lock.json'
local pnpm_lock_name = 'pnpm-lock.yaml'

local function getJestTestCmd()
  local cwd = vim.loop.cwd()
  -- path of the current buffer, relative to the cwd
  local currentBufferFilePath = vim.fn.expand '%:~:.'

  local pkgJsonParentDir = lsputil.find_package_json_ancestor(
    currentBufferFilePath
  )

  if not pkgJsonParentDir then
    vim.b.jest_test_cmd = jestCmd
    vim.b.cypress_test_cmd = cypressCmd
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
    vim.b.cypress_test_cmd = cmd_root .. ' run ' .. cypressCmd

    io.close(file)
  end
end

_G.getJestTestCmd = getJestTestCmd

_G.setJestCmd = function()
  if vim.b.jest_test_cmd == nil then
    getJestTestCmd()
  end
  vim.g['test#javascript#jest#executable'] = vim.b.jest_test_cmd
  vim.g['test#javascript#cypress#executable'] = vim.b.cypress_test_cmd
end

-- autocmd({ 'BufRead' }, {
--   pattern = '*/rainbow-sprinkles/*',
--   callback = function()
--     vim.b.jest_test_cmd = 'pnpm test'
--     vim.g['test#javascript#jest#executable'] = 'pnpm test'
--   end,
--   group = 'local-config',
-- })

-- autocmd('BufEnter', {
--   pattern = {
--     '*.js',
--     '*.jsx',
--     '*.ts',
--     '*.tsx',
--   },
--   callback = function()
--     setJestCmd()
--   end,
--   group = 'get_jest_cmd',
-- })

autocmd('BufRead', {
  pattern = '*/cypress/*',
  command = 'let g:test#javascript#runner = "cypress"',
  group = 'set_cypress_cmd',
})

return { setJestCmd = _G.setJestCmd }
