let s:fontsize = 16
set linespace=2

function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  let s:value = 'MonoLisa Nerd Font:h' . s:fontsize 

  if exists(':Guifont') 
    " used by neovim-qt
    execute 'Guifont! ' . s:value
  else
    " https://vi.stackexchange.com/a/18774
    let &guifont=s:value
  endif
endfunction

call AdjustFontSize(0)

nmap <silent> <C-=> :call AdjustFontSize(1)<CR>
nmap <silent> <C--> :call AdjustFontSize(-1)<CR>
nmap <silent> <M-=> :call AdjustFontSize(1)<CR>
nmap <silent> <M--> :call AdjustFontSize(-1)<CR>

if exists(":GuiRenderLigatures")
  GuiRenderLigatures 1
endif
