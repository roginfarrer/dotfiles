return {
  -- Comment operations
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'x' } },
      { 'gb', mode = { 'n', 'x' } },
    },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      -- using "config" instead of "opts" because requiring ts_context_commentstring throws error
      require('Comment').setup {
        -- ignore empty lines
        ignore = '^$',
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },

  -- auto completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    version = false,
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'petertriho/cmp-git',
      'David-Kunz/cmp-npm',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-cmdline',
      'mtoohey31/cmp-fish',
      'lukas-reineke/cmp-under-comparator',
    },
    opts = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
      local cmp = require 'cmp'
      local defaults = require 'cmp.config.default'()

      return {
        completion = {
          -- Fix autocompletion breaking when using '$'
          keyword_pattern = [[\k\+]],
        },
        window = {
          completion = cmp.config.window.bordered {
            scrollbar = true,
          },
          documentation = cmp.config.window.bordered {
            scrollbar = true,
          },
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        formatting = {
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', require('ui.icons').lazy.kinds[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
              -- buffer = '[Buffer]',
              -- nvim_lsp = '[LSP]',
              -- luasnip = '[LuaSnip]',
              -- nvim_lua = '[Lua]',
              -- latex_symbols = '[LaTeX]',
              copilot = '[Copilot]',
            })[entry.source.name]
            return vim_item
          end,
        },
        -- sorting = defaults.sorting,
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require('cmp-under-comparator').under,
            cmp.config.compare.kind,
          },
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item {
            behavior = cmp.SelectBehavior.Insert,
          },
          ['<C-p>'] = cmp.mapping.select_prev_item {
            behavior = cmp.SelectBehavior.Insert,
          },
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          },
          ['<c-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip', keyword_length = 1 },
          { name = 'npm' },
          { name = 'cmp_git' },
          { name = 'nvim_lua' },
          { name = 'neorg' },
          { name = 'orgmode' },
          { name = 'path' },
          { name = 'fish' },
        }, {
          { name = 'buffer', keyword_length = 4 },
        }),
      }
    end,
    config = function(_, opts)
      -- for _, source in ipairs(opts.sources) do
      --   source.group_index = source.group_index or 1
      -- end
      local cmp = require 'cmp'
      cmp.setup(opts)
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
          },
        }),
      })
    end,
  },

  -- Automatically between template literal and strings when needed
  {
    'axelvc/template-string.nvim',
    opts = { remove_template_string = true },
    event = 'InsertEnter',
  },

  -- Auto pairs
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    version = '*',
    config = function(_, opts)
      require('mini.pairs').setup(opts)
    end,
  },

  {
    'echasnovski/mini.bracketed',
    event = 'BufReadPost',
    version = '*',
    opts = {},
    config = function(_, opts)
      local bracketed = require 'mini.bracketed'
      bracketed.setup(opts)
    end,
  },

  {
    'echasnovski/mini.surround',
    version = '*',
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require('lazy.core.config').spec.plugins['mini.surround']
      local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
      local mappings = {
        { opts.mappings.add, desc = 'Add surrounding', mode = { 'n', 'v' } },
        { opts.mappings.delete, desc = 'Delete surrounding' },
        { opts.mappings.find, desc = 'Find right surrounding' },
        { opts.mappings.find_left, desc = 'Find left surrounding' },
        { opts.mappings.highlight, desc = 'Highlight surrounding' },
        { opts.mappings.replace, desc = 'Replace surrounding' },
        { opts.mappings.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = 'gsa', -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- Delete surrounding
        find = 'gsf', -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
        -- add = 'ys', -- Add surrounding in Normal and Visual modes
        -- delete = 'ds', -- Delete surrounding
        -- replace = 'cs', -- Replace surrounding
        -- find = 'ysf', -- Find surrounding (to the right)
        -- find_left = 'ysF', -- Find surrounding (to the left)
        -- highlight = 'ysh', -- Highlight surrounding
        -- update_n_lines = 'ysn', -- Update `n_lines`
      },
    },
    config = function(_, opts)
      require('mini.surround').setup(opts)
    end,
  },

  -- better text-objects
  -- config from
  -- https://github.com/LazyVim/LazyVim/blob/879e29504d43e9f178d967ecc34d482f902e5a91/lua/lazyvim/plugins/coding.lua#L186
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
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
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
        },
      }
    end,
    config = function(_, opts)
      require('mini.ai').setup(opts)
      -- register all text objects with which-key
      require('util').on_plugin_load('which-key.nvim', function()
        ---@type table<string, string|table>
        local i = {
          [' '] = 'Whitespace',
          ['"'] = 'Balanced "',
          ["'"] = "Balanced '",
          ['`'] = 'Balanced `',
          ['('] = 'Balanced (',
          [')'] = 'Balanced ) including white-space',
          ['>'] = 'Balanced > including white-space',
          ['<lt>'] = 'Balanced <',
          [']'] = 'Balanced ] including white-space',
          ['['] = 'Balanced [',
          ['}'] = 'Balanced } including white-space',
          ['{'] = 'Balanced {',
          ['?'] = 'User Prompt',
          _ = 'Underscore',
          a = 'Argument',
          b = 'Balanced ), ], }',
          c = 'Class',
          f = 'Function',
          o = 'Block, conditional, loop',
          q = 'Quote `, ", \'',
          t = 'Tag',
        }
        local a = vim.deepcopy(i)
        for k, v in pairs(a) do
          a[k] = v:gsub(' including.*', '')
        end

        local ic = vim.deepcopy(i)
        local ac = vim.deepcopy(a)
        for key, name in pairs { n = 'Next', l = 'Last' } do
          i[key] = vim.tbl_extend('force', { name = 'Inside ' .. name .. ' textobject' }, ic)
          a[key] = vim.tbl_extend('force', { name = 'Around ' .. name .. ' textobject' }, ac)
        end
        require('which-key').register {
          mode = { 'o', 'x' },
          i = i,
          a = a,
        }
      end)
    end,
  },

  -- Better clipboard management
  {
    'gbprod/yanky.nvim',
    dependencies = { { 'kkharji/sqlite.lua' } },
    opts = {
      highlight = { timer = 200 },
      ring = { storage = 'sqlite' },
      preserve_cursor_position = { enabled = true },
    },
    keys = {
      -- stylua: ignore
      -- { '<leader>p', function() require('telescope').extensions.yank_history.yank_history {} end, desc = 'Open Yank History' },
      { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
      { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle forward through yank history' },
      { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle backward through yank history' },
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
      { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after selection' },
      { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before selection' },
      { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
      { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
      { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
      { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
      { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', desc = 'Put and indent right' },
      { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', desc = 'Put and indent left' },
      { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'Put before and indent right' },
      { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', desc = 'Put before and indent left' },
      { '=p', '<Plug>(YankyPutAfterFilter)', desc = 'Put after applying a filter' },
      { '=P', '<Plug>(YankyPutBeforeFilter)', desc = 'Put before applying a filter' },
    },
  },

  -- better increase/descrease
  {
    'monaqa/dial.nvim',
    enabled = false,
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
      { "<C-a>", function() return require("dial.map").inc_visual() end, expr = true, desc = "Increment", mode = {'v'} },
      { "<C-x>", function() return require("dial.map").dec_visual() end, expr = true, desc = "Decrement", mode = {'v'} },
      { "g<C-a>", function() return require("dial.map").inc_gvisual() end, expr = true, desc = "Increment", mode = {'v'} },
      { "g<C-x>", function() return require("dial.map").dec_gvisual() end, expr = true, desc = "Decrement", mode = {'v'} },
    },
    config = function()
      local augend = require 'dial.augend'
      require('dial.config').augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      }
    end,
  },

  {
    'piersolenski/wtf.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {},
    cmd = { 'Wtf', 'WtfSearch' },
    keys = {
      {
        '<leader>da',
        function()
          require('wtf').ai()
        end,
        desc = 'Debug with WTF',
      },
    },
  },
}
