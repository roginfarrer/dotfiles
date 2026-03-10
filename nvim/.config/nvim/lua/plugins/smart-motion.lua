return {
	'FluxxField/smart-motion.nvim',
	enabled = false,
	event = 'VeryLazy',
	opts = {
		presets = {
			words = false, -- w, b, e, ge
			lines = false, -- j, k
			search = true, -- s, S, f, F, t, T, ;, ,
			delete = false, -- d + any motion
			yank = false, -- y + any motion
			change = false, -- c + any motion
			treesitter = false, -- ]], [[, af, if, ac, ic, aa, ia, fn, saa, gS, R
			diagnostics = false, -- ]d, [d, ]e, [e
			misc = false, -- . g. g1-g9 gp gP gA-gZ gmd gmy (repeat, history, pins, multi-cursor)
		},
	},
}
