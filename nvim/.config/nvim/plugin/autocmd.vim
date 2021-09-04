" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="Substitute", timeout=250}

autocmd TermOpen * startinsert

autocmd TermOpen * setlocal listchars= nonumber 
