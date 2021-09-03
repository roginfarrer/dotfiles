local u = require('utils')

local M = {}

M.gitlinker = function()
	function _G.gitCopyToClipboard(range)
		local mode = range > 0 and 'v' or 'n'
		require('gitlinker').get_buf_range_url(
			mode,
			{ action_callback = require('gitlinker.actions').copy_to_clipboard }
		)
	end
	function _G.gitOpenInBrowser(range)
		local mode = range > 0 and 'v' or 'n'
		require('gitlinker').get_buf_range_url(
			mode,
			{ action_callback = require('gitlinker.actions').open_in_browser }
		)
	end

	vim.cmd([[
		command! -nargs=0 -range GitCopyToClipboard call v:lua.gitCopyToClipboard(<range>)
	]])
	vim.cmd([[
		command! -nargs=0 -range GitOpenInBrowser call v:lua.gitOpenInBrowser(<range>)
	]])

	-- u.nnoremap('<leader>gc', [[:GitCopyToClipboard<CR>]])
	u.vnoremap('<leader>gc', [[:'<,'>GitCopyToClipboard<CR>]])
	-- u.nnoremap('<leader>go', [[:GitOpenInBrowser<CR>]])
	u.vnoremap('<leader>go', [[:'<,'>GitOpenInBrowser<CR>]])
end

M.floatterm = function()
	u.nnoremap('<C-t>', [[:FloatermToggle<CR>]], { silent = true })
	u.tnoremap('<C-t>', [[<C-\><C-n>:FloatermToggle<CR>]], { silent = true })
end

M.test = function()
	u.nmap('t<C-n>', [[:TestNearest<CR>]])
	u.nmap('t<C-f>', [[:TestFile<CR>]])
	u.nmap('t<C-s>', [[:TestSuite<CR>]])
	u.nmap('t<C-l>', [[:TestLast<CR>]])
	u.nmap('t<C-g>', [[:TestVisit<CR>]])
end

M.neogit = function()
	-- u.nnoremap('<leader>gg', ':Neogit<CR>')
end

M.telescope = function()
	local finders = require('telescope.finders')
	local pickers = require('telescope.pickers')

	local conf = require('telescope.config').values

	local function searchDotfiles()
		require('telescope.builtin').git_files({
			cwd = '~/dotfiles',
			prompt = '~ dotfiles ~',
		})
	end

	local function arglist(opts)
		opts = opts or {}
		local locations = vim.fn.argv()

		if vim.tbl_isempty(locations) then
			return
		end

		pickers.new(opts, {
			prompt_title = 'Quickfix',
			finder = finders.new_table(locations),
			previewer = conf.qflist_previewer(opts),
			sorter = conf.generic_sorter(opts),
		}):find()
	end

	-- u.nnoremap('<Leader>fp', [[<cmd>Telescope git_files<CR>]])
	-- u.nnoremap('<Leader>f.', [[<cmd>Telescope find_files<CR>]])
	-- u.nnoremap(
	-- 	'<Leader>fg',
	-- 	"<cmd> lua require('telescope').extensions.fzf_writer.staged_grep()<CR>"
	-- )
	-- u.nnoremap('<leader>fb', [[<cmd>Telescope buffers<CR>]])
	-- u.nnoremap('<leader>fd', searchDotfiles)
	-- u.nnoremap('<leader>fa', arglist)
	-- u.nnoremap('<Leader>fh', [[<cmd>Telescope oldfiles<CR>]])

	-- u.nnoremap('<C-p>', [[<cmd>Telescope git_files<CR>]])
	-- u.nnoremap('<leader>;', [[<cmd>Telescope buffers<CR>]])
end

M.packer = function()
	u.nnoremap('<leader>pp', ':PackerSync<CR>')
	u.nnoremap('<leader>ps', ':PackerStatus<CR>')
	u.nnoremap('<leader>pi', ':PackerInstall<CR>')
	u.nnoremap('<leader>pc', ':PackerCompile<CR>')
end

return M
