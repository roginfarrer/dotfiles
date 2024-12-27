local M = {}

M.setup = function(config)
	local wezterm = require("wezterm")
	local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

	local function update_right_status(window, workspace)
		local gui_win = window:gui_window()
		local base_path = string.gsub(workspace, "(.*[/\\])(.*)", "%2")
		local colors = config.color_scheme and wezterm.colors.get_builtin_schemes()[config.color_scheme]
		gui_win:set_right_status(wezterm.format({
			{ Attribute = { Italic = true } },
			{ Foreground = { Color = colors.ansi[1] } },
			{ Background = { Color = colors.brights[5] } },
			{ Text = base_path .. "  " },
		}))
	end

	wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", update_right_status)

	wezterm.on("smart_workspace_switcher.workspace_switcher.created", update_right_status)

	table.insert(config.keys, {
		key = "t",
		mods = "LEADER",
		action = workspace_switcher.switch_workspace(),
	})
	table.insert(config.keys, {
		key = "s",
		mods = "CMD",
		action = workspace_switcher.switch_workspace(),
	})
end

return M
