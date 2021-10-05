augroup Vimrc
  autocmd!

  " Return to last edit position when opening files (You want this!)
  autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

  autocmd InsertEnter * set cul
  autocmd InsertLeave * set nocul

  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="Substitute", timeout=250}

  autocmd TermOpen * setlocal listchars= nonumber | startinsert

  " Equalize splits when window resizes
  autocmd VimResized * wincmd =

  autocmd UIEnter * let g:gui_running = 1 | source $HOME/.config/nvim/gui.vim

  " Make the default filetype markdown
  autocmd BufNewFile,BufRead * if &ft == '' | set ft=markdown | endif

  autocmd BufNewFile,BufRead *eslintrc,*prettierrc set ft=json

  autocmd ColorScheme * 
        \ hi! link DiagnosticUnderlineError LspDiagnosticsUnderlineError  |
        \ hi! link DiagnosticUnderlineHint LspDiagnosticsUnderlineHint |
        \ hi! link DiagnosticUnderlineInformation LspDiagnosticsUnderlineInformation |
        \ hi! link DiagnosticUnderlineWarning LspDiagnosticsUnderlineWarning |
        \ hi! link DiagnosticUnderlineWarn LspDiagnosticsUnderlineWarning |
 
        \ hi! link DiagnosticFloatingError LspDiagnosticsFloatingError  |
        \ hi! link DiagnosticFloatingHint LspDiagnosticsFloatingHint |
        \ hi! link DiagnosticFloatingInformation LspDiagnosticsFloatingInformation |
        \ hi! link DiagnosticFloatingWarning LspDiagnosticsFloatingWarning |

        \ hi! link DiagnosticDefaultError LspDiagnosticsDefaultError  |
        \ hi! link DiagnosticDefaultHint LspDiagnosticsDefaultHint |
        \ hi! link DiagnosticDefaultInformation LspDiagnosticsDefaultInformation |
        \ hi! link DiagnosticDefaultWarning LspDiagnosticsDefaultWarning |

        \ hi! link DiagnosticError LspDiagnosticsError  |
        \ hi! link DiagnosticHint LspDiagnosticsHint |
        \ hi! link DiagnosticInfo LspDiagnosticsInfo |
        \ hi! link DiagnosticWarn LspDiagnosticsWarn |

        \ hi! link DiagnosticsVirtualTextError       LspDiagnosticsVirtualTextError  |
        \ hi! link DiagnosticsVirtualTextWarning     LspDiagnosticsVirtualTextWarning  |
        \ hi! link DiagnosticsVirtualTextInformation LspDiagnosticsVirtualTextInformation  |
        \ hi! link DiagnosticsVirtualTextHint        LspDiagnosticsVirtualTextHint  |
augroup END

" I don't know why these don't work in in the augroup above...
autocmd Vimrc ColorScheme * hi! NormalFloat guibg=#131A24
autocmd Vimrc ColorScheme * hi! FloatBorder guifg=#719cd6 guibg=#131A24
