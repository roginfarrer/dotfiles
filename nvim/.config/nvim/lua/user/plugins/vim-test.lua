local lsputil = require 'lspconfig.util'
local path = lsputil.path

-- Our default command
local jestCmd = 'jest'
local cypressCmd = 'cypress'

vim.g['test#javascript#runner'] = 'jest'

vim.cmd [[
  function! ToggleTermStrategy(cmd) abort
    call luaeval("require('toggleterm').exec(_A[1], _A[2])", [a:cmd, 0])
  endfunction

  let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
]]

vim.g['test#strategy'] = 'toggleterm'

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

  local pkgJsonPath = path.join(cwd, pkgJsonParentDir, 'package.json')

  local file = io.open(pkgJsonPath, 'r')

  if file then
    -- Determine whether or not the directory that contains the package.json
    -- also contains a yarn/npm lock file. This is a janky way of determining
    -- whether or not the workspace is a monorepo
    -- (which means we need to adjust the command accordingly)
    local pathHasLockFile = path.exists(
      path.join(cwd, pkgJsonParentDir, yarn_lock_name)
    ) or path.exists(path.join(cwd, pkgJsonParentDir, npm_lock_name)) or path.exists(
      path.join(cwd, pkgJsonParentDir, pnpm_lock_name)
    )
    local isMonorepo = not pathHasLockFile

    if path.is_file(path.join(path, 'yarn.lock')) then
      vim.b.javascript_cmd_root = isMonorepo
          and 'yarn --cwd ' .. pkgJsonParentDir
        or 'yarn'
    elseif path.is_file(path.join(path, 'pnpm-lock.yaml')) then
      vim.b.javascript_cmd_root = isMonorepo and 'pnpm ' .. pkgJsonParentDir
        or 'pnpm '
      vim.b.javascript_cmd_root = 'pnpm '
    else
      vim.b.javascript_cmd_root = isMonorepo
          and 'npm --cwd ' .. pkgJsonParentDir
        or 'npm '
    end

    jestCmd = vim.b.javascript_cmd_root .. ' jest' or 'jest'

    vim.b.jest_test_cmd = jestCmd
    vim.b.cypress_test_cmd = vim.b.javascript_cmd_root .. ' run ' .. cypressCmd

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

vim.cmd [[
  augroup test
    autocmd!
    autocmd BufEnter * lua _G.setJestCmd()
    " autocmd FileType javascript,javascriptreact,typescript,typescriptreact lua _G.setJestCmd()
    autocmd BufRead */cypress/* let g:test#javascript#runner = 'cypress'
  augroup END
]]
