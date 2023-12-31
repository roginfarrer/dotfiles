local plugins = {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
      variant = 'moon',
      disable_italics = true,
      highlight_groups = {
        TelescopePromptPrefix = { bg = 'surface', fg = 'iris' },
        TelescopePromptNormal = { bg = 'surface' },
        TelescopePromptTitle = { fg = 'surface', bg = 'iris' },
        TelescopePromptBorder = { bg = 'surface', fg = 'surface' },
        TelescopeResultsNormal = { bg = 'overlay' },
        TelescopeResultsBorder = { bg = 'overlay', fg = 'overlay' },
        TelescopeResultsTitle = { fg = 'overlay' },
        TelescopePreviewBorder = { bg = 'surface', fg = 'surface' },
        TelescopePreviewTitle = { fg = 'surface', bg = 'surface' },
        TelescopePreviewNormal = { bg = 'surface' },
        TelescopeSelection = { fg = 'text', bg = 'base' },
        TelescopeSelectionCaret = { fg = 'iris', bg = 'iris' },
        IlluminatedWordRead = { bg = 'highlight_med' },
        IlluminatedWordText = { bg = 'highlight_med' },
        IlluminatedWordWrite = { bg = 'highlight_med' },
      },
    },
  },
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
    opts = function()
      local cp = require('catppuccin.palettes').get_palette()
      local util = require 'catppuccin.utils.colors'

      return {
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
              enabled = false,
              dim_dirname = true,
            },
          },
          alpha = true,
          cmp = true,
          dap = { enabled = true, enable_ui = true },
          flash = true,
          gitsigns = true,
          illuminate = true,
          indent_blankline = { enabled = false },
          lsp_trouble = true,
          markdown = true,
          mason = true,
          mini = true,
          navic = { enabled = false, custom_bg = cp.mantle },
          neogit = true,
          neotest = true,
          neotree = true,
          -- noice = true,
          -- notify = true,
          octo = true,
          symbols_outline = false,
          telescope = { enabled = true, style = 'nvchad' },
          which_key = true,
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
          FzfLuaBorder = { bg = cp.crust, fg = cp.crust },
          -- FzfLuaHelpBorder = { bg = cp.crust, fg = cp.crust },
          FzfLuaPreviewBorder = { bg = cp.mantle, fg = cp.mantle },
          FzfLuaPreviewNormal = { bg = cp.mantle },
          FzfLuaScrollBorderEmpty = { bg = cp.base, fg = cp.base },
          FzfLuaScrollBorderFull = { bg = cp.base, fg = cp.base },
          FzfLuaScrollFloatEmpty = { bg = cp.base, fg = cp.lavender },
          FzfLuaScrollFloatFull = { bg = cp.base, fg = cp.lavender },
        },
      }
    end,
  },
}

-- for _, plugin in ipairs(plugins) do
--   plugin.lazy = true
--   plugin.priority = 1000
-- end

return plugins
