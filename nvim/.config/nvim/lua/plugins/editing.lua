local oil_select = function(direction)
  local oil = require 'oil'
  if direction == 'vertical' then
    oil.select { vertical = true }
  else
    oil.select()
  end
  vim.cmd.wincmd { args = { 'p' } }
  oil.close()
  vim.cmd.wincmd { args = { 'p' } }
end

return {
  -- Better netrw
  {
    'stevearc/oil.nvim',
    opts = {
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['q'] = 'actions.close',
        ['<C-v>'] = {
          desc = 'open in a vertical split',
          callback = function()
            oil_select 'vertical'
          end,
        },
        ['<C-s>'] = {
          desc = 'open in a vertical split',
          callback = function()
            oil_select 'vertical'
          end,
        },
        ['<C-l>'] = false,
        ['<C-h>'] = false,
      },
    },
    -- stylua: ignore
    keys = {
      { '-', function() require('oil').open() end, desc = 'Open Oil', },
    },
  },

  -- {
  --   'lmburns/lf.nvim',
  --   cmd = { 'Lf' },
  --   opts = {
  --     border = 'rounded',
  --     winblend = 0,
  --     focus_on_open = true,
  --     height = vim.fn.float2nr(vim.fn.round(0.9 * vim.o.lines)), -- height of the *floating* window
  --     width = vim.fn.float2nr(vim.fn.round(0.9 * vim.o.columns)), -- width of the *floating* window
  --     default_file_manager = true,
  --   },
  --   config = function(_, opts)
  --     require('lf').setup(opts)
  --     require('config.util').autocmd('User', {
  --       pattern = 'LfTermEnter',
  --       callback = function()
  --         -- Fix weirdness of reverting to normal mode when opening
  --         vim.cmd 'startinsert'
  --       end,
  --     })
  --   end,
  --   -- stylua: ignore
  --   keys = {
  --     { '-', '<cmd>Lf<CR>', desc = 'Open LF', },
  --   },
  -- },

  -- {
  --   'is0n/fm-nvim',
  --   opts = {
  --     ui = {
  --       float = {
  --         float_hl = 'Float',
  --         border_hl = 'FloatBorder',
  --       },
  --     },
  --   },
  --   cmd = { 'Lf' },
  --   keys = {
  --     { '-', '<cmd>Lf %<CR>', desc = 'Open LF' },
  --   },
  -- },

  {
    'echasnovski/mini.files',
    enabled = false,
    opts = {},
    config = function(_, opts)
      require('mini.files').setup(opts)
    end,
    -- stylua: ignore
    keys = {
      { '-', function() require('mini.files').open(vim.api.nvim_buf_get_name(0), true) end, desc = 'Open mini.files', },
    },
  },

  -- -- Center active split
  -- {
  --   'shortcuts/no-neck-pain.nvim',
  --   version = '*',
  --   cmd = 'NoNeckPain',
  -- },

  -- Use same keybindings to move between Vim splits and Kitty panes
  -- {
  --   'knubie/vim-kitty-navigator',
  --   enabled = false,
  --   build = 'cp ./*.py ~/.config/kitty/',
  --   cond = function()
  --     -- local term = vim.fn.execute('echo $TERM'):gsub('%s+', ''):gsub('\n', '') -- trim spaces and new lines
  --     -- return term == 'xterm-kitty'
  --     return false
  --   end,
  -- },
  -- {
  --   'Lilja/zellij.nvim',
  --   cond = function()
  --     return vim.env.ZELLIJ_SESSION_NAME ~= nil
  --   end,
  --   opts = { vimTmuxNavigatorKeybinds = true },
  -- },
  {
    'aserowy/tmux.nvim',
    -- event = 'VeryLazy',
    cond = function()
      return vim.env.TERM_PROGRAM == 'tmux'
    end,
    opts = {
      resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = false,
      },
    },
    -- keys = {
    --   { '<C-H>', [[<cmd>lua require("tmux").resize_left()<cr>]], desc = 'resize left' },
    --   { '<C-J>', [[<cmd>lua require("tmux").resize_down()<cr>]], desc = 'resize down' },
    --   { '<C-K>', [[<cmd>lua require("tmux").resize_up()<cr>]], desc = 'resize up' },
    --   { '<C-L>', [[<cmd>lua require("tmux").resize_right()<cr>]], desc = 'resize right' },
    -- },
  },
  -- Easier navigation between splits
  {
    'mrjones2014/smart-splits.nvim',
    cond = function()
      return true
      -- tmux.nvim handles most of what this plugin does
      -- return vim.env.TERM_PROGRAM == 'WezTerm'
    end,
    -- stylua: ignore
  keys = {
    -- { '<leader><leader>h', function() require('smart-splits').swap_buf_left() end, desc = ' swap buf left', mode = { 'n', 't' } },
    -- { '<leader><leader>l', function() require('smart-splits').swap_buf_right() end, desc = ' swap buf right', mode = { 'n', 't' } },
    -- { '<leader><leader>j', function() require('smart-splits').swap_buf_down() end, desc = ' swap buf down', mode = { 'n', 't' } },
    -- { '<leader><leader>k', function() require('smart-splits').swap_buf_up() end, desc = ' swap buf up', mode = { 'n', 't' } },
    { '<C-h>', function() require('smart-splits').move_cursor_left() end, desc = ' window left', mode = { 'n', 't' } },
    { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = ' window right', mode = { 'n', 't' } },
    { '<C-j>', function() require('smart-splits').move_cursor_down() end, desc = ' window down', mode = { 'n', 't' } },
    { '<C-k>', function() require('smart-splits').move_cursor_up() end, desc = ' window up', mode = { 'n', 't' } },
    { '<S-Left>', function() require('smart-splits').resize_left() end, desc = 'resize window left', mode = { 'n', 't' } },
    { '<S-Up>', function() require('smart-splits').resize_up() end, desc = 'resize window up', mode = { 'n', 't' } },
    { '<S-Down>', function() require('smart-splits').resize_down() end, desc = 'resize window down', mode = { 'n', 't' } },
    { '<S-Right>', function() require('smart-splits').resize_right() end, desc = 'resize window right', mode = { 'n', 't' } },
  },
  },

  {
    'DreamMaoMao/yazi.nvim',
    cmd = { 'Yazi' },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Better session management
  {
    'olimorris/persisted.nvim',
    lazy = false,
    priority = 1000,
    -- event = 'BufReadPre',
    -- cmd = { 'SessionLoad', 'SessionStop', 'SessionLoadLatest' },
    opts = {
      use_git_branch = true,
      should_autosave = function()
        if vim.bo.filetype == 'noice' then
          return false
        end
        return true
      end,
    },
  },

  {
    'windwp/nvim-spectre',
    lazy = true,
    -- stylua: ignore
    keys = {
      { '<leader>fr', function() require('spectre').open() end, desc = 'Replace in files (Spectre)', },
    },
  },

  {
    'Wansmer/treesj',
    cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
    -- stylua: ignore
    keys = {
      { 'J', function() require('treesj').toggle() end, desc = 'toggle treesj' },
      { '<leader>jm', function() require('treesj').toggle() end, desc = 'toggle treesj' },
      { '<leader>jj', function() require('treesj').join() end, desc = 'join treesj' },
      { '<leader>js', function() require('treesj').split() end, desc = 'split treesj' },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { use_default_keymaps = false },
  },

  {
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    cmd = 'Neogen',
    opts = { snippet_engine = 'luasnip' },
  },
  {
    'stevearc/conform.nvim',
    event = 'VeryLazy',
    keys = {
      -- stylua: ignore
      { '=', function() require('conform').format { async = true, lsp_fallback = true } end, mode = '', desc = 'Format buffer' },
    },
    opts = function()
      local prettier = { 'prettierd', 'prettier' }
      return {
        formatters_by_ft = {
          lua = { 'stylua' },
          -- Use a sub-list to run only the first available formatter
          javascript = { prettier },
          javascriptreact = { prettier },
          typescript = { prettier },
          typescriptreact = { prettier },
          css = { prettier },
          html = { prettier },
          markdown = { prettier },
          mdx = { prettier },
          astro = { prettier },
          scss = { prettier },
          yaml = { prettier },
          json = { prettier },
          jsonc = { prettier },
          bash = { 'beautysh' },
          sh = { 'beautysh' },
          zsh = { 'beautysh' },
          fish = { 'fish_indent' },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },
      }
    end,
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        css = { 'stylelint' },
        scss = { 'stylelint' },
        lua = { 'luacheck' },
        vim = { 'vint' },
        bash = { 'shellcheck' },
        sh = { 'shellcheck' },
      },
    },
    config = function(_, opts)
      require('lint').setup(opts)
      require('util').autocmd({ 'BufWritePost', 'InsertLeave' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
