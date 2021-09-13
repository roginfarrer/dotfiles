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
nmap <silent> <D-=> :call AdjustFontSize(1)<CR>
nmap <silent> <D--> :call AdjustFontSize(-1)<CR>

if exists(":GuiRenderLigatures")
  GuiRenderLigatures 1
endif

" Mask cmd-v/cmd-c work how it should
nmap <silent> <D-v> "+p 
imap <silent> <D-v> <C-o>"+p
nmap <silent> <D-c> "+y
xmap <silent> <D-c> "+y
