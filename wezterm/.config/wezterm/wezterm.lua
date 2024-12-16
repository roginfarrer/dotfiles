local wezterm = require("wezterm")
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

local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main

local config = {
	hyperlink_rules = hyperlink_rules,
	color_scheme = "Catppuccin Mocha",
	-- colors = theme.colors(),
	window_frame = theme.window_frame(),
	font = wezterm.font_with_fallback({
		-- "Maple Mono",
		-- "Recursive Mono Linear Static",
		-- "GeistMono Nerd Font",
		-- "MonoLisa",
		-- "0xProto Nerd Font",
		-- "JetBrainsMono Nerd Font",
		-- "CommitMono Nerd Font",
		-- "ZedMono Nerd Font",
		"Zed Mono",
		"Symbols Nerd Font",
		-- "MonaspiceNe Nerd Font",
	}),
	allow_square_glyphs_to_overflow_width = "Always",
	cell_width = 1.05,
	font_size = 16,
	line_height = 1.35,
	adjust_window_size_when_changing_font_size = false,
	bold_brightens_ansi_colors = true,
	use_fancy_tab_bar = false,
	enable_scroll_bar = false,
	default_cursor_style = "BlinkingBar",
	window_decorations = "RESIZE",
	-- window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	window_padding = {
		left = 30,
		right = 30,
		top = 20,
		bottom = 10,
	},
	default_workspace = "dotfiles",
	default_cwd = wezterm.home_dir .. "/dotfiles",
	window_close_confirmation = "NeverPrompt",
	native_macos_fullscreen_mode = false,
	cursor_blink_rate = 0,
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	tab_max_width = 32,
	animation_fps = 240,
	max_fps = 240,
}

if tmux then
	require("tmux").setup(config)
else
	require("utils").deepMerge(config, {
		leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
		keys = {
			{
				key = "[",
				mods = "LEADER",
				action = "ActivateCopyMode",
			},
			{
				key = "z",
				mods = "LEADER",
				action = "TogglePaneZoomState",
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
			{
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
			},
			{
				key = "f",
				mods = "SHIFT|CTRL",
				action = act.ShowLauncherArgs({
					flags = "FUZZY|WORKSPACES",
				}),
			},
		},
		unix_domains = { { name = "unix" } },
		default_gui_startup_args = { "connect", "unix" },
		hide_tab_bar_if_only_one_tab = false,
		-- window_background_opacity = 0.75,
		-- macos_window_background_blur = 20,
	})

	require("workspace-switcher").setup(config)
	require("smart-splits").setup(config)
end
require("tab-titles")
require("nvim-zenmode")

return config
