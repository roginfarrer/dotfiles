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

  autocmd UIEnter * let g:gui_running = 1 | source $HOME/.config/nvim/gui.vim

  " Make the default filetype markdown
  autocmd BufNewFile,BufRead * if &ft == '' | set ft=markdown | endif

  autocmd BufNewFile,BufRead *rc if &ft == '' | set ft=json | endif
augroup END

" I don't know why these don't work in in the augroup above...
autocmd Vimrc ColorScheme * hi! NormalFloat guibg=#131A24
autocmd Vimrc ColorScheme * hi! FloatBorder guifg=#719cd6 guibg=#131A24
