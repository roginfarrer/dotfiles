return {
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

      local empty = {
        function()
          return ' '
        end,
        padding = 0,
        color = 'Normal',
      }

      return {
        options = {
          theme = 'auto',
          -- section_separators = { left = '', right = '' },
          -- component_separators = { left = '', right = '' },
          -- section_separators = { right = '', left = '' },
          -- component_separators = { left = '', right = '' },
          component_separators = '',
          section_separators = { left = '', right = '' },
          icons_enabled = true,
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
        },
        sections = {
          lualine_a = { { 'mode', separator = { left = '' }, padding = { right = 1 } } },

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
            { 'grapple' },
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
          lualine_z = { { lsp_client_names, separator = { right = '' }, padding = { left = 1 } } },
        },
        -- inactive_winbar = {
        --   lualine_a = { { 'filename', path = 1 } },
        -- },
      }
    end,
  },
}
