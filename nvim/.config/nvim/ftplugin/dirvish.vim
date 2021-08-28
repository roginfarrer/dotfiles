" setlocal cmdheight=2
let dirvish_mode = ':sort ,^.*/,' 
nnoremap <silent><buffer> <C-p> :GFiles<CR>
nmap <silent><buffer> q <Plug>(dirvish_quit)

let g:dirvish_dovish_map_keys = 0

" unmap dirvish defaults
unmap <buffer> p

nmap <silent><buffer> i <Plug>(dovish_create_file)
nmap <silent><buffer> I <Plug>(dovish_create_directory)
nmap <silent><buffer> dd <Plug>(dovish_delete)
nmap <silent><buffer> r <Plug>(dovish_rename)
nmap <silent><buffer> yy <Plug>(dovish_yank)
xmap <silent><buffer> y <Plug>(dovish_yank)
nmap <silent><buffer> p <Plug>(dovish_copy)
nmap <silent><buffer> P <Plug>(dovish_move)
