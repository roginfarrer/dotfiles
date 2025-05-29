return {
  {
    'b0o/incline.nvim',
    event = 'VeryLazy',
    dependencies = {
      'echasnovski/mini.icons',
    },
    opts = function()
      local helpers = require 'incline.helpers'
      local MiniIcons = require 'mini.icons'
      return {
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          if filename == '' then
            filename = '[No Name]'
          end
          local ft_icon, hl = MiniIcons.get('file', filename)
          local hl_info = vim.api.nvim_get_hl(0, { name = hl })
          local ft_color = string.format('#%06x', hl_info.fg)
          local modified = vim.bo[props.buf].modified
          return {
            ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
            ' ',
            { filename, gui = modified and 'bold,italic' or 'bold' },
            ' ',
            guibg = '#44406e',
          }
        end,
      }
    end,
  },
}
