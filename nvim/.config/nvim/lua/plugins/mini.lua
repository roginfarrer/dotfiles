return {
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    config = function(_, opts)
      require('mini.pairs').setup(opts)
    end,
  },

  {
    'echasnovski/mini.surround',
    keys = { 'ys', 'ds', 'cs' },
    opts = {
      mappings = {
        add = 'ysa', -- Add surrounding in Normal and Visual modes
        delete = 'ds', -- Delete surrounding
        replace = 'cs', -- Replace surrounding
        find = 'ysf', -- Find surrounding (to the right)
        find_left = 'ysF', -- Find surrounding (to the left)
        highlight = 'ysh', -- Highlight surrounding
        update_n_lines = 'ysn', -- Update `n_lines`
      },
    },
    config = function(_, opts)
      -- use these mappings instead of s to prevent conflict with leap
      require('mini.surround').setup(opts)
    end,
  },

  {
    'echasnovski/mini.comment',
    enabled = false,
    -- event = 'VeryLazy',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    lazy = true,
    keys = { 'gc' },
    opts = {
      hooks = {
        pre = function()
          require('ts_context_commentstring.internal').update_commentstring {}
        end,
      },
    },
    config = function(_, opts)
      require('mini.comment').setup(opts)
    end,
  },

  -- better text-objects
  {
    'echasnovski/mini.ai',
    keys = {
      { 'a', mode = { 'x', 'o' } },
      { 'i', mode = { 'x', 'o' } },
    },
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        init = function()
          -- no need to load the plugin, since we only need its queries
          require('lazy.core.loader').disable_rtp_plugin 'nvim-treesitter-textobjects'
        end,
      },
    },
    opts = function()
      local ai = require 'mini.ai'
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
        },
      }
    end,
    config = function(_, opts)
      local ai = require 'mini.ai'
      ai.setup(opts)
    end,
  },
}
