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
  " Will apply to filenames that don't have an extension
  autocmd BufNewFile,BufRead * if &ft == '' | set ft=markdown | endif
  " autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | set ft=markdown | endif

  autocmd BufNewFile,BufRead *eslintrc,*prettierrc set ft=json
augroup END

