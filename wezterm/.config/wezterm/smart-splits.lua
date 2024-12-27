local M = {}
local wezterm = require("wezterm")

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

M.setup = function(config)
	smart_splits.apply_to_config(config, {
		-- the default config is here, if you'd like to use the default keys,
		-- you can omit this configuration table parameter and just use
		-- smart_splits.apply_to_config(config)

		-- if you want to use separate direction keys for move vs. resize, you
		-- can also do this:
		direction_keys = {
			move = { "h", "j", "k", "l" },
			resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
		},
		-- modifier keys to combine with direction_keys
		modifiers = {
			move = "CTRL", -- modifier to use for pane movement, e.g. CTRL+h to move left
			resize = "SHIFT", -- modifier to use for pane resize, e.g. META+h to resize to the left
		},
		-- log level to use: info, warn, error
		log_level = "info",
	})
end

-- -- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
-- local function is_vim(pane)
-- 	-- this is set by the plugin, and unset on ExitPre in Neovim
-- 	return pane:get_user_vars().IS_NVIM == "true"
-- end

-- local direction_keys = {
-- 	h = "Left",
-- 	j = "Down",
-- 	k = "Up",
-- 	l = "Right",
-- }

-- local function move(key)
-- 	return {
-- 		key = key,
-- 		mods = "CTRL",
-- 		action = w.action_callback(function(win, pane)
-- 			if is_vim(pane) then
-- 				-- pass the keys through to vim/nvim
-- 				win:perform_action({
-- 					SendKey = { key = key, mods = "CTRL" },
-- 				}, pane)
-- 			else
-- 				win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
-- 			end
-- 		end),
-- 	}
-- end

-- local function resize(direction)
-- 	return {
-- 		key = direction .. "Arrow",
-- 		mods = "SHIFT",
-- 		action = w.action_callback(function(win, pane)
-- 			if is_vim(pane) then
-- 				-- pass the keys through to vim/nvim
-- 				win:perform_action({
-- 					SendKey = { key = direction .. "Arrow", mods = "SHIFT" },
-- 				}, pane)
-- 			else
-- 				win:perform_action({ AdjustPaneSize = { direction, 5 } }, pane)
-- 			end
-- 		end),
-- 	}
-- end

-- local M = {}

-- M.setup = function(config)
-- 	return require("utils").deepMerge(config, {
-- 		keys = {
-- 			-- move between split panes
-- 			move("h"),
-- 			move("j"),
-- 			move("k"),
-- 			move("l"),
-- 			-- resize panes
-- 			resize("Left"),
-- 			resize("Right"),
-- 			resize("Up"),
-- 			resize("Down"),
-- 		},
-- 	})
-- end

return M
