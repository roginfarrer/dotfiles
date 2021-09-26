vim.g['test#javascript#runner'] = 'jest'

vim.cmd([[
  function! ToggleTermStrategy(cmd) abort
    call luaeval("require('toggleterm').exec(_A[1], _A[2])", [a:cmd, 0])
  endfunction

  let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
]])

-- local function toggleTermStrategy(cmd)
-- 	require('toggleterm').exec(cmd, 1)
-- end

-- vim.g['test#custom_strategies'] = { toggleterm = toggleTermStrategy }

vim.g['test#strategy'] = 'toggleterm'

local function getJestTestCmd()
	local lsputil = require('lspconfig.util')
	local path = lsputil.path

	-- Our default command
	local cmd = 'jest'

	local cwd = vim.loop.cwd()
	-- path of the current buffer, relative to the cwd
	local currentBufferFilePath = vim.fn.expand('%:~:.')

	local pkgJsonParentDir = lsputil.find_package_json_ancestor(
		currentBufferFilePath
	)

	if not pkgJsonParentDir then
		return cmd
	end

	local pkgJsonPath = path.join(cwd, pkgJsonParentDir, 'package.json')

	local file = io.open(pkgJsonPath, 'r')

	if file then
		-- Determine whether or not the directory that contains the package.json
		-- also contains a yarn/npm lock file. This is a janky way of determining
		-- whether or not the workspace is a monorepo
		-- (which means we need to adjust the command accordingly)
		local pathHasLockFile = path.exists(
			path.join(cwd, pkgJsonParentDir, 'yarn.lock')
		) or path.exists(path.join(cwd, pkgJsonParentDir, 'package-lock.json'))
		local isMonorepo = not pathHasLockFile
		-- Check whether or not the working directory is using yarn
		local hasYarn = path.exists(path.join(cwd, 'yarn.lock'))
		local run = hasYarn and 'yarn' or 'npm run'

		local fileContents = file:read('*a')
		local jsonTable = vim.fn.json_decode(fileContents)

		-- What we're expecting the script command to be
		local expectedTestCmd = 'test'
		local testCmd = jsonTable
				and jsonTable.scripts
				and jsonTable.scripts[expectedTestCmd]
			or nil

		if testCmd ~= nil then
			cmd = isMonorepo and run .. ' --cwd ' .. pkgJsonParentDir .. ' ' .. testCmd
				or testCmd
		end

		io.close(file)
	end

	return cmd
end

_G.getJestTestCmd = getJestTestCmd

_G.setJestCmd = function()
	vim.b.jest_test_cmd = vim.b.jest_test_cmd or getJestTestCmd()
	vim.g['test#javascript#jest#executable'] = vim.b.jest_test_cmd
end

vim.cmd([[
  augroup test
    autocmd!
    autocmd BufRead *.tsx,*.ts,*.js,*.jsx call v:lua.setJestCmd()
  augroup END
]])
