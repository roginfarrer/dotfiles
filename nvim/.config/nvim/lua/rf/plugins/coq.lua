local u = require('rf.utils')

vim.g.coq_settings = {
  ['auto_start'] = 'shut-up',
  keymap = {
    recommended = false,
    bigger_preview = '',
    jump_to_mark = '',
  },
}

u.inoremap('<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true })
u.inoremap('<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true })
u.inoremap('<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true })
u.inoremap('<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true })

vim.cmd('autocmd VimEnter * :COQsnips compile')
