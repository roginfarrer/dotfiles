local M = {}
local wezterm = require("wezterm")

M.setup = function(config)
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
		local colors = config.color_scheme and wezterm.colors.get_builtin_schemes()[config.color_scheme]
			or config.colors
		return wezterm.format({
			{ Attribute = { Italic = true } },
			{ Foreground = { Color = colors.ansi[1] } },
			{ Background = { Color = colors.brights[5] } },
			{ Text = "󱂬: " .. label },
		})
	end)

	return require("utils").deepMerge(config, {
		keys = {
			{
				key = "s",
				mods = "CMD",
				action = workspace_switcher.switch_workspace(),
			},
		},
	})
end

return M
