if not vim.g.vscode then
	return {}
end

local enabled = {
	"dial.nvim",
	"lazy.nvim",
	"mini.ai",
	"mini.surround",
	"Comment.nvim",
	"flash.nvim",
	"gx-extended.nvim",
	"nvim-treesitter",
	"nvim-treesitter-textobjects",
	"nvim-ts-context-commentstring",
	-- 'ts-comments.nvim',
	-- 'yanky.nvim',
	"mini.bracketed",
	"template-string.nvim",
	"treesj",
	"nvim-ts-autotag",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
	return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

local map = require("util").map

local function vscodeNotify(cmd)
	return '<cmd>call VSCodeNotify("' .. cmd .. '")<CR>'
end

map("n", "<C-h>", vscodeNotify("workbench.action.navigateLeft"))
map("n", "<C-l>", vscodeNotify("workbench.action.navigateRight"))
map("n", "<C-k>", vscodeNotify("workbench.action.navigateUp"))
map("n", "<C-j>", vscodeNotify("workbench.action.navigateDown"))

map({ "n", "x" }, "gcc", vscodeNotify("editor.action.commentLine"))
map("n", "gy", vscodeNotify("editor.action.peekTypeDefinition"))
map("n", "gr", vscodeNotify("editor.action.referenceSearch.trigger"))

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
		"nvim-treesitter/nvim-treesitter",
		opts = { highlight = { enable = false } },
	},
}
