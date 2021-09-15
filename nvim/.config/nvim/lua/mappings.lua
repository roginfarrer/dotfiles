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
end

M.test = function()
	u.nmap('t<C-n>', [[:TestNearest<CR>]])
	u.nmap('t<C-f>', [[:TestFile<CR>]])
	u.nmap('t<C-s>', [[:TestSuite<CR>]])
	u.nmap('t<C-l>', [[:TestLast<CR>]])
	u.nmap('t<C-g>', [[:TestVisit<CR>]])
end

return M
