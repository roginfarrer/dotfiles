local amber = dofile(os.getenv("HOME") .. "/.local/share/rex/amber/amber.lua")

amber.setup({
	plugins = {
		{ "rawnly/smart-splits-backend-rex", main = "smart-splits-rex", opts = { resize_amount = 5 } },
	},
})

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	rex.bind("ctrl+" .. key, "smart_splits_focus", { direction = direction, key = "ctrl+" .. key })
	rex.bind("shift+" .. direction, "smart_splits_resize", { direction = direction, key = "shift+" .. direction })
end
