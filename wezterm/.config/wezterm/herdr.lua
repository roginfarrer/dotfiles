local wezterm = require("wezterm")
local act = wezterm.action

local leader = "\x01" -- Ctrl+B (herdr default prefix)
local function hkey(mod, key, str)
	return {
		key = key,
		mods = mod,
		action = act.SendString(leader .. str),
	}
end

local herdr_keys = {
	-- Switch tab 1-9
	hkey("CMD", "1", "1"),
	hkey("CMD", "2", "2"),
	hkey("CMD", "3", "3"),
	hkey("CMD", "4", "4"),
	hkey("CMD", "5", "5"),
	hkey("CMD", "6", "6"),
	hkey("CMD", "7", "7"),
	hkey("CMD", "8", "8"),
	hkey("CMD", "9", "9"),
	-- Workspace picker
	hkey("CMD", "k", "w"),
	-- Previous tab
	hkey("CMD", "[", "p"),
	-- Next tab
	hkey("CMD", "]", "n"),
	-- Split horizontal (top/bottom)
	hkey("CMD|SHIFT", "n", "-"),
	-- Split vertical (left/right)
	hkey("CMD", "n", "v"),
	-- New tab
	hkey("CMD", "t", "c"),
	-- Close tab
	hkey("CMD", "w", "x"),
	-- Zoom pane
	hkey("CMD", "z", "z"),
}

local M = {}

M.setup = function(config)
	return require("utils").deepMerge(config, {
		keys = herdr_keys,
		hide_tab_bar_if_only_one_tab = true,
	})
end

return M
