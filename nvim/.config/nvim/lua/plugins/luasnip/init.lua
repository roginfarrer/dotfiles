local M = {
  'L3MON4D3/LuaSnip',
  -- dependencies = {
  --   {
  --     'rafamadriz/friendly-snippets',
  --     config = function()
  --       require('luasnip.loaders.from_vscode').lazy_load()
  --     end,
  --   },
  -- },
  opts = function()
    local types = require 'luasnip.util.types'
    return {
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
  end,
  -- stylua: ignore
  keys = {
    {
      '<tab>',
      function()
        return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
      end,
      expr = true,
      silent = true,
      mode = 'i',
    },
    { '<tab>', function() require('luasnip').jump(1) end, mode = 's', },
    { '<s-tab>', function() require('luasnip').jump(-1) end, mode = { 'i', 's' }, },
    {
      '<c-k>',
      function()
        if require('luasnip').expand_or_jumpable() then
          require('luasnip').expand_or_jump()
        end
      end,
      mode = { 'i', 's' },
    },
    {
      '<c-j>',
      function()
        if require('luasnip').jumpable(-1) then
          require('luasnip').jump(-1)
        end
      end,
      mode = { 'i', 's' },
    },
    {
      '<c-l>',
      function()
        if require('luasnip').choice_active() then
          require('luasnip').change_choice(1)
        end
      end,
      mode = { 'i', 's' },
    },
  },
}

function M.config(_, opts)
  local ls = require 'luasnip'

  ls.setup(opts)

  local t = ls.text_node
  local i = ls.insert_node
  local s = ls.snippet

  vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function()
      if ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.session.jump_active then
        ls.unlink_current()
      end
    end,
  })

  require 'plugins.luasnip.js'
  require 'plugins.luasnip.lua'

  ls.add_snippets('markdown', {
    s({ trig = '-x', name = 'Empty Todo' }, {
      t '- [ ] ',
      i(0),
    }),
  }, {
    type = 'autosnippets',
    key = 'markdown_auto',
  })

  require('luasnip.loaders.from_vscode').lazy_load {
    paths = { '~/.config/nvim/lua/plugins/luasnip/vscode-snippets/' },
  }
end

return M
