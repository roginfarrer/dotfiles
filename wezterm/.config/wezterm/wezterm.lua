local wezterm = require("wezterm")
local act = wezterm.action

local leader = "\x01" -- CTRL-A
local function tkey(mod, key, str)
	return {
		key = key,
		mods = mod,
		action = act.SendString(leader .. str),
	}
end

local tmux_keys = {
	-- Select window 1-9
	tkey("CMD", "1", "\x31"),
	tkey("CMD", "2", "\x32"),
	tkey("CMD", "3", "\x33"),
	tkey("CMD", "4", "\x34"),
	tkey("CMD", "5", "\x35"),
	tkey("CMD", "6", "\x36"),
	tkey("CMD", "7", "\x37"),
	tkey("CMD", "8", "\x38"),
	tkey("CMD", "9", "\x39"),
	-- Select a new tmux session for the attached client interactively
	tkey("CMD", "k", "\x73"),
	-- Change to the previous tmux window
	tkey("CMD", "[", "\x70"),
	-- Change to the next tmux window
	tkey("CMD", "]", "\x6e"),
	-- Split the current pane into two, left and right
	tkey("CMD|SHIFT", "n", "\x22"),
	-- Split the current pane into two, top and bottom.
	tkey("CMD", "n", "\x25"),
	-- Detach the current tmux client
	tkey("CMD", "q", "\x64"),
	-- Create a new tmux window
	tkey("CMD", "t", "\x63"),
	-- Break the current tmux pane out of the tmux window
	tkey("CMD", "t", "\x21"),
	-- Kill the current tmux pane (and window if last pane)
	tkey("CMD", "w", "\x78"),
	-- Toggle the zoom state of the current tmux pane
	tkey("CMD", "z", "\x7a"),
}

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

return {
	-- enable_csi_u_key_encoding = true,
	-- debug_key_events = true,
	keys = tmux_keys,
	-- keys = {
	-- 	{
	-- 		key = "z",
	-- 		mods = "ALT",
	-- 		action = wezterm.action.ToggleFullScreen,
	-- 	},
	-- 	-- Show the launcher in fuzzy selection mode and have it list all workspaces
	-- 	-- and allow activating one.
	-- 	{
	-- 		key = "f",
	-- 		mods = "ALT",
	-- 		action = act.ShowLauncherArgs({
	-- 			flags = "FUZZY|WORKSPACES",
	-- 		}),
	-- 	},
	-- },
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font("MonoLisa"),
	font_size = 14,
	line_height = 1.3,
	hide_tab_bar_if_only_one_tab = true,
	adjust_window_size_when_changing_font_size = false,
	use_fancy_tab_bar = true,
	enable_scroll_bar = true,
	default_cursor_style = "SteadyBlock",
	window_padding = {
		left = 8,
		right = 8,
		top = 8,
		bottom = 8,
	},
	-- window_background_opacity = 0.95,
}
