let mapleader = " "

" Easier cursor movement in insert mode
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Copy to clipboard
nnoremap <C-c> "+y
" Paste from clipboard in insert mode
inoremap <C-v> <C-r>*

" yank to clipboard
nnoremap <Leader>y "+y
nnoremap <Leader>Y "+Y
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

" Put from clipboard
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P

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
nmap <CR> o<Esc>"_cc<Esc>
" nnoremap <leader>o o<Esc>"_cc<Esc>
" nnoremap <leader>O O<Esc>"_cc<Esc>
" Go to last buffer
nmap <BS> :e #<CR>

" If you like long lines with line wrapping enabled, this solves the problem
" that pressing down jumpes your cursor “over” the current line to the next
" line. It changes behaviour so that it jumps to the next row in the editor
" (much more natural)
" Display line movements unless preceded by a count whilst also recording jump points for movements larger than five lines
nnoremap <silent><expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <silent><expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

nnoremap 0 ^

" Move entire lines with Alt + jk
nnoremap <silent> <A-k> :m .-2<CR>==
nnoremap <silent> <A-j> :m .+1<CR>==
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

" Make folding easier
nnoremap <leader><leader> za

" Copy file path to clipboard
" nmap <leader>yf :let @*=expand("%")<cr>:echo "Copied file to clipboard"<cr>

" " To map <Esc> to exit terminal-mode: 
tnoremap <Leader><Esc> <C-\><C-n>
tnoremap <Leader>j <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-W>h
tnoremap <C-j> <C-\><C-n><C-W>j
tnoremap <C-k> <C-\><C-n><C-W>k
tnoremap <C-l> <C-\><C-n><C-W>l

" Preserve visual selection with indentation
vnoremap < <gv
vnoremap > >gv

" Open URL under cursor in browser
" Note that this only works on Macs
nmap <silent> gx <cmd>!open <cfile><cr>
