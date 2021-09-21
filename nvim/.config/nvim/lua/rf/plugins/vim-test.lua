vim.g['test#javascript#runner'] = 'jest'

vim.api.nvim_exec(
	[[
  function! ToggleTermStrategy(cmd) abort
    execute "lua require('toggleterm').exec('" . a:cmd . "', 1)"
  endfunction

  let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
]],
	false
)

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
		-- Check whether or not the working directory is using yarn
		local hasYarn = path.exists(path.join(cwd, 'yarn.lock'))
		local run = hasYarn and 'yarn' or 'npm run'

		local fileContents = file:read('*a')
		local jsonTable = require('lunajson').decode(fileContents)

		-- What we're expecting the script command to be
		local expectedTestCmd = 'test'
		local testCmd = jsonTable.scripts[expectedTestCmd]

		cmd = pathHasLockFile and testCmd
			or run .. ' --cwd ' .. pkgJsonParentDir .. ' ' .. testCmd

		io.close(file)
	end

	return cmd
end

_G.setJestCmd = function()
	vim.g['test#javascript#jest#executable'] = getJestTestCmd()
end

vim.cmd([[
  augroup test
    autocmd!
    autocmd BufRead *.tsx,*.ts,*.js,*.jsx call v:lua.setJestCmd()
  augroup END
]])
