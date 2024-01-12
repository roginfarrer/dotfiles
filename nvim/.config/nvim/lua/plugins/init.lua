return {
  -- { 'roginfarrer/LazyVim', dev = true, opts = { colorscheme = 'catppuccin' } },
  {
    'LazyVim/LazyVim',
    -- lazy = true,
    -- opts = { colorscheme = 'catppuccin', defaults = { keymaps = false } },
    -- config = function(_, opts)
    --   require('lazyvim').setup(opts)
    --   require('lazyvim.config').init()
    -- end,
  },
  { 'nvim-lua/plenary.nvim', lazy = true },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      triggers = 'auto',
      plugins = { spelling = true },
      key_labels = { ['<leader>'] = 'SPC', ['<tab>'] = 'TAB' },
      defaults = {
        mode = { 'n', 'v' },
        ['<leader><tab>'] = { name = '+tabs' },
        ['<leader>f'] = { name = '+find' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>gh'] = { name = '+hunk' },
        ['<leader>x'] = { name = '+trouble' },
        ['<leader>s'] = { name = '+search' },
        ['<leader>j'] = { name = '+join/split' },
        ['<leader>d'] = { name = '+debug' },
        ['<leader>t'] = { name = '+test' },
        ['<leader>u'] = { name = '+ui' },
      },
    },
    config = function(_, opts)
      local wk = require 'which-key'
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  {
    'echasnovski/mini.clue',
    enabled = false,
    version = '*',
    lazy = false,
    opts = function()
      local miniclue = require 'mini.clue'
      local menu = {
        ['<leader><tab>'] = { name = '+tabs' },
        ['<leader>f'] = { name = '+find' },
        ['<leader>g'] = { name = '+git' },
        ['<leader>gh'] = { name = '+hunk' },
        ['<leader>x'] = { name = '+trouble' },
        ['<leader>s'] = { name = '+search' },
        ['<leader>j'] = { name = '+join/split' },
        ['<leader>d'] = { name = '+debug' },
        ['<leader>t'] = { name = '+test' },
        -- ['<leader>u'] = { name = '+ui' },
        ['<leader>l'] = { name = '+lsp' },
      }

      local sub_menu = {}

      for mapping, opts in pairs(menu) do
        table.insert(sub_menu, { mode = 'n', keys = mapping, desc = opts.name })
      end

      -- Clues for recorded macros.
      local function macro_clues()
        local res = {}
        for _, register in ipairs(vim.split('abcdefghijklmnopqrstuvwxyz', '')) do
          local keys = string.format('"%s', register)
          local ok, desc = pcall(vim.fn.getreg, register, 1)
          if ok and desc ~= '' then
            table.insert(res, { mode = 'n', keys = keys, desc = desc })
            table.insert(res, { mode = 'v', keys = keys, desc = desc })
          end
        end

        return res
      end

      local trigger_keys = {
        n = { '<leader>', 'g', "'", '"', '`', '<C-w>', 'z', '[', ']' },
        x = { '<leader>', 'g', '"', "'", '`', 'z' },
        i = { '<C-x>', '<C-r>' },
        c = { '<C-r>' },
      }

      local triggers = {}
      for mode, keys in pairs(trigger_keys) do
        for _, key in ipairs(keys) do
          table.insert(triggers, { mode = mode, keys = key })
        end
      end

      return {
        triggers = triggers,
        clues = {
          sub_menu,
          macro_clues(),
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
        window = {
          delay = 500,
          scroll_down = '<C-f>',
          scroll_up = '<C-b>',
          config = function(bufnr)
            local max_width = 0
            for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
              max_width = math.max(max_width, vim.fn.strchars(line))
            end

            -- Keep some right padding.
            max_width = max_width + 2

            return {
              border = 'rounded',
              -- Dynamic width capped at 45.
              width = math.min(45, max_width),
            }
          end,
        },
      }
    end,
    config = function(_, opts)
      require('mini.clue').setup(opts)
    end,
  },

  {
    'antoinemadec/FixCursorHold.nvim',
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },

  {
    'zeioth/garbage-day.nvim',
    enabled = false,
    event = 'VeryLazy',
    opts = {},
  },

  {
    'rmagatti/gx-extended.nvim',
    keys = { 'gx' },
    opts = {
      open_fn = require('lazy.util').open,
      extensions = {
        { -- match github repos in lazy.nvim plugin specs
          patterns = { '*.lua' },
          name = 'neovim plugins',
          match_to_url = function(line_string)
            local line = string.match(line_string, '["|\'].*/.*["|\']')
            local repo = vim.split(line, ':')[1]:gsub('["|\']', '')
            local url = 'https://github.com/' .. repo
            return line and repo and url or nil
          end,
        },
      },
    },
  },

  {
    'LunarVim/bigfile.nvim',
    event = 'VeryLazy',
    opts = {
      filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
      pattern = function(bufnr, filesize_mib)
        -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
        local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
        local file_length = #file_contents
        local filetype = vim.filetype.match { buf = bufnr }
        if file_length > 5000 then
          return true
        end
      end,
      features = { -- features to disable
        'indent_blankline',
        'illuminate',
        'lsp',
        'treesitter',
        'syntax',
        'vimopts',
        'filetype',
      },
    },
  },
}
