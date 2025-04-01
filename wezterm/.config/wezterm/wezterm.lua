local wezterm = require("wezterm") --[[@as Wezterm]]
local act = wezterm.action
local default_hyperlink_rules = wezterm.default_hyperlink_rules()

local tmux = true

local default_hyperlink_regex = {
	-- match github looking patterns, like neovim/neovim
	[[["]?[\w\d]{1}[-\w\d]+/{1}[-\w\d\.]+["]?]],
}
for _, regex in ipairs(default_hyperlink_rules) do
	table.insert(default_hyperlink_regex, regex.regex)
end
local hyperlink_rules = default_hyperlink_rules
-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(hyperlink_rules, {
	regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
	format = "https://www.github.com/$1/$3",
})

local rose_pine = wezterm.plugin.require("https://github.com/neapsix/wezterm").main

-- Allow working with both the current release and the nightly
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- wezterm.plugin.update_all()
config.hyperlink_rules = hyperlink_rules
config.color_schemes = {
	["Rose Pine"] = rose_pine.colors(),
}
config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Tokyo Night"
if config.color_scheme == "Rose Pine" then
	config.window_frame = rose_pine.window_frame()
end
config.font = wezterm.font_with_fallback({
	"Fira Code",
	-- "Recursive Mono Linear Static",
	-- "GeistMono Nerd Font",
	-- "MonoLisa",
	-- "0xProto Nerd Font",
	-- "JetBrainsMono Nerd Font",
	-- "CommitMono Nerd Font",
	-- "ZedMono Nerd Font",
	-- "Zed Mono",
	"Symbols Nerd Font",
	-- "MonaspiceNe Nerd Font",
})
config.font_rules = {
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({ family = "Maple Mono", weight = "Bold", style = "Italic" }),
	},
	{
		italic = true,
		intensity = "Half",
		font = wezterm.font({ family = "Maple Mono", weight = "DemiBold", style = "Italic" }),
	},
	{
		italic = true,
		intensity = "Normal",
		font = wezterm.font({ family = "Maple Mono", style = "Italic" }),
	},
}
config.allow_square_glyphs_to_overflow_width = "Always"
-- cell_width = 1.05
config.font_size = 14
config.line_height = 1.25
config.adjust_window_size_when_changing_font_size = false
config.bold_brightens_ansi_colors = true
config.use_fancy_tab_bar = false
config.enable_scroll_bar = false
config.default_cursor_style = "BlinkingBar"
config.window_decorations = "RESIZE"
-- window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
config.window_padding = {
	left = 30,
	right = 30,
	top = 20,
	bottom = 10,
}
config.default_workspace = "dotfiles"
config.default_cwd = wezterm.home_dir .. "/dotfiles"
-- config.window_close_confirmation = "NeverPrompt"
config.native_macos_fullscreen_mode = false
-- config.cursor_blink_rate = 0
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.tab_max_width = 32
config.animation_fps = 240
config.max_fps = 240

if tmux then
	require("tmux").setup(config)
else
	config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

	config.keys = config.keys or {}
	local function addKey(tbl)
		table.insert(config.keys, tbl)
	end

	addKey({
		key = "[",
		mods = "LEADER",
		action = "ActivateCopyMode",
	})
	addKey({
		key = "z",
		mods = "LEADER",
		action = "TogglePaneZoomState",
	})
	addKey({
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	})
	addKey({
		key = "n",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal,
	})
	addKey({
		key = "N",
		mods = "CMD",
		action = wezterm.action.SplitVertical,
	})
	addKey({
		key = "p",
		mods = "CMD",
		action = wezterm.action.ActivateCommandPalette,
	})
	addKey({
		key = "P",
		mods = "CTRL",
		action = wezterm.action.QuickSelectArgs({
			label = "open url",
			-- taken from wezterm.default_hyperlink_rules()
			patterns = default_hyperlink_regex,
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				local github_pattern = "^[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+$"
				if string.match(url, github_pattern) then
					url = "https://www.github.com/" .. url
				end
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	})
	addKey({
		key = "f",
		mods = "SHIFT|CTRL",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	})
	addKey({
		key = "g",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local current_tab_id = pane:tab():tab_id()
			local cmd = "lazygit ; wezterm cli activate-tab --tab-id " .. current_tab_id .. " ; exit\n"
			local tab, tab_pane, _ = window:mux_window():spawn_tab({})
			tab_pane:send_text(cmd)
			tab:set_title(wezterm.nerdfonts.dev_git .. " Lazygit")
		end),
	})
	config.unix_domains = { { name = "unix" } }
	-- config.default_gui_startup_args = { "connect", "unix" }
	config.hide_tab_bar_if_only_one_tab = false

	wezterm.on("rfarrer-update-plugins", function(window)
		wezterm.log_info("Updating Plugins")
		-- Toast not working for some reason?
		window:toast_notification("wezterm", "Updating plugins", nil, 4000)

		wezterm.plugin.update_all()
	end)
	addKey({
		key = "U",
		mods = "LEADER",
		action = wezterm.action.EmitEvent("rfarrer-update-plugins"),
	})

	require("workspace-switcher").setup(config)
	require("smart-splits").setup(config)
end
-- require("tab-titles")
require("nvim-zenmode")

local hasLocal, localFile = pcall(require, "local")
if hasLocal then
	localFile.setup(config)
end

return config
