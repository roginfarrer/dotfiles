local M = {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
}

function M.config()
  local ls = require 'luasnip'
  local types = require 'luasnip.util.types'

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
    store_selection_keys = '<Tab>',
    ext_ops = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '<-', 'Error' } },
        },
      },
    },
  }

  vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function()
      if
        ls.session.current_nodes[vim.api.nvim_get_current_buf()]
        and not ls.session.jump_active
      then
        ls.unlink_current()
      end
    end,
  })

  require 'plugins.luasnip.js'
  require 'plugins.luasnip.lua'

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
end

return M
