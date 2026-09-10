return {
	{
		'celeste3z/celeste_comment.nvim',
		lazy = false,
		opts = {},
		init = function()
			vim.o.commentstring = ''
			vim.o.comments = ''
		end,
	},

	{
		'numToStr/Comment.nvim',
		enabled = false,
		keys = {
			{ 'gc', mode = { 'n', 'x' } },
			{ 'gb', mode = { 'n', 'x' } },
		},
		dependencies = {
			{ 'JoosepAlviste/nvim-ts-context-commentstring', opts = {} },
			'nvim-treesitter/nvim-treesitter',
		},
		opts = function()
			---@module 'Comment.nvim'
			---@type CommentConfig | {} User configuration
			return {
				-- ignore empty lines
				ignore = '^$',
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			}
		end,
		config = function(_, opts)
			-- using "config" instead of "opts" because requiring ts_context_commentstring throws error
			require('Comment').setup(opts)
		end,
	},
}
