local amber = dofile(os.getenv("HOME") .. "/.local/share/rex/amber/amber.lua")

amber.setup({
	plugins = {
		{ "rawnly/smart-splits-backend-rex", main = "smart-splits-rex", opts = { resize_amount = 5 } },
		{ "evgeny-golubev/rex-extensions", subdir = "rex-resume" },
		"devert/rex-fzf-url",
	},
})

-- Plugin isn't set-up to be used by amber
local rexFzfUrl = dofile(os.getenv("HOME") .. "/.local/share/rex/plugins/devert/rex-fzf-url/init.lua")

rexFzfUrl.setup({
	key = "shift+ctrl+e",
	extra_patterns = {
		{ regex = [[(^|'|")((\w|-)+\/(\w|-)+)($|'|")]], url = "https://github.com/$2" },
		{ regex = "go/{1}[-\\w\\d]+", url = "http://$0" },
	},
})

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	rex.bind("ctrl+" .. key, "smart_splits_focus", { direction = direction, key = "ctrl+" .. key })
	rex.bind("shift+" .. direction, "smart_splits_resize", { direction = direction, key = "shift+" .. direction })
end

-- Tmux habits
rex.bind("ctrl+a>[", "pane.copy_mode.enter")
rex.bind("ctrl+a>]", "pane.paste")

-- >>> resh >>>
dofile("/Users/rfarrer/Library/Application Support/resh/resh.lua")
rex.exec.start(
	{ "/Users/rfarrer/Library/Application Support/resh/resh", "service", "start" },
	{ detach = true, stdout = false, stderr = false }
)
-- <<< resh <<<
