syntax match todoCheckbox '\v(\s+)?(-|\*)\s\[\s\]'hs=e-4 conceal cchar=
syntax match todoCheckbox '\v(\s+)?(-|\*)\s\[X\]'hs=e-4 conceal cchar=
syntax match todoCheckbox '\v(\s+)?(-|\*)\s\[-\]'hs=e-4 conceal cchar=☒
syntax match todoCheckbox '\v(\s+)?(-|\*)\s\[\.\]'hs=e-4 conceal cchar=⊡
syntax match todoCheckbox '\v(\s+)?(-|\*)\s\[o\]'hs=e-4 conceal cchar=⬕

hi def link todoCheckbox Conceal

highlight Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE

setlocal cole=1
