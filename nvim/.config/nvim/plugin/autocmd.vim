augroup Vimrc
  autocmd!
augroup END

" Return to last edit position when opening files (You want this!)
autocmd Vimrc BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd Vimrc InsertEnter * set cul
autocmd Vimrc InsertLeave * set nocul

autocmd Vimrc TextYankPost * silent! lua vim.highlight.on_yank{higroup="Substitute", timeout=250}

autocmd Vimrc TermOpen * setlocal listchars= nonumber | startinsert

" Equalize splits when window resizes
autocmd Vimrc VimResized * wincmd =

autocmd Vimrc UIEnter * let g:gui_running = 1 | source $HOME/.config/nvim/gui.vim

" Make the default filetype markdown
" Will apply to filenames that don't have an extension
autocmd Vimrc BufNewFile,BufRead * if expand('%:t') !~ '\.' | setlocal ft=markdown | endif

autocmd Vimrc BufNewFile,BufRead *eslintrc,*prettierrc setlocal ft=json
