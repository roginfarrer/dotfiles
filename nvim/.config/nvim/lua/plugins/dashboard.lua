vim.g.dashboard_disable_at_vimenter = 0
vim.g.dashboard_default_executive = 'telescope'
-- vim.g.dashboard_enable_session = 0
vim.g.dashboard_disable_statusline = 0

vim.g.dashboard_custom_header = {
	'',
	'',
	'',
	'',
	'',
	'',
	' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
	' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
	' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
	' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
	' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
	' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}

vim.g.dashboard_custom_footer = {
	vim.fn.getcwd(),
}

vim.g.dashboard_custom_section = {
	a = {
		description = { '  Dotfiles                  SPC f d' },
		command = 'e ~/dotfiles/nvim/.config/nvim/lua/pluginList.lua',
	},
	b = {
		description = { '  Project File              SPC f p' },
		command = 'Telescope git_files',
	},
	c = {
		description = { '  Find File                 SPC f f' },
		command = 'Telescope find_files',
	},
	d = {
		description = { '  Recents                   SPC f h' },
		command = 'Telescope oldfiles',
	},
	e = {
		description = { '  Projects                  SPC s p' },
		command = 'Telescope projects',
	},
	f = {
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
