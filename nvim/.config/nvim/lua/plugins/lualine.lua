return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    -- init = function()
    --   vim.g.lualine_laststatus = vim.o.laststatus
    --   if vim.fn.argc(-1) > 0 then
    --     -- set an empty statusline till lualine loads
    --     vim.o.statusline = ' '
    --   else
    --     -- hide the statusline on the starter page
    --     vim.o.laststatus = 0
    --   end
    -- end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require 'lualine_require'
      lualine_require.require = require

      -- local Util = require 'lazyvim.util'
      local icons = require('ui.icons').lazy

      local function lsp_client_names()
        local msg = 'no active lsp'

        if #vim.lsp.get_clients() then
          local clients = {}
          for _, client in pairs(vim.lsp.get_clients()) do
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
          component_separators = '',
          section_separators = { left = '', right = '' },
          icons_enabled = true,
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'snacks_dashboard' } },
        },
        sections = {
          lualine_a = { { 'mode', separator = { left = '' }, padding = { right = 1 } } },

          lualine_b = {
            { 'branch' },
          },
          lualine_c = {
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            { 'filename', symbols = { modified = '', readonly = '', unnamed = '', newfile = '' } },
          },
          lualine_x = {
            { 'grapple' },
             -- stylua: ignore
            {
              function() return require("noice").api.status.command end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              -- color = Util.ui.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
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
        extensions = { 'fzf', 'lazy', 'oil', 'trouble', 'quickfix', 'nvim-dap-ui', 'mason' },
        -- inactive_winbar = {
        --   lualine_a = { { 'filename', path = 1 } },
        -- },
      }
    end,
  },
}
