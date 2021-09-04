vim.g['test#javascript#runner'] = 'jest'
-- vim.g['test#strategy'] = 'neovim'
-- vim.g['test#neovim#term_position'] = 'vert'
-- vim.cmd([[
-- 	let test#strategy = 'neoterm'
--   augroup test
--   autocmd!
--   autocmd BufWrite * if test#exists() |
--     \   TestFile |
--     \ endif
--   augroup END
-- ]])

vim.api.nvim_exec(
	[[
  function! ToggleTermStrategy(cmd) abort
    execute "lua require('toggleterm').exec('" . a:cmd . "', 1)"
  endfunction

  let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
]],
	false
)

vim.g['test#strategy'] = 'toggleterm'
