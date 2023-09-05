local wezterm = require("wezterm")
local act = wezterm.action

require("tab-titles")
require("t-command")

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

-- wezterm.on("gui-startup", function(cmd)
-- 	wezterm.log_info(cmd)
-- end)

return {
	keys = require("tmux"),
	-- keys = {
	-- 	{
	-- 		key = "h",
	-- 		mods = "CTRL",
	-- 		action = require("neovim").left,
	-- 	},
	-- 	{
	-- 		key = "l",
	-- 		mods = "CTRL",
	-- 		action = require("neovim").right,
	-- 	},
	-- 	{
	-- 		key = "k",
	-- 		mods = "CTRL",
	-- 		action = require("neovim").down,
	-- 	},
	-- 	{
	-- 		key = "j",
	-- 		mods = "CTRL",
	-- 		action = require("neovim").up,
	-- 	},
	-- 	{
	-- 		key = "w",
	-- 		mods = "CMD",
	-- 		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	-- 	},
	-- 	{
	-- 		key = "n",
	-- 		mods = "CMD",
	-- 		action = wezterm.action.SplitHorizontal,
	-- 	},
	-- 	{
	-- 		key = "p",
	-- 		mods = "CMD",
	-- 		action = wezterm.action.ActivateCommandPalette,
	-- 	},
	-- 	{
	-- 		key = "z",
	-- 		mods = "ALT",
	-- 		action = wezterm.action.ToggleFullScreen,
	-- 	},
	-- 	{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ShowDebugOverlay },

	-- 	{
	-- 		key = "s",
	-- 		mods = "SHIFT|CTRL",
	-- 		action = wezterm.action.SpawnCommandInNewTab({
	-- 			label = "Wow",
	-- 			args = { "ls" },
	-- 			cwd = wezterm.home_dir .. "/dotfiles/",
	-- 		}),
	-- 	},
	-- 	{
	-- 		key = "d",
	-- 		mods = "SHIFT|CTRL",
	-- 		action = wezterm.action.SpawnCommandInNewTab({
	-- 			label = "W",
	-- 			args = { wezterm.home_dir .. "/dotfiles/wezterm-t" },
	-- 		}),
	-- 	},
	-- 	-- Show the launcher in fuzzy selection mode and have it list all workspaces
	-- 	-- and allow activating one.
	-- 	{
	-- 		key = "f",
	-- 		mods = "SHIFT|CTRL",
	-- 		action = act.ShowLauncherArgs({
	-- 			flags = "FUZZY|WORKSPACES",
	-- 		}),
	-- 	},
	-- },
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font_with_fallback({ "Zed Mono", "Symbols Nerd Font" }),
	allow_square_glyphs_to_overflow_width = "Always",
	cell_width = 1.05,
	font_size = 16,
	line_height = 1.3,
	hide_tab_bar_if_only_one_tab = true,
	adjust_window_size_when_changing_font_size = false,
	use_fancy_tab_bar = false,
	enable_scroll_bar = false,
	default_cursor_style = "SteadyBlock",
	window_decorations = "RESIZE",
	window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 4,
	},
	-- Run a persistent server, like TMUX
	-- unix_domains = { { name = "unix" } },
	-- default_gui_startup_args = { "connect", "unix" },
	-- Basically circumvent the "default" workspace
	-- by automatically creating the "dotfiles" one
	default_workspace = "dotfiles",
	default_cwd = wezterm.home_dir .. "/dotfiles",
}
