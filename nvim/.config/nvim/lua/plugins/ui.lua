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
    },
  },

  -- Better `vim.notify()`
  {
    'rcarriga/nvim-notify',
    keys = {
      {
        '<leader>nd',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Delete all Notifications',
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      top_down = false,
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

  -- Show buffers as tabs
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        numbers = 'none',
        close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
        right_mouse_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
        left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
      },
    },
    keys = {
      { '<A-h>', '<cmd>BufferLineCyclePrev<CR>' },
      { '<A-l>', '<cmd>BufferLineCycleNext<CR>' },
    },
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

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
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

          return ' LSP: ' .. table.concat(clients, ',')
        end

        return msg
      end

      return {
        options = {
          theme = 'auto',
          section_separators = { right = '', left = '' },
          component_separators = { left = '', right = '' },
          icons_enabled = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff' },
          lualine_c = { { 'filename', file_status = true } },
          lualine_x = { { 'diagnostics', sources = { 'nvim_diagnostic' } } },
          lualine_y = { 'filetype' },
          lualine_z = { lsp_client_names },
        },
      }
    end,
  },

  -- Better folding
  {
    'kevinhwang91/nvim-ufo',
    event = 'BufReadPost',
    dependencies = { 'kevinhwang91/promise-async' },
    -- stylua: ignore
    keys = {
      { 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds (UFO)', },
      { 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds (UFO)', },
    },
    opts = {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    },
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
        dashboard.button('f', ' ' .. ' Find file', ':lua require("plugins.configs.telescope").project_files()<CR>'),
        dashboard.button('n', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', ' ' .. ' Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', ' ' .. ' Config', ':e $MYVIMRC <CR>'),
        dashboard.button('s', '勒' .. ' Restore Session', ':SessionLoad<CR>'),
        dashboard.button('l', '鈴' .. ' Lazy', ':Lazy<CR>'),
        dashboard.button('q', ' ' .. ' Quit', ':qa<CR>'),
        dashboard.button('k', 'Open Kitty Config', '<cmd>e ~/dotfiles/kitty/.config/kitty/kitty.conf<CR>'),
        dashboard.button('f', 'Open Fish Config', '<cmd>e ~/dotfiles/fish/.config/fish/config.fish<CR>'),
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

  -- Noicer UI
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  -- stylua: ignore
  keys = {
    { '<S-Enter>', function() require('noice').redirect(vim.fn.getcmdline()) end, mode = 'c', desc = 'Redirect Cmdline' },
    { '<leader>snl', function() require('noice').cmd 'last' end, desc = 'Noice Last Message', },
    { '<leader>snh', function() require('noice').cmd 'history' end, desc = 'Noice History', },
    { '<leader>sna', function() require('noice').cmd 'all' end, desc = 'Noice All', },
    { '<c-f>', function() if not require('noice.lsp').scroll(4) then return '<c-f>' end end, silent = true, expr = true, desc = 'Scroll forward', },
    { '<c-b>', function() if not require('noice.lsp').scroll(-4) then return '<c-b>' end end, silent = true, expr = true, desc = 'Scroll backward', },
  },
    opts = {
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
    },
  },
}
