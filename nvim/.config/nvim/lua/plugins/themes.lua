local plugins = {
  { 'dgox16/oldworld.nvim' },
  {
    'projekt0n/github-nvim-theme',
    config = function()
      require('github-theme').setup()
    end,
    event = 'VeryLazy',
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
      disable_italics = true,
      -- styles = {
      --   transparency = true,
      -- },
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
        IlluminatedWordRead = { bg = 'highlight_low' },
        IlluminatedWordText = { bg = 'highlight_low' },
        IlluminatedWordWrite = { bg = 'highlight_low' },
        -- FzfLuaBorder = { bg = 'overlay', fg = 'overlay' },
        -- FzfLuaPreviewBorder = { bg = 'surface', fg = 'surface' },
        -- FzfLuaPreviewNormal = { bg = 'surface' },
        -- FzfLuaScrollBorder = { bg = 'overlay', fg = 'overlay' },
        -- FzfLuaScrollBorderEmpty = { bg = 'surface', fg = 'surface' },
        -- FzfLuaScrollBorderFull = { bg = 'surface', fg = 'surface' },
        -- FzfLuaScrollFloatEmpty = { bg = 'surface', fg = 'iris' },
        -- FzfLuaScrollFloatFull = { bg = 'surface', fg = 'iris' },
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
    'sainnhe/gruvbox-material',
    init = function()
      vim.g.gruvbox_material_background = 'hard'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = function()
      local cp = require('catppuccin.palettes').get_palette()
      local util = require 'catppuccin.utils.colors'

      return {
        no_italic = false,
        integrations = {
          lsp_saga = true,
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
          },
          blink_cmp = true,
          dap = true,
          dap_ui = true,
          diffview = true,
          fidget = true,
          fzf = true,
          gitsigns = true,
          grug_far = true,
          harpoon = true,
          headlines = true,
          illuminate = { enabled = true, lsp = true },
          indent_blankline = { enabled = false },
          lsp_trouble = true,
          markdown = true,
          mason = true,
          mini = true,
          navic = { enabled = false, custom_bg = cp.mantle },
          neotest = true,
          neotree = true,
          noice = true,
          notify = true,
          octo = true,
          render_markdown = true,
          telescope = { enabled = true, style = 'nvchad' },
          ufo = true,
          which_key = true,
          snacks = true,
        },
        highlight_overrides = {
          mocha = {
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
            -- FzfLuaBorder = { bg = cp.crust, fg = cp.crust },
            -- -- FzfLuaHelpBorder = { bg = cp.crust, fg = cp.crust },
            -- FzfLuaPreviewBorder = { bg = cp.mantle, fg = cp.mantle },
            -- FzfLuaPreviewNormal = { bg = cp.mantle },
            -- FzfLuaScrollBorderEmpty = { bg = cp.base, fg = cp.base },
            -- FzfLuaScrollBorderFull = { bg = cp.base, fg = cp.base },
            -- FzfLuaScrollFloatEmpty = { bg = cp.base, fg = cp.lavender },
            -- FzfLuaScrollFloatFull = { bg = cp.base, fg = cp.lavender },
            DashboardHeader = { fg = cp.yellow },
          },
        },
      }
    end,
  },
}

for _, plugin in ipairs(plugins) do
  plugin.priority = 1000
  plugin.lazy = true
end

return plugins
