augroup lsp_underlines
  autocmd!
  au ColorScheme * hi DiagnosticUnderlineError cterm=undercurl gui=undercurl
        \ | hi DiagnosticUnderlineWarn cterm=undercurl gui=undercurlhi DiagnosticUnderlineInfo cterm=undercurl gui=undercurl
        \ | hi DiagnosticUnderlineHint cterm=undercurl gui=undercurl
        \ | hi LspDiagnosticsUnderlineError cterm=undercurl gui=undercurl
        \ | hi LspDiagnosticsUnderlineWarning cterm=undercurl gui=undercurl
        \ | hi LspDiagnosticsUnderlineInformation cterm=undercurl gui=undercurl
        \ | hi LspDiagnosticsUnderlineHint cterm=undercurl gui=undercurl
augroup END
