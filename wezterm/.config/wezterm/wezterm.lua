local wezterm = require("wezterm")
local act = wezterm.action

require("tab-titles")
-- require("t-command")

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.set_zoxide_path("/opt/homebrew/bin/zoxide")

local function base_path_name(str)
	return string.gsub(str, "(.*[/\\])(.*)", "%2")
end

local function update_right_status(window)
	local title = base_path_name(window:active_workspace())
	window:set_right_status(wezterm.format({
		{ Text = title .. " " },
	}))
end

wezterm.on("update-right-status", function(window, _)
	update_right_status(window)
end)

workspace_switcher.set_workspace_formatter(function(label)
	local colors = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
	return wezterm.format({
		{ Attribute = { Italic = true } },
		{ Foreground = { Color = colors.tab_bar.active_tab.fg_color } },
		{ Background = { Color = colors.tab_bar.active_tab.bg_color } },
		{ Text = "󱂬: " .. label },
	})
end)
-- wezterm.on("update-right-status", function(window, pane)
-- 	window:set_right_status(window:active_workspace())
-- end)

local keys = {
	{
		key = "s",
		mods = "CMD",
		action = workspace_switcher.switch_workspace(),
	},
	{
		key = "h",
		mods = "CTRL",
		action = require("neovim").left,
	},
	{
		key = "l",
		mods = "CTRL",
		action = require("neovim").right,
	},
	{
		key = "k",
		mods = "CTRL",
		action = require("neovim").down,
	},
	{
		key = "j",
		mods = "CTRL",
		action = require("neovim").up,
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "n",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal,
	},
	{
		key = "p",
		mods = "CMD",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		key = "z",
		mods = "ALT",
		action = wezterm.action.ToggleFullScreen,
	},

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
	{
		key = "f",
		mods = "SHIFT|CTRL",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
}

local config = {
	keys = require("tmux"),
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font_with_fallback({ "Zed Mono", "Symbols Nerd Font" }),
	allow_square_glyphs_to_overflow_width = "Always",
	cell_width = 1.05,
	font_size = 15,
	line_height = 1.2,
	hide_tab_bar_if_only_one_tab = true,
	adjust_window_size_when_changing_font_size = false,
	use_fancy_tab_bar = false,
	enable_scroll_bar = false,
	default_cursor_style = "SteadyBlock",
	window_decorations = "RESIZE",
	-- window_padding = {
	-- 	left = 4,
	-- 	right = 4,
	-- 	top = 4,
	-- 	bottom = 4,
	-- },
	window_padding = {
		left = 30,
		right = 30,
		top = 20,
		bottom = 10,
	},
	-- Basically circumvent the "default" workspace
	-- by automatically creating the "dotfiles" one
	default_workspace = "dotfiles",
	default_cwd = wezterm.home_dir .. "/dotfiles",
	window_close_confirmation = "NeverPrompt",
	native_macos_fullscreen_mode = false,
	cursor_blink_rate = 0,
}

-- Workspaces
-- Run a persistent server, like TMUX
-- config.unix_domains = { { name = "unix" } },
-- config.default_gui_startup_args = { "connect", "unix" },
-- config.hide_tab_bar_if_only_one_tab = false
-- config.keys = keys

return config
