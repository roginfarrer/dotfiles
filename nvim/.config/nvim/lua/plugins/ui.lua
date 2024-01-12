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
        astro = {
          icon = '󰑣',
          name = 'Astro',
          color = '#e63bac',
        },
      },
    },
  },

  -- Highlight symbols under cursor
  {
    'RRethy/vim-illuminate',
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
    enabled = false,
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

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
      -- local Util = require 'lazyvim.util'
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
              -- color = Util.ui.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              -- color = Util.ui.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              -- color = Util.ui.fg("Debug"),
            },
            {
              require('lazy.status').updates,
              cond = require('lazy.status').has_updates, --[[ color = Util.ui.fg 'Special' ]]
            },
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

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = function()
      local logo = [[
███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
      ]]

      logo = string.rep('\n', 8) .. logo .. '\n\n'

      local opts = {
        theme = 'doom',
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, '\n'),
          -- stylua: ignore
          center = {
            { action = "FzfLua files",                                             desc = " Find file",       icon = " ", key = "f" },
            { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
            { action = "FzfLua oldfiles",                                          desc = " Recent files",    icon = " ", key = "r" },
            { action = "FzfLua live_grep",                                         desc = " Find text",       icon = " ", key = "g" },
            { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
            { action = 'SessionLoad',                                              desc = " Restore Session", icon = " ", key = "s" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
          },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
        button.key_format = '  %s'
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'DashboardLoaded',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      return opts
    end,
  },

  {
    'j-hui/fidget.nvim',
    tag = 'v1.1.0',
    event = 'VeryLazy',
    opts = { notification = { override_vim_notify = true } },
  },

  -- Better `vim.notify()`
  -- {
  --   'rcarriga/nvim-notify',
  --   enabled = false,
  --   opts = {
  --     timeout = 3000,
  --     max_height = function()
  --       return math.floor(vim.o.lines * 0.75)
  --     end,
  --     max_width = function()
  --       return math.floor(vim.o.columns * 0.75)
  --     end,
  --   },
  --   init = function()
  --     -- when noice is not enabled, install notify on VeryLazy
  --     -- local Util = require 'lazyvim.util'
  --     -- if not Util.has 'noice.nvim' then
  --     --   Util.on_very_lazy(function()
  --     --     vim.notify = require 'notify'
  --     --   end)
  --     -- end
  --   end,
  --   keys = {
  --     {
  --       '<leader>un',
  --       function()
  --         require('notify').dismiss { silent = true, pending = true }
  --       end,
  --       desc = 'Dismiss all Notifications',
  --     },
  --   },
  -- },

  -- Noicer UI
  -- {
  --   'folke/which-key.nvim',
  --   opts = function(_, opts)
  --     if require('util').has 'noice.nvim' then
  --       opts.defaults['<leader>sn'] = { name = '+noice' }
  --     end
  --   end,
  -- },
  -- {
  --   'folke/noice.nvim',
  --   event = 'VeryLazy',
  --    -- stylua: ignore
  --   keys = {
  --     { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
  --     { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
  --     { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
  --     { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
  --     { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
  --     { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
  --     { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
  --   },
  --   opts = {
  --     messages = { enabled = true },
  --     -- cmdline = { view = 'cmdline' },
  --     lsp = {
  --       override = {
  --         -- override the default lsp markdown formatter with Noice
  --         ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
  --         -- override the lsp markdown formatter with Noice
  --         ['vim.lsp.util.stylize_markdown'] = true,
  --         -- override cmp documentation with Noice (needs the other options to work)
  --         ['cmp.entry.get_documentation'] = true,
  --       },
  --     },
  --     presets = {
  --       inc_rename = true,
  --       bottom_search = true,
  --       command_palette = true,
  --       long_message_to_split = true,
  --       lsp_doc_border = true,
  --     },
  --     commands = {
  --       all = {
  --         -- options for the message history that you get with `:Noice`
  --         view = 'split',
  --         opts = { enter = true, format = 'details' },
  --         filter = {},
  --       },
  --     },
  --     routes = {
  --       {
  --         filter = {
  --           event = 'msg_show',
  --           find = '%d+L, %d+B',
  --         },
  --         view = 'mini',
  --       },
  --       -- hide "written" messages
  --       {
  --         filter = {
  --           event = 'msg_show',
  --           kind = '',
  --           find = 'written',
  --         },
  --         opts = { skip = true },
  --       },
  --     },
  --     -- views = { mini = { win_options = { winblend = 0 } } },
  --   },
  -- },

  -- Easy set-up of Neovim's new statuscolumn feature
  { 'luukvbaal/statuscol.nvim', event = 'BufReadPost', opts = { setopt = true } },

  -- ui components
  { 'MunifTanjim/nui.nvim', lazy = true },

  { 'folke/zen-mode.nvim', cmd = 'ZenMode', opts = {
    wezterm = { enabled = true },
  } },

  { 'NvChad/nvim-colorizer.lua', event = 'VeryLazy', opts = {} },
  { 'b0o/incline.nvim', enabled = false, opts = {}, event = 'BufReadPost' },
}
