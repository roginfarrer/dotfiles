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

local jsAutoSnips = {
  ls.parser.parse_snippet('clog', 'console.log(${1})'),
  -- s('clog', {
  --   t 'console.log(',
  --   i(0),
  --   t ');',
  -- }),
}

local jsSnips = {
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
  s('cfn', {
    t 'const ',
    i(1, 'name'),
    t ' = (',
    i(2, 'args'),
    t { ') => {', '\t' },
    i(0),
    t { '', '}' },
  }),
  s('fn', {
    t 'function ',
    i(1, 'name'),
    t '(',
    i(2, 'args'),
    t { ') {', '\t' },
    i(0),
    t { '', '}' },
  }),
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
ls.add_snippets('javascript', jsAutoSnips, { key = 'js_auto_snips' })

ls.filetype_extend('javascriptreact', { 'javascript' })
ls.filetype_extend('typescript', { 'javascript' })
ls.filetype_extend('typescriptreact', { 'javascript' })
