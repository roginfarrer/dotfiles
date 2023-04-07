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

return { tmux_keys }
