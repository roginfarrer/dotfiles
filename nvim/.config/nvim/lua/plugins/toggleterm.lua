local Terminal = require('toggleterm.terminal').Terminal

require('toggleterm').setup({
	shell = 'fish',
	open_mapping = [[<C-t>]],
	direction = 'vertical',
	size = function(term)
		if term.direction == 'horizontal' then
			return 15
		elseif term.direction == 'vertical' then
			return vim.o.columns * 0.4
		end
	end,
})

local lazygit = Terminal:new({
	cmd = 'lazygit',
	hidden = true,
	direction = 'window',
})

local function toggleLazyGit()
	lazygit:toggle()
	vim.cmd([[setlocal ft=lazygit]])
end

require('which-key').register({
	['<leader>gt'] = { toggleLazyGit, 'lazygit' },
})
