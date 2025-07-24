return {
	{
		'folke/flash.nvim',
		event = 'VeryLazy',
		opts = {
			modes = { char = { jump = { autojump = true } } },
		},
		init = function()
			local autocmd = require('util').autocmd

			-- local function enableConceal(event)
			--   local hasPlugin, mkview = pcall(require, 'markview')
			--   if hasPlugin and (event.data.ft == 'markdown' or event.data.ft == 'mdx') then
			--     if mkview.state.enable and not mkview.state.buf_states[event.buf] then
			--       vim.cmd 'Markview enable'
			--     end
			--     return
			--   end
			--   vim.o.concealcursor = vim.b.concealcursor
			-- end

			-- local function disableConceal(event)
			--   local hasPlugin, mkview = pcall(require, 'markview')
			--   if hasPlugin and (event.data.ft == 'markdown' or event.data.ft == 'mdx') then
			--     if mkview.state.enable and mkview.state.buf_states[event.buf] then
			--       vim.cmd 'Markview disable'
			--     end
			--     return
			--   end
			--   vim.b.concealcursor = vim.o.concealcursor
			--   vim.o.concealcursor = ''
			-- end

			-- vim.cmd [[autocmd! User FlashEnter]]
			-- vim.cmd [[autocmd! User FlashLeave]]

			-- autocmd('User', {
			--   group = 'flash_markdown_enter',
			--   pattern = 'FlashEnter',
			--   callback = function(ev)
			--     disableConceal(ev)
			--   end,
			-- })
			-- autocmd('User', {
			--   group = 'flash_markdown_leave',
			--   pattern = 'FlashLeave',
			--   callback = function(ev)
			--     enableConceal(ev)
			--   end,
			-- })
		end,
		keys = function()
			local function flashWithAutocmd(cmd, opts)
				return function()
					-- local data = { ft = vim.filetype.match { buf = 0 } }
					-- vim.api.nvim_exec_autocmds('User', {
					--   pattern = 'FlashEnter',
					--   data = data,
					-- })
					require('flash')[cmd](opts)
					-- vim.api.nvim_exec_autocmds('User', {
					--   pattern = 'FlashLeave',
					--   data = data,
					-- })
				end
			end
      -- stylua: ignore
      return {
      { "s", mode = { "n", "o", "x" }, flashWithAutocmd('jump'), desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, flashWithAutocmd('treesitter'), desc = "Flash Treesitter" },
      { "r", mode = "o", flashWithAutocmd('remote'), desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, flashWithAutocmd('treesitter_search'), desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, flashWithAutocmd('toggle'), desc = "Toggle Flash Search" },
    }
		end,
	},
}
