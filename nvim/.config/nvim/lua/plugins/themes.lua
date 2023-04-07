local plugins = {
  { 'folke/tokyonight.nvim' },
  { 'AlexvZyl/nordic.nvim' },
  {
    'rebelot/kanagawa.nvim',
    opts = {
      compile = true,
      statementStyle = { bold = false },
      commentStyle = { italic = false },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- NormalFloat = { fg = colors.fg, bg = colors.bg },
          -- FloatBorder = { fg = colors.fg_border, bg = colors.bg },
          -- NoiceCmdline = { fg = theme.ui.fg },
          NoiceCmdlinePopupBorder = { bg = theme.ui.bg },
          NoiceCmdlineIcon = { link = '@character.special' },
          SignColumn = { bg = theme.ui.bg },
          FoldColumn = { bg = theme.ui.bg },
          CursorLineNr = { bg = theme.ui.bg },
          LineNr = { bg = theme.ui.bg },
          IlluminatedWordRead = { link = 'Visual' },
          IlluminatedWordText = { link = 'Visual' },
          IlluminatedWordWrite = { link = 'Visual' },
          -- Block Telescope
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        }
      end,
    },
  },
  { 'JoosepAlviste/palenightfall.nvim' },
  { 'EdenEast/nightfox.nvim' },
  { 'rmehri01/onenord.nvim' },
  { 'olimorris/onedarkpro.nvim' },
  {
    'ellisonleao/gruvbox.nvim',
    opts = function()
      local colors = require('gruvbox.palette').get_base_colors()
      return {
        italic = { strings = false, comments = false, keywords = false },
        bold = false,
        overrides = {
          NoiceCmdlinePopupBorder = { link = 'Normal' },
          NoiceCmdlineIcon = { link = '@character.special' },
          IlluminatedWordRead = { bg = colors.bg2 },
          IlluminatedWordText = { bg = colors.bg2 },
          IlluminatedWordWrite = { bg = colors.bg2 },
          -- Make more like Zed's Gruvbox Dark
          ['Identifier'] = { fg = 'NONE', bg = 'NONE' },
          ['Function'] = { fg = 'NONE', bg = 'NONE' },
          ['Structure'] = { fg = 'NONE', bg = 'NONE' },
          ['@constructor'] = { link = 'GruvboxBlue' },
          ['@punctuation.bracket'] = { link = 'GruvboxGray' },
          ['@punctuation.special'] = { link = 'GruvboxFg0' },
          ['@variable'] = { link = 'GruvboxBlue' },
          ['@field'] = { link = 'GruvboxFg0' },
          ['@property'] = { link = 'GruvboxFg0' },
          ['@punctuation.delimiter'] = { link = 'GruvboxFg0' },
          ['@operator'] = { link = 'GruvboxAqua' },
          ['@function.call'] = { link = 'GruvboxGreen' },
          ['@function.builtin'] = { link = 'GruvboxRed' },
          ['@conditional.ternary'] = { link = 'GruvboxFg0' },
          ['@type'] = { link = 'GruvboxYellow' },
        },
      }
    end,
  },
  {
    'sainnhe/gruvbox-material',
    init = function()
      vim.g.gruvbox_material_background = 'hard'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      local cat = require 'catppuccin'
      local cp = require('catppuccin.palettes').get_palette()
      local util = require 'catppuccin.utils.colors'

      cat.setup {
        no_italic = true,
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
            barbecue = {
              enabled = true,
              dim_dirname = true,
            },
          },
          illuminate = true,
          coc_nvim = false,
          lsp_trouble = false,
          cmp = true,
          lsp_saga = true,
          gitgutter = false,
          gitsigns = true,
          telescope = true,
          nvimtree = {
            enabled = false,
            show_root = true,
            transparent_panel = false,
          },
          neotree = {
            enabled = false,
            show_root = true,
            transparent_panel = false,
          },
          dap = {
            enabled = true,
            enable_ui = true,
          },
          which_key = true,
          indent_blankline = {
            enabled = false,
            colored_indent_levels = false,
          },
          dashboard = false,
          neogit = true,
          vim_sneak = false,
          fern = false,
          barbar = false,
          bufferline = true,
          markdown = true,
          lightspeed = false,
          leap = true,
          ts_rainbow = true,
          hop = false,
          notify = true,
          telekasten = false,
          symbols_outline = false,
          mini = true,
          mason = true,
          neotest = true,
          noice = true,
          treesitter_context = true,
          octo = true,
        },
        custom_highlights = {
          VertSplit = { fg = cp.black4 },
          -- aka horizontal split
          StatusLineNC = { fg = cp.black4 },
          InclineNormal = {
            fg = util.darken(cp.lavender, 0.3),
            bg = util.darken(cp.lavender, 0.8),
          },
          InclineNormalNC = {
            fg = util.darken(cp.lavender, 0.3),
            bg = util.darken(cp.lavender, 0.8),
          },
          DiffAdd = { bg = util.darken(cp.green, 0.2) },
          DiffDelete = { bg = util.darken(cp.red, 0.2) },
          DiffText = { bg = util.darken(cp.yellow, 0.3) },
          TelescopePromptPrefix = { bg = cp.crust },
          TelescopePromptNormal = { bg = cp.crust },
          TelescopeResultsNormal = { bg = cp.mantle },
          TelescopePreviewNormal = { bg = cp.crust },
          TelescopePromptBorder = { bg = cp.crust, fg = cp.crust },
          TelescopeResultsBorder = { bg = cp.mantle, fg = cp.crust },
          TelescopePreviewBorder = { bg = cp.crust, fg = cp.crust },
          TelescopePromptTitle = { fg = cp.crust, bg = cp.lavender },
          TelescopeResultsTitle = { fg = cp.crust },
          TelescopePreviewTitle = { fg = cp.crust, bg = cp.lavender },
        },
      }
    end,
  },
}

for _, plugin in ipairs(plugins) do
  plugin.lazy = true
  plugin.priority = 1000
end

return plugins
