local ls = require 'luasnip'
local types = require 'luasnip.util.types'

require('luasnip.loaders.from_vscode').lazy_load()

local t = ls.text_node
local rep = require('luasnip.extras').rep
local c = ls.choice_node
local i = ls.insert_node
local d = ls.dynamic_node
local snippet_from_nodes = ls.sn
local s = ls.snippet
local fmt = require('luasnip.extras.fmt').fmt

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet
  -- You can jump back into it even if you move outside of the selection
  history = true,
  -- Updates dynamic snippets as you type
  updateevents = 'TextChanged,TextChangedI',
  enable_autosnippets = true,
  ext_ops = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '<-', 'Error' } },
      },
    },
  },
}

require 'user.plugins.luasnip.js'
require 'user.plugins.luasnip.lua'

map({ 'i', 's' }, '<c-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end)
map({ 'i', 's' }, '<c-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)
map({ 'i', 's' }, '<c-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

ls.add_snippets('markdown', {
  s({ trig = '-x', name = 'Empty Todo' }, {
    t '- [ ] ',
    i(0),
  }),
}, {
  type = 'autosnippets',
  key = 'markdown_auto',
})
