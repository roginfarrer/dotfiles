local snap = require('snap')
local io = snap.get('common.io')

local defaults = {
	reverse = true,
}

local function mergeDefaults(obj)
	for k, v in pairs(defaults) do
		obj[k] = v
	end
	return obj
end

local function file(obj)
	return snap.config.file(mergeDefaults(obj))
end

-- Runs ls and yields lua tables containing each line
local function getDotfiles(request)
	local cwd = snap.sync(vim.fn.getcwd)
	-- Iterates ls commands output using snap.io.spawn
	for data, err, kill in io.spawn('git', {
		'--git-dir',
		'/Users/rfarrer/.dotfiles/',
		'ls-tree',
		'--full-tree',
		'-r',
		'--name-only',
		'HEAD',
	}, cwd) do
		-- If the filter updates while the command is still running
		-- then we kill the process and yield nil
		if request.canceled() then
			-- If there is an error we yield nil
			kill()
			coroutine.yield(nil)
		elseif err ~= '' then
			-- If the data is empty we yield an empty table
			coroutine.yield(nil)
		elseif data == '' then
			-- If there is data we split it by newline
			coroutine.yield({})
		else
			local splitLines = vim.split(data, '\n', true)
			for index, value in pairs(splitLines) do
				splitLines[index] = '/Users/rfarrer/' .. value
			end
			coroutine.yield(splitLines)
		end
	end
end

local function getSortedBufferList()
	-- Hacky way to get the list of buffers sorted by recency
	-- There's no programmatic way to get this AFAIK
	-- But the ":buffers t" command does sort it correctly
	-- This redirects the output of the command to a register,
	-- then assigns the contents of that register to a global variable
	-- we can access
	vim.cmd([[ 
    let temp_reg = @"
    redir @"
    execute "buffers t"
    redir END
    let output = copy(@")
    let g:raw_buffer_list = output
    let @" = temp_reg
  ]])

	-- This is now a multiline string of the buffer list
	-- We need to trim this down into a table of filepaths
	local rawBuffers = vim.g.raw_buffer_list
	local splitLines = vim.split(rawBuffers, '\n', false)
	local result = {}

	-- The filepaths always start at this index
	local quoteStart = 11

	for _, line in pairs(splitLines) do
		-- Identify the index position of the closing quote
		local endIndex = string.find(line, '"', quoteStart)
		if type(endIndex) == 'number' then
			-- grab the string between the quotes
			local filename = string.sub(line, quoteStart, endIndex - 1)
			table.insert(result, filename)
		end
	end

	return result
end

local function bufferProducer(request)
	-- Runs the slow-mode to get the buffers
	local result = snap.sync(getSortedBufferList)

	-- Move the active buffer (first filepath)
	-- to the bottom of the list
	local currentBuffer = result[1]
	table.remove(result, 1)
	table.insert(result, currentBuffer)

	if request.canceled() then
		coroutine.yield(nil)
	else
		coroutine.yield(result)
	end
end

snap.maps({
	{ '<leader>fp', file({ producer = 'git.file' }) },
	-- {"<leader>;", file({producer = "vim.buffer"})},
	{ '<leader>;', file({ prompt = 'BUFFERS', producer = bufferProducer }) },
	{ '<Leader>fh', file({ producer = 'vim.oldfile' }) },
	{ '<leader>fg', snap.config.vimgrep(mergeDefaults({})) },
	{ '<leader>f.', file({ producer = 'fd.file' }) },
	{
		'<leader>fd',
		file({
			prompt = 'DOTFILES',
			producer = getDotfiles,
		}),
	},
})

-- The default character highlighting is incredibly distracting
-- this makes the highlighting a bit more reasonable
vim.cmd([[ execute('highlight! link SnapPosition Constant') ]])
