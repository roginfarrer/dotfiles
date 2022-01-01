" This is the ONLY place where this runs correctly
" Doesn't work in fdetect/, plugin/ or in after/fdetect/
" I'm guessing a plugin sets the markdown filetype somewhere (Treesitter?)
" au BufNewFile,BufRead *.md if expand('<amatch>') =~ expand('$ZK_NOTEBOOK_DIR').'/*' | set filetype=markdown.zk | endif
