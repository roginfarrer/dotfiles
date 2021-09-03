vim.g.dashboard_disable_at_vimenter = 0
vim.g.dashboard_default_executive = 'telescope'
-- vim.g.dashboard_enable_session = 0
vim.g.dashboard_disable_statusline = 0

vim.g.dashboard_custom_header = {
	' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
	' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
	' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
	' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
	' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
	' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}

vim.g.dashboard_custom_footer = {}

vim.g.dashboard_custom_section = {
	a = {
		description = { '  Project File              SPC f p' },
		command = 'Telescope git_files',
	},
	b = {
		description = { '  Find File                 SPC f f' },
		command = 'Telescope find_files',
	},
	c = {
		description = { '  Recents                   SPC f h' },
		command = 'Telescope oldfiles',
	},
	d = {
		description = { '  Projects                  SPC s p' },
		command = 'Telescope projects',
	},
	e = {
		description = { '  Find Word                 SPC f g' },
		command = 'Telescope live_grep',
	},
	-- f = {
	-- 	description = { '洛 New File                  SPC f n' },
	-- 	command = 'DashboardNewFile',
	-- },
	-- f = {
	-- 	description = { '  Load Last Session         SPC l  ' },
	-- 	command = 'SessionLoad',
	-- },
}
