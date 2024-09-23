" Press Backspace to return from the last jump.
nnoremap <buffer> <BS> <C-T>
" Press s to find the next subject, or S to find the previous subject.
nnoremap <buffer> o /'\l\{2,\}'<CR>
nnoremap <buffer> O ?'\l\{2,\}'<CR>
" Press o to find the next option, or O to find the previous option.
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>
