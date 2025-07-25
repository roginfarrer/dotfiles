return {
	{
		'tpope/vim-fugitive',
		enabled = false,
		cmd = {
			'Git',
			'GBrowse',
			'GDelete',
			'GMove',
			'Ggrep',
			'Gwrite',
			'Gread',
			'Gdiffsplit',
			'Gvdiffsplit',
			'Gedit',
		},
		dependencies = { 'tpope/vim-rhubarb' },
		-- keys = {
		--   { '<leader>gc', ':GBrowse!<CR>', desc = 'Copy github url to clipboard' },
		--   { '<leader>gc', ":'<,'>GBrowse!<CR>", desc = 'Copy github url to clipboard', mode = { 'v' } },
		--   { '<leader>go', ':GBrowse<CR><CR>', desc = 'Open file in browser' },
		--   { '<leader>go', ":'<,'>GBrowse<CR><CR>", desc = 'Open file in browser', mode = { 'v' } },
		-- },
	},
	{
		'sindrets/diffview.nvim',
		cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
		keys = {
			{ '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview' },
		},
	},

	{
		'linrongbin16/gitlinker.nvim',
		enabled = true,
		config = function()
			require('gitlinker').setup {
				mappings = nil,
			}
		end,
    -- stylua: ignore
    keys = function() 
            local function action(url) 
                local local_open = vim.fn.expand('$HOME') .. '/bin/open'
                if (vim.fn.filereadable(local_open)) then
                    return  vim.fn.system({local_open, url})
                end
                return require("gitlinker.actions").system(url)
            end
            return
            {
      { '<leader>gc', "<cmd>GitLink<cr>", mode={"n", "v"}, desc = 'Copy github url to clipboard', },
      { '<leader>go',  "<cmd>GitLink!<cr>", mode= {"n", "v"}, desc = 'Open file in browser', },
    }
        end,
	},

	-- git signs highlights text that has changed since the list
	-- git commit, and also lets you interactively stage & unstage
	-- hunks in a commit.
	{
		'lewis6991/gitsigns.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {
			signs = {
				add = { text = '▎' },
				change = { text = '▎' },
				delete = { text = '' },
				topdelete = { text = '' },
				changedelete = { text = '▎' },
				untracked = { text = '▎' },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map('n', "<leader>gk",  gs.next_hunk, "Next Hunk")
        map("n", "<leader>gj", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},

	{
		'TimUntersberger/neogit',
		cmd = 'Neogit',
		opts = {
			kind = 'split',
			signs = {
				-- { CLOSED, OPENED }
				section = { '', '' },
				item = { '', '' },
				hunk = { '', '' },
			},
			integrations = { diffview = true },
		},
		keys = {
			{ '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit' },
		},
	},

	{
		'daliusd/ghlite.nvim',
		opts = {
			keymaps = { -- override default keymaps with the ones you prefer
				diff = {
					open_file = 'gf',
					approve = '<C-A>',
				},
				comment = {
					send_comment = '<C-CR>',
				},
				pr = {
					approve = '<C-A>',
				},
			},
		},
		keys = function()
			local desc = function(str)
				return 'GHLite: ' .. str
			end
			return {
				{ '<leader>u', nil, group = 'GHLite' },
				{ '<leader>us', '<cmd>GHLitePRSelect<cr>', silent = true, desc = desc 'Select PR' },
				{ '<leader>uo', '<cmd>GHLitePRCheckout<cr>', silent = true, desc = desc 'Checkout PR' },
				{ '<leader>uv', '<cmd>GHLitePRView<cr>', silent = true, desc = desc 'View PR' },
				{ '<leader>uu', '<cmd>GHLitePRLoadComments<cr>', silent = true, desc = 'Load PR Comments' },
				{ '<leader>up', '<cmd>GHLitePRDiff<cr>', silent = true, desc = desc 'PR Diff' },
				{ '<leader>ua', '<cmd>GHLitePRAddComment<cr>', silent = true, desc = 'Add Comment' },
				{ '<leader>ug', '<cmd>GHLitePROpenComment<cr>', silent = true, desc = desc 'Open Comment' },
			}
		end,
	},
	{
		'mini.clue',
		optional = true,
		opts = function(_, opts)
			return vim.tbl_deep_extend('keep', opts, {
				clues = {
					{ mode = 'n', keys = '<leader>u', desc = '+ghlite' },
				},
			})
		end,
	},
}
