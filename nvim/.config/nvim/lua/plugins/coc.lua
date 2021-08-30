local u = require('utils')

-- The function is called `t` for `termcodes`.
-- You don't have to call it that, but I find the terseness convenient
local function t(str)
	-- Adjust boolean arguments as needed
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
function _G.smart_tab()
	return vim.fn.pumvisible() == 1 and t('<C-n>')
		or _G.check_back_space() and t('<Tab>')
		or vim.fn['coc#refresh']()
end
function _G.check_back_space()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s'))
		and true
end

vim.g.coc_node_path = '$HOME/.fnm/aliases/default/bin/node'

vim.g.coc_global_extensions = {
	'coc-tsserver',
	'coc-css',
	'coc-emmet',
	'coc-html',
	'coc-json',
	'coc-yaml',
	'coc-snippets',
	'coc-styled-components',
	'coc-tabnine',
	'coc-lua',
	'coc-vimlsp',
	'coc-fish',
}

u.nmap('gd', '<Plug>(coc-definition)')
u.nmap('gt', '<Plug>(coc-type-definition)')
u.nmap('gi', '<Plug>(coc-implementation)')
u.nmap('gr', '<Plug>(coc-references)')
u.nmap('<leader>lr', '<Plug>(coc-rename)')
u.nmap('<leader>do', '<Plug>(coc-codeaction)')
u.xmap('<leader>do', '<Plug>(coc-codeaction-selected)')

u.inoremap('<Tab>', 'v:lua.smart_tab()', { 'silent', 'expr' })
u.inoremap('<S-Tab>', function()
	return vim.fn.pumvisible() == 1 and t('<C-p>') or t('<C-h>')
end, {
	'expr',
})
u.inoremap('<c-space>', vim.fn['coc#refresh'], { 'silent', 'expr' })

u.nmap('[g', '<Plug>(coc-diagnostic-prev)', { 'silent' })
u.nmap(']g', '<Plug>(coc-diagnostic-next)')

u.nnoremap('K', [[:call CocAction('doHover')<CR>]])
u.nmap('<leader>es', [[:CocCommand snippets.editSnippets<CR>]])

u.nnoremap(
	'<C-f>',
	'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-F>"',
	{ 'silent', 'nowait', 'expr' },
)

u.nnoremap(
	'<C-b>',
	'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-B>"',
	{ 'silent', 'nowait', 'expr' },
)

u.inoremap(
	'<C-f>',
	'coc#float#has_scroll() ? coc#float#scroll(1) : "<Right>"',
	{ 'silent', 'nowait', 'expr' },
)

u.inoremap(
	'<C-b>',
	'coc#float#has_scroll() ? coc#float#scroll(0) : "<Left>"',
	{ 'silent', 'nowait', 'expr' },
)

vim.g.coc_filetype_map = {
	['markdown.mdx'] = 'mdx',
}
