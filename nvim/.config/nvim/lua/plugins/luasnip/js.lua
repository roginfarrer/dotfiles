local ls = require 'luasnip'

local t = ls.text_node
local rep = require('luasnip.extras').rep
local c = ls.choice_node
local i = ls.insert_node
local d = ls.dynamic_node
local f = ls.function_node
local snippet_from_nodes = ls.sn
local s = ls.snippet
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta

local function require_var(args)
	local text = args[1][1] or ''
	local split = vim.split(text, '/', { plain = true })
	local name = split[#split]

	local options = {
		i(nil, name),
		snippet_from_nodes(nil, { t '{', i(1, name), t '}' }),
	}

	return snippet_from_nodes(nil, { c(1, options) })
end

local jsSnips = {
	ls.parser.parse_snippet('clog', 'console.log(${1})'),
	s(
		'im',
		fmt([[import {} from '{}']], {
			d(2, require_var, { 1 }),
			i(1),
		})
	),
	s(
		'req',
		fmt([[const {} = require('{}')]], {
			d(2, require_var, { 1 }),
			i(1),
		})
	),
	s({
		trig = 'fn',
		name = 'All-in-one function handler',
		dscr = 'Define function with option to toggle between arrow function and function declaration. Can optionally wrap selected text.',
	}, {
		d(1, function(_, snip)
			local function get_body()
				-- Whether text was selected
				local has_selection = table.getn(snip.env.TM_SELECTED_TEXT) > 0
				-- If has selection, inject the content ahead of insert
				local body = has_selection and { t(snip.env.TM_SELECTED_TEXT), i(1) } or { i(1) }
				return snippet_from_nodes(nil, body)
			end

			local options = {
				fmta(
					[[const <> = (<>) => {
  <>
}]],
					{
						i(1, 'name'),
						i(2, 'args'),
						d(3, get_body, {}),
					}
				),
				fmta(
					[[function <>(<>) {
  <>
}]],
					{
						i(1, 'name'),
						i(2, 'args'),
						d(3, get_body, {}),
					}
				),
			}

			return snippet_from_nodes(nil, { c(1, options) })
		end, {}),
	}),
	s(
		{ trig = 'for', name = 'For Loop' },
		fmt(
			[[for (let {} = 0; {} < {}.length; {}++) {{
  {}
}}]],
			{
				i(1, 'index'),
				rep(1),
				i(2, 'array'),
				rep(1),
				i(0),
			}
		)
	),
	s(
		{ trig = 'forof', name = 'For-Of Loop' },
		fmt(
			[[for (const {} of {}) {{
  const {} = {}[{}];
  {}
}}]],
			{
				i(1, 'key'),
				i(2, 'object'),
				i(3, 'property'),
				rep(2),
				rep(1),
				i(0),
			}
		)
	),
	s(
		{ trig = 'switch', name = 'Switch Statment' },
		fmta(
			[[switch (<>) {
  case <>:
    <>
    break;
  default:
}]],
			{ i(1, 'key'), i(2, 'value'), i(0) }
		)
	),

	-- A bunch of instance specific snippets
	s(
		'dp',
		fmt("{}('{}', '{}', {})", {
			c(1, { t 'useDeprecatedProp', t 'useDeprecatedPropValue' }),
			i(2, 'Component'),
			i(3, 'propName'),
			rep(3),
		})
	),
}

ls.add_snippets('javascript', jsSnips, { key = 'js_snips' })
-- ls.add_snippets('javascript', jsAutoSnips, { key = 'js_auto_snips' })

ls.filetype_extend('javascriptreact', { 'javascript' })
ls.filetype_extend('typescript', { 'javascript' })
ls.filetype_extend('typescriptreact', { 'javascript' })
ls.filetype_extend('astro', { 'javascript' })
