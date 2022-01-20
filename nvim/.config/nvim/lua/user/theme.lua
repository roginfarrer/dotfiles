vim.g.tokyonight_italic_functions = true
-- vim.cmd([[colorscheme tokyonight]])

-- local nightfox = require 'nightfox'
-- nightfox.setup({ fox = 'nordfox' })
-- nightfox.load()

require('catppuccin').setup {
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
        errors = 'underline',
        hints = 'underline',
        warnings = 'underline',
        information = 'underline',
      },
    },
    lsp_trouble = false,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = false,
      show_root = false,
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
    lightspeed = true,
    ts_rainbow = false,
    hop = false,
    notify = true,
    telekasten = false,
  },
}
vim.cmd [[colorscheme catppuccin]]

vim.cmd [[
augroup lsp_underlines
  autocmd!
  au ColorScheme * hi DiagnosticUnderlineError cterm=undercurl gui=undercurl
        \ | hi DiagnosticUnderlineWarn cterm=undercurl gui=undercurlhi
        \ | hi DiagnosticUnderlineInfo cterm=undercurl gui=undercurl
        \ | hi DiagnosticUnderlineHint cterm=undercurl gui=undercurl
        \ | hi LspDiagnosticsUnderlineError cterm=undercurl gui=undercurl
        \ | hi LspDiagnosticsUnderlineWarning cterm=undercurl gui=undercurl
        \ | hi LspDiagnosticsUnderlineInformation cterm=undercurl gui=undercurl
        \ | hi LspDiagnosticsUnderlineHint cterm=undercurl gui=undercurl
augroup END
]]
