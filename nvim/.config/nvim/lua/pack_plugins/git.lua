vim.schedule(function()
	vim.pack.add {
		-- 'https://github.com/justinmk/guh.nvim',
		'https://github.com/emrearmagan/atlas.nvim',
		'https://github.com/dlyongemallo/diffview-plus.nvim',
		'https://github.com/linrongbin16/gitlinker.nvim',
		'https://github.com/lewis6991/gitsigns.nvim',
		'https://github.com/TimUntersberger/neogit',
	}

	Util.keymap { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview' }
	Util.keymap { '<leader>gc', '<cmd>GitLink<cr>', mode = { 'n', 'v' }, desc = 'Yank git link' }
	Util.keymap { '<leader>go', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = 'Open git link in browser' }
	Util.keymap { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit' }

	require('neogit').setup {
		kind = 'split',
		signs = {
			-- { CLOSED, OPENED }
			section = { '', '' },
			item = { '', '' },
			hunk = { '', '' },
		},
		integrations = { diffview = true, snacks = true, codediff = true },
	}

	require('gitsigns').setup {
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
                map('n', "<leader>gk",  gs.prev_hunk, "Prev Hunk")
                map("n", "<leader>gj", gs.next_hunk, "Next Hunk")
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
	}

	require('atlas').setup {
		providers = {
			github = {},
		},
		pulls = {
			---@type AtlasGitHubPullsConfig
			github = {
				---@type AtlasGitHubViewConfig[]
				views = {
					{
						name = 'My PRs',
						key = '1',
						layout = 'plain', -- "compact", "grouped", or "plain"
						search = 'author:@me sort:updated-desc',
					},
				},

				bookmarks = {
					key = 'S', -- default
					label = 'Search', -- default
					items = {
						['Drafts'] = 'is:pr is:draft author:@me',
						['Recently merged'] = 'is:pr is:merged author:@me sort:updated-desc',
						['Review requested'] = 'is:pr is:open review-requested:@me',
					},
				},
			},
		},
	}
end)
