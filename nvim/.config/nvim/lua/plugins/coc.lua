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

u.nmap({ 'silent' }, 'gd', '<Plug>(coc-definition)')
u.nmap({ 'silent' }, 'gt', '<Plug>(coc-type-definition)')
u.nmap({ 'silent' }, 'gi', '<Plug>(coc-implementation)')
u.nmap({ 'silent' }, 'gr', '<Plug>(coc-references)')
u.nmap({ 'silent' }, '<leader>lr', '<Plug>(coc-rename)')
u.nmap({ 'silent' }, '<leader>do', '<Plug>(coc-codeaction)')
u.xmap({ 'silent' }, '<leader>do', '<Plug>(coc-codeaction-selected)')

u.inoremap({ 'silent', 'expr' }, '<Tab>', 'v:lua.smart_tab()')
u.inoremap({ 'silent', 'expr' }, '<S-Tab>', function()
	return vim.fn.pumvisible() == 1 and t('<C-p>') or t('<C-h>')
end)
u.inoremap({ 'silent', 'expr' }, '<c-space>', vim.fn['coc#refresh'])

u.nmap({ 'silent' }, '[g', '<Plug>(coc-diagnostic-prev)')
u.nmap({ 'silent' }, ']g', '<Plug>(coc-diagnostic-next)')

u.nnoremap({ 'silent' }, 'K', [[:call CocAction('doHover')<CR>]])
u.nmap('<leader>es', [[:CocCommand snippets.editSnippets<CR>]])

u.nnoremap(
	{ 'silent', 'nowait', 'expr' },
	'<C-f>',
	'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-F>"'
)

u.nnoremap(
	{ 'silent', 'nowait', 'expr' },
	'<C-b>',
	'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-B>"'
)

u.inoremap(
	{ 'silent', 'nowait', 'expr' },
	'<C-f>',
	'coc#float#has_scroll() ? coc#float#scroll(1) : "<Right>"'
)

u.inoremap(
	{ 'silent', 'nowait', 'expr' },
	'<C-b>',
	'coc#float#has_scroll() ? coc#float#scroll(0) : "<Left>"'
)

vim.g.coc_filetype_map = {
	['markdown.mdx'] = 'mdx',
}
