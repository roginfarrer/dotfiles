local M = {}

M.setup = function(config)
	local wezterm = require("wezterm")
	local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

	local function renderWorkspace(name)
		local colors = config.color_scheme and wezterm.color.get_builtin_schemes()[config.color_scheme]
		return wezterm.format({
			{ Attribute = { Italic = true } },
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { Color = colors.ansi[1] } },
			{ Background = { Color = colors.brights[5] } },
			{ Text = " " .. name .. " " },
		})
	end

	local function update_right_status(window, workspace)
		local gui_win = window:gui_window()
		local base_path = string.gsub(workspace, "(.*[/\\])(.*)", "%2")
		gui_win:set_right_status(renderWorkspace(base_path))
	end

	wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", update_right_status)

	wezterm.on("smart_workspace_switcher.workspace_switcher.created", update_right_status)

	wezterm.on("gui-attached", function()
		local mux = wezterm.mux
		local workspace = mux.get_active_workspace()
		for _, window in ipairs(mux.all_windows()) do
			if window:get_workspace() == workspace then
				window:gui_window():set_right_status(renderWorkspace(workspace))
			end
		end
	end)

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
