local ls = require 'luasnip'

local text = ls.text_node
local insert = ls.insert_node
local snip = ls.snippet

local jsAutoSnips = {
  snip('clog', {
    text 'console.log(',
    insert(0),
    text ');',
  }),
}

local jsSnips = {
  snip('clog', {
    text 'console.log(',
    insert(0),
    text ');',
  }),
  snip('cfn', {
    text 'const ',
    insert(1, 'name'),
    text ' = (',
    insert(2, 'args'),
    text { ') => {', '\t' },
    insert(0),
    text { '', '}' },
  }),
  snip('fn', {
    text 'function ',
    insert(1, 'name'),
    text '(',
    insert(2, 'args'),
    text { ') {', '\t' },
    insert(0),
    text { '', '}' },
  }),
}

ls.snippets = {
  javascript = jsSnips,
  javascriptreact = jsSnips,
  typescriptreact = jsSnips,
  typescript = jsSnips,
  lua = {
    snip({
      trig = 'lfunc',
      name = 'Local Function',
      dscr = 'Skeleton of a local function',
    }, {
      text 'local function ',
      insert(1, 'name'),
      text '(',
      insert(2, 'args'),
      text { ')', '\t' },
      insert(0),
      text { '', 'end' },
    }),
  },
}

ls.autosnippets = {
  javascript = jsAutoSnips,
  javascriptreact = jsAutoSnips,
  typescriptreact = jsAutoSnips,
  typescript = jsAutoSnips,
  markdown = {
    snip({ trig = '-x', name = 'Empty Todo' }, {
      text '- [ ] ',
      insert(0),
    }),
  },
  telekasten = {
    snip({ trig = '-x', name = 'Empty Todo' }, {
      text '- [ ] ',
      insert(0),
    }),
  },
}

ls.config.setup {
  enable_autosnippets = true,
}
