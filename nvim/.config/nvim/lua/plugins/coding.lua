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
      local cmp = require 'cmp'

      local function border(hl_name)
        -- return {
        --   { ' ', hl_name },
        --   { '▁', hl_name },
        --   { ' ', hl_name },
        --   { '▏', hl_name },
        --   { ' ', hl_name },
        --   { '▔', hl_name },
        --   { ' ', hl_name },
        --   { '▕', hl_name },
        -- }
        -- return {
        --   { '╭', hl_name },
        --   { '─', hl_name },
        --   { '╮', hl_name },
        --   { '│', hl_name },
        --   { '╯', hl_name },
        --   { '─', hl_name },
        --   { '╰', hl_name },
        --   { '│', hl_name },
        -- }
      end

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
          -- { name = 'copilot' },
          { name = 'nvim_lsp_signature_help' },
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
        experimental = {
          -- native_menu = false,
          -- ghost_text = true,
        },
      }
    end,
    config = function(_, opts)
      local cmp_window = require 'cmp.utils.window'

      cmp_window.info_ = cmp_window.info
      cmp_window.info = function(self)
        local info = self:info_()
        info.scrollable = false
        return info
      end

      require('cmp').setup(opts)
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
    config = function(_, opts)
      require('mini.pairs').setup(opts)
    end,
  },

  {
    'echasnovski/mini.bracketed',
    event = 'BufReadPost',
    version = false,
    opts = {},
    config = function(_, opts)
      local bracketed = require 'mini.bracketed'
      bracketed.setup(opts)
    end,
  },

  {
    'echasnovski/mini.surround',
    keys = { 'ys', 'ds', 'cs' },
    opts = {
      mappings = {
        add = 'ys', -- Add surrounding in Normal and Visual modes
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

  -- Better clipboard management
  {
    'gbprod/yanky.nvim',
    dependencies = { { 'kkharji/sqlite.lua', enabled = not jit.os:find 'Windows' }, { 'aserowy/tmux.nvim' } },
    opts = function()
      local mapping = require 'yanky.telescope.mapping'
      local mappings = mapping.get_defaults()
      mappings.i['<c-p>'] = nil
      return {
        highlight = { timer = 200 },
        ring = { storage = jit.os:find 'Windows' and 'shada' or 'sqlite' },
        preserve_cursor_position = { enabled = true },
        picker = {
          telescope = {
            use_default_mappings = false,
            mappings = mappings,
          },
        },
      }
    end,
    keys = function()
      local t = function(tbl)
        local rhs = tbl[2]
        local new_rhs = function()
          local ok, tmux = pcall(require, 'tmux.copy')
          if vim.env.TMUX and ok then
            tmux.sync_registers()
          end
          return rhs
        end
        tbl[2] = new_rhs
        tbl.expr = true
        return tbl
      end
      return {
        -- stylua: ignore
        { '<leader>p', function() require('telescope').extensions.yank_history.yank_history {} end, desc = 'Open Yank History', },
        { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
        { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle forward through yank history' },
        { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle backward through yank history' },
        t { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
        t { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
        t { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after selection' },
        t { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before selection' },
        t { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
        t { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
        t { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
        t { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
        t { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', desc = 'Put and indent right' },
        t { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', desc = 'Put and indent left' },
        t { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'Put before and indent right' },
        t { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', desc = 'Put before and indent left' },
        t { '=p', '<Plug>(YankyPutAfterFilter)', desc = 'Put after applying a filter' },
        t { '=P', '<Plug>(YankyPutBeforeFilter)', desc = 'Put before applying a filter' },
      }
    end,
  },

  -- better increase/descrease
  {
    'monaqa/dial.nvim',
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
}
