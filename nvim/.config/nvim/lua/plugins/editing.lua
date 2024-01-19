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

  -- Debugging utils
  {
    'folke/which-key.nvim',
    opts = function(_, opts)
      opts.defaults['g?'] = { name = '+debugprint' }
    end,
  },
  -- {
  --   'echasnovski/mini.clue',
  --   opts = function(_, opts)
  --     table.insert(opts.triggers, { mode = 'n', keys = 'g?', desc = '+debugprint' })
  --   end,
  -- },
  {
    'andrewferrier/debugprint.nvim',
    opts = {},
    -- Remove the following line to use development versions,
    -- not just the formal releases
    version = '*',
    keys = {
      { 'g?p', desc = 'Plain debug below' },
      { 'g?P', desc = 'Plain debug above' },
      { 'g?v', desc = 'Variable debug below', mode = { 'v', 'n' } },
      { 'g?V', desc = 'Variable debug above', mode = { 'v', 'n' } },
      { 'g?o', desc = 'Variable debug below', mode = 'o' },
      { 'g?O', desc = 'Variable debug above', mode = 'o' },
    },
  },

  {
    'echasnovski/mini.files',
    enabled = false,
    opts = {
      windows = { width_nofocus = 25 },
      options = {
        permanent_delete = false,
      },
      content = {
        filter = function(entry)
          return entry.fs_type ~= 'file' or entry.name ~= '.DS_Store'
        end,
        sort = function(entries)
          local function compare_alphanumerically(e1, e2)
            -- Put directories first.
            if e1.is_dir and not e2.is_dir then
              return true
            end
            if not e1.is_dir and e2.is_dir then
              return false
            end
            -- Order numerically based on digits if the text before them is equal.
            if e1.pre_digits == e2.pre_digits and e1.digits ~= nil and e2.digits ~= nil then
              return e1.digits < e2.digits
            end
            -- Otherwise order alphabetically ignoring case.
            return e1.lower_name < e2.lower_name
          end

          local sorted = vim.tbl_map(function(entry)
            local pre_digits, digits = entry.name:match '^(%D*)(%d+)'
            if digits ~= nil then
              digits = tonumber(digits)
            end

            return {
              fs_type = entry.fs_type,
              name = entry.name,
              path = entry.path,
              lower_name = entry.name:lower(),
              is_dir = entry.fs_type == 'directory',
              pre_digits = pre_digits,
              digits = digits,
            }
          end, entries)
          table.sort(sorted, compare_alphanumerically)
          -- Keep only the necessary fields.
          return vim.tbl_map(function(x)
            return { name = x.name, fs_type = x.fs_type, path = x.path }
          end, sorted)
        end,
      },
    },
    config = function(_, opts)
      local MiniFiles = require 'mini.files'
      MiniFiles.setup(opts)

      local copy_path = function()
        -- Works only if cursor is on the valid file system entry
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        vim.fn.setreg('+', cur_directory)
        vim.notify('Copied "' .. cur_directory .. '" to the clipboard!')
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          vim.keymap.set('n', '<leader>yf', copy_path, { buffer = args.data.buf_id })
        end,
      })
    end,
    -- stylua: ignore
    keys = {
      { '-', function() require('mini.files').open(vim.api.nvim_buf_get_name(0), true) end, desc = 'Open mini.files', },
    },
  },

  {
    'aserowy/tmux.nvim',
    lazy = false,
    opts = {
      -- Conflicts with Yanky, generally slows things down
      copy_sync = { enable = false },
      resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = false,
        resize_step_x = 5,
        resize_step_y = 5,
      },
    },
    keys = {
      { '<C-h>', [[<cmd>lua require'tmux'.move_left()<cr>]], desc = 'move bottom' },
      { '<C-j>', [[<cmd>lua require'tmux'.move_bottom()<cr>]], desc = 'move left' },
      { '<C-k>', [[<cmd>lua require'tmux'.move_top()<cr>]], desc = 'move top' },
      { '<C-l>', [[<cmd>lua require'tmux'.move_right()<cr>]], desc = 'move right' },
      { '<S-Left>', [[<cmd>lua require("tmux").resize_left()<cr>]], desc = 'resize left' },
      { '<S-Down>', [[<cmd>lua require("tmux").resize_down()<cr>]], desc = 'resize down' },
      { '<S-Up>', [[<cmd>lua require("tmux").resize_up()<cr>]], desc = 'resize up' },
      { '<S-Right>', [[<cmd>lua require("tmux").resize_right()<cr>]], desc = 'resize right' },
    },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
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
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
    keys = {
      {
        '=',
        function()
          require('conform').format { async = true, lsp_fallback = true }
          vim.notify('Buffer formatted!', vim.log.levels.INFO)
        end,
        desc = 'Format buffer',
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
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
          astro = { 'prettier' },
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
