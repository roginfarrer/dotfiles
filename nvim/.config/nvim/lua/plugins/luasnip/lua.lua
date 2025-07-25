local ls = require 'luasnip'

local t = ls.text_node
local rep = require('luasnip.extras').rep
local c = ls.choice_node
local i = ls.insert_node
local d = ls.dynamic_node
local snippet_from_nodes = ls.sn
local s = ls.snippet
local fmt = require('luasnip.extras.fmt').fmt

local require_var = function(args, _)
	local text = args[1][1] or ''
	local split = vim.split(text, '.', { plain = true })

	local options = {}
	for len = 0, #split - 1 do
		table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), '_')))
	end

	return snippet_from_nodes(nil, {
		c(1, options),
	})
end

ls.add_snippets('lua', {
	s({
		trig = 'lf',
		name = 'Local Function',
		dscr = 'Skeleton of a local function',
	}, {
		t 'local function ',
		i(1, 'name'),
		t '(',
		i(2, 'args'),
		t { ')', '\t' },
		i(0),
		t { '', 'end' },
	}),
	s(
		'req',
		fmt([[local {} = require("{}")]], {
			d(2, require_var, { 1 }),
			i(1),
		})
	),
}, {
	key = 'lua_snips',
})
