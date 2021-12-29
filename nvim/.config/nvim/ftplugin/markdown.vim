setlocal nobreakindent
let &showbreak = ''

let g:vim_markdown_fenced_languages = [ 'bash=sh', 'js=javascript', 'jsx=javascript' ]

" augroup zk
"   autocmd!
"   autocmd BufEnter */Obsidian/*.md inoremap <buffer> [[ <ESC>:lua require('telekasten').insert_link({i=true})<CR>
" augroup end

" inoremap <buffer> [[ <ESC>:lua require('telekasten').insert_link({i=true})<CR>
