local npairs = require('nvim-autopairs')
local u = require('utils')

if packer_plugins['nvim-cmp'] and packer_plugins['nvim-cmp'].loaded then
	npairs.setup({
		check_ts = true,
		ts_config = {
			lua = { 'string' }, -- it will not add pair on that treesitter node
			javascript = { 'template_string' },
			java = false, -- don't check treesitter on java
		},
	})
	-- you need setup cmp first put this after cmp.setup()
	require('nvim-autopairs.completion.cmp').setup({
		map_cr = true, --  map <CR> on insert mode
		map_complete = true, -- it will auto insert `(` after select function or method item
		auto_select = true, -- automatically select the first item
	})
end

if packer_plugins['coq_nvim'] and packer_plugins['coq_nvim'].loaded then
	npairs.setup({ map_bs = false })

	local function enter()
		if vim.fn.pumvisible() ~= 0 then
			if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
				return npairs.esc('<c-y>')
			else
				-- you can change <c-g><c-g> to <c-e> if you don't use other i_CTRL-X modes
				return npairs.esc('<c-g><c-g>') .. npairs.autopairs_cr()
			end
		else
			return npairs.autopairs_cr()
		end
	end
	u.inoremap('<cr>', enter, { expr = true })

	local function backspace()
		if
			vim.fn.pumvisible() ~= 0
			and vim.fn.complete_info({ 'mode' }).mode == 'eval'
		then
			return npairs.esc('<c-e>') .. npairs.autopairs_bs()
		else
			return npairs.autopairs_bs()
		end
	end
	u.inoremap('<bs>', backspace, { expr = true })
end
