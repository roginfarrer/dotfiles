local M = {}

-- -- Function to capitalize the first letters of words
-- local function capitalizeWords(str)
--   return str:gsub("(%a)([%w_']*)", function(first, rest)
--     return first:upper() .. rest:lower()
--   end)
-- end

local function getDirectoryPath()
	if vim.bo.filetype == 'oil' then
		return require('oil').get_current_dir()
	end
	return vim.fn.expand '%:p:h'
end

-- local grepInCurrentDirectory = function()
--   local p = getDirectoryPath()
--   return M.fzf('live_grep', {
--     cwd = p,
--     prompt_title = p,
--   })
-- end

M.open = function(command, opts)
	return function()
		opts = opts or {}
		-- if opts.cmd == nil and command == 'git_files' and opts.show_untracked then
		-- 	opts.cmd = 'git ls-files --exclude-standard --cached --others'
		-- end
		if opts.cwd == 'root_from_file' then
			opts.cwd = getDirectoryPath() or opts.cwd
		end
		return require('fzf-lua')[command](opts)
	end
end

-- function M.fzf(builtin, opts)
--   local params = { builtin = builtin, opts = opts }
--   return function()
--     builtin = params.builtin
--     opts = params.opts or {}
--     if opts.cwd == 'root_from_file' then
--       opts = vim.tbl_deep_extend('force', { cwd = require('lazyvim.util').root() }, opts)
--     end
--     if builtin == 'files' then
--       if vim.uv.fs_stat((opts.cwd or vim.uv.cwd()) .. '/.git') then
--         builtin = 'git_files'
--       end
--     end
--     opts.prompt = '󰍉 '
--     local title = string.gsub(builtin, '_', ' ')
--     opts.winopts = { title = ' ' .. capitalizeWords(title) .. ' ', title_pos = 'center' }
--     require('fzf-lua')[builtin](opts)
--   end
-- end

