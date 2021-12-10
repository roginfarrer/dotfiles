vim.cmd[[packadd hop.nvim]]

vim.o.number = true
vim.o.mouse = 'a'

vim.g.mapleader = ' '

require'hop'.setup()
