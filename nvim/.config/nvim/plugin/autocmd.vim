augroup Vimrc
  autocmd!

  " Return to last edit position when opening files (You want this!)
  autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

  autocmd InsertEnter * set cul
  autocmd InsertLeave * set nocul

  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="Substitute", timeout=250}

  autocmd TermOpen term://* setlocal listchars= nonumber

  " Equalize splits when window resizes
  autocmd VimResized * wincmd =

  " autocmd UIEnter * let g:gui_running = 1 | source $HOME/.config/nvim/gui.vim

  " Make the default filetype markdown
  " autocmd BufReadPost * if &ft == '' | set ft=markdown | endif

  autocmd BufReadPost *rc if &ft == '' | set ft=json | endif

  " Diagnostic group names changing in recent Neovim builds, this
  " fixes one that happens in a few colorschemes
  " autocmd ColorScheme * hi! link DiagnosticUnderlineWarn DiagnosticUnderlineWarning
  " autocmd ColorScheme * hi! link DiagnosticUnderlineInfo DiagnosticUnderlineInformation
  autocmd ColorScheme * hi! link FloatBorder LspSagaRenameBorder

  " autocmd Vimrc ColorScheme * hi! NormalFloat guibg=#131A24
  " autocmd Vimrc ColorScheme * hi! FloatBorder guifg=#719cd6 guibg=#131A24
augroup END
