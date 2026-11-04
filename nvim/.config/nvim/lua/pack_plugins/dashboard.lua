Util.on_event('VimEnter', function()
	vim.pack.add {
		Util.gh 'nvimdev/dashboard-nvim',
	}
	local logo = {
		[[                                                                       ]],
		[[  ██████   █████                   █████   █████  ███                  ]],
		[[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
		[[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
		[[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
		[[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
		[[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
		[[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
		[[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
		[[                                                                       ]],
	}
	for i = 1, 8 do
		table.insert(logo, i, '')
	end
	for _ = 1, 2 do
		table.insert(logo, '')
	end
	local dashboard = {
		theme = 'doom',
		config = {
			header = logo,
			vertical_center = true,
			hide = { statusline = false },
            -- stylua: ignore
			center = {
				{ icon = ' ', key = 'f', desc = ' Find File',        action = ":lua require('seeker').seek{picker_opts = {hidden = true}}", },
				{ icon = ' ', key = 'g', desc = ' Find Text',        action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = ' ', key = 'r', desc = ' Recent Files',     action = ":lua Snacks.dashboard.pick('oldfiles')", },
				{ icon = ' ', key = 'c', desc = ' Config',           action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
				{ icon = '󰕚 ', key = 'd', desc = ' Diffview',         action = ':DiffviewOpen' },
				{ icon = ' ', key = 's', desc = ' Restore Session',  action = ':Persisted load' },
				{ icon = '󰒲 ', key = 'P', desc = ' Plugins',          action = ':Pack' },
				{ icon = ' ', key = 'm', desc = ' Mason',            action = ':Mason' },
				{ icon = ' ', key = 'h', desc = ' Health',           action = ':checkhealth' },
				{ icon = ' ', key = 'q', desc = ' Quit',             action = ':qa' },
			},
		},
	}

	for _, button in ipairs(dashboard.config.center) do
		button.icon_hl = 'SnacksDashboardIcon'
		button.key_hl = 'SnacksDashboardKey'
		button.desc_hl = 'SnacksDashboardDesc'
		button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
		button.key_format = '  %s'
	end

	-- vim.cmd [[StartupTime --save StartTime --hidden]]
	-- local info = _G.StartTime

	require('dashboard').setup(dashboard)
end)
