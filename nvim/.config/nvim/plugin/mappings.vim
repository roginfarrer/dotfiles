" Easier cursor movement in insert mode
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Copy to clipboard
nnoremap <C-c> "+y
" Paste from clipboard in insert mode
inoremap <C-v> <C-r>*

nnoremap <Leader>y "+y
xnoremap <Leader>y "+y
nnoremap <Leader>p "+p
xnoremap <Leader>p "+p
nnoremap <Leader>P "+P
xnoremap <Leader>P "+P

" When changing, don't save to register
nnoremap c "_c
nnoremap C "_C
vnoremap c "_c
vnoremap C "_C

" Easier window movement
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" newline without insert
nnoremap <silent> <CR> o<Esc>"_cc<Esc>

" If you like long lines with line wrapping enabled, this solves the problem
" that pressing down jumpes your cursor “over” the current line to the next
" line. It changes behaviour so that it jumps to the next row in the editor
" (much more natural)
" Display line movements unless preceded by a count whilst also recording jump points for movements larger than five lines
" nnoremap <silent><expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
" nnoremap <silent><expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

nnoremap 0 ^

" Move entire lines with Alt + jk
nnoremap <silent> <A-k> :m .-2<CR>==
nnoremap <silent> <A-j> :m .+1<CR>==
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

" Make folding easier
nnoremap <Tab> za

" Copy file path to clipboard
nnoremap <leader>yf :let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>

" To map <Esc> to exit terminal-mode: 
tnoremap <leader><Esc> <C-\><C-n>
tnoremap <leader>j <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-W>
tnoremap <C-j> <C-\><C-n><C-W>
tnoremap <C-k> <C-\><C-n><C-W>
tnoremap <C-l> <C-\><C-n><C-W>

" Center the cursor on navigation operations
nnoremap {  {zz
nnoremap }  }zz
nnoremap n  nzz
nnoremap N  Nzz
nnoremap ]c ]czz
nnoremap [c [czz
nnoremap [j <C-o>zz
nnoremap ]j <C-i>zz
nnoremap ]s ]szz
nnoremap [s [szz
