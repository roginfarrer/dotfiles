if not vim.g.vscode then
	return {}
end

vim.keymap.set('', '<Space>', '<Nop>')
vim.g.mapleader = ' '

local enabled = {
	'dial.nvim',
	'lazy.nvim',
	'mini.surround',
	'Comment.nvim',
	'flash.nvim',
	'gx-extended.nvim',
	'nvim-treesitter',
	'nvim-treesitter-textobjects',
	'nvim-ts-context-commentstring',
	-- 'ts-comments.nvim',
	-- 'yanky.nvim',
	'mini.bracketed',
	'template-string.nvim',
	'treesj',
	'nvim-ts-autotag',
}

local Config = require 'lazy.core.config'
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
	return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

local map = require('util').map

local function vscodeCall(cmd)
	return function()
		require('vscode').call(cmd)
	end
	-- return '<cmd>call VSCodeNotify("' .. cmd .. '")<CR>'
end

map('n', '<C-h>', vscodeCall 'workbench.action.navigateLeft')
map('n', '<C-l>', vscodeCall 'workbench.action.navigateRight')
map('n', '<C-k>', vscodeCall 'workbench.action.navigateUp')
map('n', '<C-j>', vscodeCall 'workbench.action.navigateDown')

map('x', 'gc', vscodeCall 'editor.action.commentLine')
map('n', 'gcc', vscodeCall 'editor.action.commentLine')
map('n', 'gy', vscodeCall 'editor.action.peekTypeDefinition')
map('n', 'gr', vscodeCall 'editor.action.referenceSearch.trigger')

map('n', '<leader>gr', vscodeCall 'git.revertChange')
map('n', '<leader>la', vscodeCall 'editor.action.codeAction')
map('n', '<leader>lr', vscodeCall 'editor.action.rename')

-- map("n", "<leader>;", vscodeCall("workbench.action.showAllEditors"))
map('n', '<leader>b', vscodeCall 'workbench.action.showAllEditors')

map('n', '<leader>;', vscodeCall 'vscode-harpoon.editorQuickPick')
map('n', '<leader>hh', vscodeCall 'vscode-harpoon.editorQuickPick')
map('n', '<leader>ha', vscodeCall 'vscode-harpoon.addEditor')
map('n', '<leader>he', vscodeCall 'vscode-harpoon.editEditors')
map('n', '<leader>h1', vscodeCall 'vscode-harpoon.gotoEditor1')
map('n', '<leader>h2', vscodeCall 'vscode-harpoon.gotoEditor2')
map('n', '<leader>h3', vscodeCall 'vscode-harpoon.gotoEditor3')
map('n', '<leader>h4', vscodeCall 'vscode-harpoon.gotoEditor4')
map('n', '<leader>h5', vscodeCall 'vscode-harpoon.gotoEditor5')

-- These don't work! They're set in the keybindings.json file
-- map("n", "]d", vscodeCall("editor.action.marker.next"))
-- map("n", "[d", vscodeCall("editor.action.marker.prev"))

-- -- Add some vscode specific keymaps
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'LazyVimKeymapsDefaults',
--   callback = function()
--     vim.keymap.set('n', '<leader><space>', '<cmd>Find<cr>')
--     vim.keymap.set('n', '<leader>/', [[<cmd>call VSCodeNotify('workbench.action.findInFiles')<cr>]])
--     vim.keymap.set('n', '<leader>ss', [[<cmd>call VSCodeNotify('workbench.action.gotoSymbol')<cr>]])
--   end,
-- })

return {
	-- {
	--   'LazyVim/LazyVim',
	--   config = function(_, opts)
	--     opts = opts or {}
	--     -- disable the colorscheme
	--     opts.colorscheme = function() end
	--     require('lazyvim').setup(opts)
	--   end,
	-- },
	{
		'nvim-treesitter/nvim-treesitter',
		opts = { highlight = { enable = false } },
	},
}
