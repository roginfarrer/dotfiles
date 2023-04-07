local wezterm = require("wezterm")

wezterm.on("user-var-changed", function(window, pane, name, value)
	if name == "NEW_WORKSPACE" then
		-- value -> "name=NAME cwd=some/directory/to/open"
		local workspace_name = string.match(value, "name=(%a+) ")
		local cwd = string.match(value, "cwd=(.*)")
		-- window:perform_action(wezterm.action.CloseCurrentTab({ confirm = false }))
		window:perform_action(wezterm.action.SwitchToWorkspace({ name = workspace_name, spawn = { cwd = cwd } }), pane)
	end
	wezterm.log_info("var", name, value)
	if name == "NAVIGATOR_KEY" then
		window:perform_action(wezterm.action.ActivatePaneDirection(value), pane)
	end
end)
