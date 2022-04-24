setlocal nobreakindent
" setlocal spell
let &showbreak = ''

function MarkdownLink()
  let foo = escape(":'<,'>s/\(\%V.*\%V\)/\[\1\]", '\\')
  execute ":'<,'>s/\V" . escape('\(\%V.*\%V\)', '/\') . '/' . escape('\[\1\]', '\[]')
  " exec('norm 0f]a()<C-o><Left>')
endfunction

" vnoremap <leader>[[ :call MarkdownLink()<CR>
