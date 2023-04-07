local w = require("wezterm")

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function is_vim(pane)
	local process_name = pane:get_foreground_process_name() and basename(pane:get_foreground_process_name()) or nil
	if process_name then
		return process_name == "nvim" or process_name == "vim"
	end
	return pane:get_title():find("n?vim") ~= nil
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return w.action_callback(function(win, pane)
		print(is_vim(pane))
		if is_vim(pane) then
			-- pass the keys through to vim/nvim
			win:perform_action({
				SendKey = { key = key, mods = "CTRL" },
			}, pane)
		else
			win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
		end
	end)
end

return {
	-- move between split panes
	left = split_nav("move", "h"),
	down = split_nav("move", "j"),
	up = split_nav("move", "k"),
	right = split_nav("move", "l"),
	-- resize panes
	-- split_nav("resize", "h"),
	-- split_nav("resize", "j"),
	-- split_nav("resize", "k"),
	-- split_nav("resize", "l"),
}
