local wezterm = require("wezterm")

-- Update tab names dynamically
-- https://github.com/wez/wezterm/issues/1598#issuecomment-1167761301
wezterm.GLOBAL.tab_titles = {}
wezterm.on("format-tab-title", function(tab, _, panes)
	local tab_id = tostring(tab.tab_id)

	if tab.is_active then
		for _, pane in ipairs(panes) do
			local pane_title = pane.title
			if pane_title:sub(1, 1) == ">" then
				local title = pane_title:sub(2)
				local current_titles = wezterm.GLOBAL.tab_titles
				current_titles[tab_id] = title
				wezterm.GLOBAL.tab_titles = current_titles
			end
		end
	end

	local pos = tab.tab_index + 1
	local title = wezterm.GLOBAL.tab_titles[tab_id] or tab.active_pane.title
	return " " .. pos .. ": " .. title .. " "
end)
