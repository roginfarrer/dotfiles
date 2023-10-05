return {
  {
    'kyazdani42/nvim-web-devicons',
    lazy = true,
    opts = {
      override = {
        lir_folder_icon = {
          icon = '',
          color = '#7ebae4',
          name = 'LirFolderNode',
        },
      },
      override_by_extension = {
        org = {
          icon = '',
          name = 'Org',
          color = '#77aa99',
        },
      },
    },
  },

  -- Highlight symbols under cursor
  {
    'RRethy/vim-illuminate',
    -- enabled = false,
    event = 'BufReadPost',
    opts = {
      delay = 100,
      large_file_cutoff = 1500,
      filetypes_denylist = {
        'dirvish',
        'fugitive',
        'oil',
        'lir',
        'alpha',
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set('n', key, function()
          require('illuminate')['goto_' .. dir .. '_reference'](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
      end

      map(']]', 'next')
      map('[[', 'prev')

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map(']]', 'next', buffer)
          map('[[', 'prev', buffer)
        end,
      })
    end,
    keys = {
      { ']]', desc = 'Next Reference' },
      { '[[', desc = 'Prev Reference' },
    },
  },

  -- Prettier vim.ui
  {
    'stevearc/dressing.nvim',
    lazy = true,
    opts = {
      win_options = { winblend = 0 },
    },
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.input(...)
      end
    end,
  },

  -- Animate and manage split sizes
  {
    'anuvyklack/windows.nvim',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    event = 'BufAdd',
    init = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
    end,
    opts = {
      animation = {
        fps = 40,
        duration = 200,
      },
    },
  },

  -- lsp symbol navigation for lualine
  {
    'SmiteshP/nvim-navic',
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require('lazyvim.util').on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = ' ',
        highlight = true,
        depth_limit = 5,
        icons = require('lazyvim.config').icons.kinds,
      }
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
      local Util = require 'lazyvim.util'
      local icons = require('ui.icons').lazy

      local function lsp_client_names()
        local msg = 'no active lsp'

        if #vim.lsp.buf_get_clients() then
          local clients = {}
          for _, client in pairs(vim.lsp.buf_get_clients()) do
            table.insert(clients, client.name)
          end

          if next(clients) == nil then
            return msg
          end

          return '  LSP: ' .. table.concat(clients, ',')
        end

        return msg
      end

      return {
        options = {
          theme = 'auto',
          section_separators = { right = '', left = '' },
          -- component_separators = { left = '', right = '' },
          icons_enabled = true,
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            { 'branch' },
          },
          lualine_c = {
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            { 'filename', symbols = { modified = '', readonly = '', unnamed = '', newfile = '' } },
            -- stylua: ignore
            -- {
            --   function() return require("nvim-navic").get_location() end,
            --   cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            -- },
          },
          lualine_x = {
             -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.fg("Debug"),
            },
            { require('lazy.status').updates, cond = require('lazy.status').has_updates, color = Util.fg 'Special' },
          },
          lualine_y = {
            {
              'diagnostics',
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            {
              'diff',
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_z = { lsp_client_names },
        },
        -- inactive_winbar = {
        --   lualine_a = { { 'filename', path = 1 } },
        -- },
      }
    end,
  },

  -- Better folding
  {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    dependencies = { 'kevinhwang91/promise-async' },
    init = function()
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    -- stylua: ignore
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
        desc = 'Open all folds (UFO)',
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
        desc = 'Close all folds (UFO)',
      },
    },
    config = true,
    -- opts = {
    --   provider_selector = function()
    --     return { 'treesitter', 'indent' }
    --   end,
    -- },
  },

  -- Splash screen
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    opts = function()
      local dashboard = require 'alpha.themes.dashboard'

      local ascii = {
        [[███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
        [[████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
        [[██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
        [[██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
        [[██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
        [[╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
      }

      -- dynamic header padding
      local fn = vim.fn
      local marginTopPercent = 0.2
      local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }

      dashboard.opts.layout[1].val = headerPadding
      dashboard.section.header.val = ascii
      dashboard.section.header.opts.hl = 'Character'
      dashboard.section.buttons.val = {
        dashboard.button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
        dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', ' ' .. ' Find text', ':Telescope live_grep <CR>'),
        dashboard.button('s', '勒' .. ' Restore Session', ':SessionLoad<CR>'),
        dashboard.button('l', '鈴' .. ' Lazy', ':Lazy<CR>'),
        dashboard.button('q', ' ' .. ' Quit', ':qa<CR>'),
        -- dashboard.button('k', 'Open Kitty Config', '<cmd>e ~/dotfiles/kitty/.config/kitty/kitty.conf<CR>'),
        -- dashboard.button('f', 'Open Fish Config', '<cmd>e ~/dotfiles/fish/.config/fish/config.fish<CR>'),
      }
      dashboard.section.footer.opts.hl = 'Type'
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'AlphaReady',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      require('alpha').setup(dashboard.config)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = '⚡ Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- Better `vim.notify()`
  {
    'rcarriga/nvim-notify',
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require 'lazyvim.util'
      if not Util.has 'noice.nvim' then
        Util.on_very_lazy(function()
          vim.notify = require 'notify'
        end)
      end
    end,
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Dismiss all Notifications',
      },
    },
  },

  -- Noicer UI
  {
    'folke/which-key.nvim',
    opts = function(_, opts)
      if require('lazyvim.util').has 'noice.nvim' then
        opts.defaults['<leader>sn'] = { name = '+noice' }
      end
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
     -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
    opts = {
      messages = { enabled = false },
      cmdline = { view = 'cmdline' },
      lsp = {
        override = {
          -- override the default lsp markdown formatter with Noice
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          -- override the lsp markdown formatter with Noice
          ['vim.lsp.util.stylize_markdown'] = true,
          -- override cmp documentation with Noice (needs the other options to work)
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        inc_rename = true,
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = 'split',
          opts = { enter = true, format = 'details' },
          filter = {},
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            find = '%d+L, %d+B',
          },
          view = 'mini',
        },
        -- hide "written" messages
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'written',
          },
          opts = { skip = true },
        },
      },
      -- views = { mini = { win_options = { winblend = 0 } } },
    },
  },

  -- Easy set-up of Neovim's new statuscolumn feature
  { 'luukvbaal/statuscol.nvim', event = 'BufReadPost', opts = { setopt = true } },

  -- ui components
  { 'MunifTanjim/nui.nvim', lazy = true },

  { 'folke/zen-mode.nvim', cmd = 'ZenMode', opts = {
    wezterm = { enabled = true },
  } },

  { 'NvChad/nvim-colorizer.lua', event = 'VeryLazy', opts = {} },
}
