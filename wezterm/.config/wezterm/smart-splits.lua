local w = require("wezterm")

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function move(key)
	return {
		key = key,
		mods = "CTRL",
		action = w.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = "CTRL" },
				}, pane)
			else
				win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
			end
		end),
	}
end

local function resize(direction)
	return {
		key = direction .. "Arrow",
		mods = "SHIFT",
		action = w.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = direction .. "Arrow", mods = "SHIFT" },
				}, pane)
			else
				win:perform_action({ AdjustPaneSize = { direction, 5 } }, pane)
			end
		end),
	}
end

local M = {}

M.setup = function(config)
	return require("utils").deepMerge(config, {
		keys = {
			-- move between split panes
			move("h"),
			move("j"),
			move("k"),
			move("l"),
			-- resize panes
			resize("Left"),
			resize("Right"),
			resize("Up"),
			resize("Down"),
		},
	})
end

return M
