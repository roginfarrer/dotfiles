local cat = require 'catppuccin'
local cp = require('catppuccin.api.colors').get_colors()
local util = require 'catppuccin.utils.util'

cat.setup {
  styles = {
    comments = 'NONE',
    functions = 'NONE',
    keywords = 'NONE',
    strings = 'NONE',
    variables = 'NONE',
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = 'italic',
        hints = 'italic',
        warnings = 'italic',
        information = 'italic',
      },
      underlines = {
        errors = 'undercurl',
        hints = 'undercurl',
        warnings = 'undercurl',
        information = 'undercurl',
      },
    },
    lsp_trouble = false,
    cmp = true,
    lsp_saga = true,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = false,
    },
    which_key = true,
    indent_blankline = {
      enabled = false,
      colored_indent_levels = false,
    },
    dashboard = false,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = false,
    ts_rainbow = true,
    hop = false,
    notify = true,
    telekasten = false,
  },
}
cat.remap {
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
}

vim.g.catppuccin_flavour = 'mocha'
vim.cmd [[colorscheme catppuccin]]
