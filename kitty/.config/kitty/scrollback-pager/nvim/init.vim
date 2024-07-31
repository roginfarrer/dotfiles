set number
set mouse=a
set termguicolors
set hlsearch

let g:mapleader = ' '

nnoremap <Leader>y "+y
nnoremap <Leader>Y "+Y
vnoremap <Leader>y "+y
vnoremap <Leader>Y "+Y

" If you like long lines with line wrapping enabled, this solves the problem
" that pressing down jumpes your cursor “over” the current line to the next
" line. It changes behaviour so that it jumps to the next row in the editor
" (much more natural)
" Display line movements unless preceded by a count whilst also recording jump points for movements larger than five lines
nnoremap <silent><expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <silent><expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="Substitute", timeout=250}

packadd lightspeed.nvim
packadd catppuccin
packadd neoscroll.nvim

lua << EOF
  local present, catppuccin = pcall(require, 'catppuccin')
  if present then
    catppuccin.setup{
      integrations = {
        lightspeed = true
      }
    }
  end
EOF

colorscheme catppuccin
