return {
	{
		'kevinhwang91/nvim-ufo',
		event = 'BufReadPost',
		dependencies = { 'kevinhwang91/promise-async' },
		init = function()
			vim.o.foldcolumn = '0' -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
    -- stylua: ignore
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
        desc = 'Open all folds (UFO)',
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
        desc = 'Close all folds (UFO)',
      },
    },
		config = true,
		-- opts = {
		--   provider_selector = function()
		--     return { 'treesitter', 'indent' }
		--   end,
		-- },
	},
}