return {
	'ibhagwan/fzf-lua',
	enabled = false,
	dependencies = {
		{ 'roginfarrer/fzf-lua-lazy.nvim' },
	},
	cmd = 'FzfLua',
	opts = function()
		local config = require 'fzf-lua.config'
		local actions = require 'fzf-lua.actions'

		if require('util').has 'trouble.nvim' then
			config.defaults.actions.files['ctrl-t'] = require('trouble.sources.fzf').actions.open
		end

		-- Toggle root dir / cwd
		-- config.defaults.actions.files['ctrl-r'] = function(_, ctx)
		-- 	local o = vim.deepcopy(ctx.__call_opts)
		-- 	o.root = o.root == false
		-- 	o.cwd = nil
		-- 	o.buf = ctx.__CTX.bufnr
		-- 	local cmd = ctx.__INFO.cmd or 'files'
		-- 	M.open(cmd, o)
		-- end
		-- config.defaults.actions.files['alt-c'] = config.defaults.actions.files['ctrl-r']
		-- config.set_action_helpstr(config.defaults.actions.files['ctrl-r'], 'toggle-root-dir')

		return {
			{ 'telescope', 'hide' },
			-- fzf_colors = true,
			-- grep = {
			-- 	rg_opts = "--hidden --column --line-number --no-heading --trim --color=always --smart-case -g '!{.git,node_modules}/*'",
			-- },
			-- git = {
			-- 	files = {
			-- 		cmd = 'git ls-files --exclude-standard --others --cached',
			-- 	},
			-- },
			keymap = {
				builtin = {
					['<C-/>'] = 'toggle-help',
					['<C-a>'] = 'toggle-fullscreen',
					['<C-i>'] = 'toggle-preview',
				},
			},
			fzf_opts = {
				-- ['--no-scrollbar'] = true,
				['--layout'] = 'reverse',
				['--info'] = 'inline-right',
			},
			-- lsp = {
			-- 	code_actions = {
			-- 		previewer = 'codeaction_native',
			-- 		preview_pager = 'delta --side-by-side --width=$FZF_PREVIEW_COLUMNS',
			-- 	},
			-- },
		}
	end,
	keys = function()
		local hasTrouble, troubleActions = pcall(require, 'trouble.sources.fzf')
		if hasTrouble then
			local config = require 'fzf-lua.config'
			config.defaults.actions.files['ctrl-t'] = troubleActions.actions.open
		end
		return {
			{ '<leader>;', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<CR>', desc = 'Switch Buffer' },
			{ '<leader>/', M.open 'live_grep', desc = 'Grep' },
			{ '<leader>ff', M.open 'files', desc = 'Find Files (cwd)' },
			{
				'<leader>fF',
				M.open('files', { cwd = 'root_from_file' }),
				desc = 'Find Files (from buffer)',
			},
			{ '<leader>fG', M.open('live_grep', { cwd = 'root_from_file' }), desc = 'Grep (cwd)' },
			{
				'<leader>fd',
				M.open('files', { cwd = '~/dotfiles', hidden = true }),
				desc = 'Dotfiles',
			},
			{ '<leader>fD', M.open('live_grep', { cwd = '~/dotfiles' }), desc = 'Grep Dotfiles' },
			{ '<leader>fh', M.open 'oldfiles', desc = 'Recent' },
			{ '<leader>fH', M.open('oldfiles', { cwd = vim.uv.cwd() }), desc = 'Recent (cwd)' },
			{
				'<leader>fc',
				M.open 'grep_cword',
				desc = 'Grep word under cursor',
			},
			{
				'<leader>fC',
				M.open 'grep_cWORD',
				desc = 'Grep WORD under cursor',
			},
			{ '<leader>st', M.open 'builtin', desc = 'fzf builtins' },
			{ '<leader>sC', M.open 'commands', desc = 'commands' },
			{ '<leader>sh', M.open 'help_tags', desc = 'help pages' },
			{ '<leader>sm', M.open 'man_pages', desc = 'man pages' },
			{ '<leader>sk', M.open 'keymaps', desc = 'key maps' },
			{
				'<leader>ss',
				M.open 'highlights',
				desc = 'search highlight groups',
			},
			{ '<leader>sf', M.open 'filetypes', desc = 'file types' },
			{ '<leader>so', M.open 'vim_options', desc = 'options' },
			{ '<leader>sa', M.open 'autocommands', desc = 'auto commands' },
			{ '<leader>sc', M.open 'colorschemes', desc = 'colorschemes' },
			{ '<leader>gb', M.open 'git_branches', desc = 'checkout branch' },
			{
				'<leader>gC',
				M.open 'git_bcommits',
				desc = 'checkout commit (for current file)',
			},
			{ '<leader>r', M.open 'resume', desc = 'Fzf resume' },
			{
				'<leader>fl',
				function()
					require('fzf-lua-lazy').search {
						prompt = '󰍉 ',
						winopts = { title = ' Lazy ', title_pos = 'center' },
					}
				end,
				desc = 'lazy plugins',
			},
			{
				'<c-x><c-f>',
				function()
					require('fzf-lua').complete_file {
						cmd = 'fd -t file',
						winopts = { preview = { hidden = 'nohidden' } },
					}
				end,
				desc = 'Fuzzy complete path',
				mode = { 'i' },
			},
			{ 'gd', M.open 'lsp_definitions', desc = 'Definitions' },
			{ 'gD', M.open 'lsp_declarations', desc = 'Declarations' },
			{ 'grr', M.open 'lsp_references', nowait = true, desc = 'References' },
			{ 'gri', M.open 'lsp_implementations', desc = 'Implementations' },
			{ 'grt', M.open 'lsp_typedefs', desc = 'Type Definitions' },
			{ 'gO', M.open 'lsp_document_symbols', desc = 'LSP Document Symbols' },
			{ 'gra', M.open 'lsp_code_actions', desc = 'Code Actions' },
			{ 'gao', M.open 'lsp_outgoing_calls', desc = 'C[a]lls Outgoing' },
			{ 'gai', M.open 'lsp_incoming_calls', desc = 'C[a]lls Incoming' },
			{ '<leader>su', M.open 'undotree', desc = 'Undotree' },
		}
	end,
	config = function(_, opts)
		require('fzf-lua').setup(opts)
		-- Automatically size window for vim.ui.select
		-- https://github.com/ibhagwan/fzf-lua/wiki#automatic-sizing-of-heightwidth-of-vimuiselect
		require('fzf-lua').register_ui_select(function(_, items)
			local min_h, max_h = 0.15, 0.70
			local h = (#items + 4) / vim.o.lines
			if h < min_h then
				h = min_h
			elseif h > max_h then
				h = max_h
			end
			return { winopts = { height = h, width = 0.60, row = 0.40 } }
		end)
	end,
}
