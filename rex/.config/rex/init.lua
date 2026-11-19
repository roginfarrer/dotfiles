local amber = dofile(os.getenv("HOME") .. "/.local/share/rex/amber/amber.lua")

amber.setup({
	plugins = {
		{ "rawnly/smart-splits-backend-rex", main = "smart-splits-rex", opts = { resize_amount = 5 } },
		{ "evgeny-golubev/rex-extensions", subdir = "rex-resume" },
	},
})

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	rex.bind("ctrl+" .. key, "smart_splits_focus", { direction = direction, key = "ctrl+" .. key })
	rex.bind("shift+" .. direction, "smart_splits_resize", { direction = direction, key = "shift+" .. direction })
end

-- >>> resh >>>
dofile("/Users/rfarrer/Library/Application Support/resh/resh.lua")
rex.exec.start(
	{ "/Users/rfarrer/Library/Application Support/resh/resh", "service", "start" },
	{ detach = true, stdout = false, stderr = false }
)
-- <<< resh <<<
