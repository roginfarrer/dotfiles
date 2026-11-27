---@class KeymapUtil
---@field [1] string lhs
---@field [2] string|fun():string? rhs
---@field mode? string|string[]
---@field desc? string
---@field noremap? boolean
---@field remap? boolean
---@field expr? boolean
---@field nowait? boolean
---@field silent? boolean

_G.Util = {
	---@param event vim.api.keyset.events|vim.api.keyset.events[] Event(s) that will trigger the handler (`callback` or `command`).
	---@param opts vim.api.keyset.create_autocmd
	autocmd = function(event, opts)
		if opts.group then
			vim.api.nvim_create_autocmd(
				event,
				vim.tbl_extend(
					'force',
					opts,
					{ group = vim.api.nvim_create_augroup('rogin_' .. opts.group, { clear = true }) }
				)
			)
		else
			vim.api.nvim_create_autocmd(event, opts)
		end
	end,

	---@param str string
	termcodes = function(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end,

	---@param v KeymapUtil
	keymap = function(v)
		local lhs = v[1]
		local rhs = v[2]

		vim.keymap.set(v.mode or 'n', lhs, rhs, {
			desc = v.desc,
			noremap = v.noremap == nil and true or v.noremap,
			remap = v.remap,
			expr = v.expr,
			nowait = v.nowait,
			silent = v.silent == nil and true or v.silent,
		})
	end,

	---@param event vim.api.keyset.events|vim.api.keyset.events[] Event(s) that will trigger the handler (`callback` or `command`).
	---@param callback fun()
	on_event = function(event, callback)
		vim.api.nvim_create_autocmd(event, {
			once = true,
			callback = function()
				callback()
			end,
		})
	end,

	---@param package string
	---@param callback fun()
	on_plugin_update = function(package, callback)
		vim.api.nvim_create_autocmd('PackChanged', {
			callback = function(ev)
				local name, kind = ev.data.spec.name, ev.data.kind
				if name == package and (kind == 'update' or kind == 'install') then
					if not ev.data.active then
						vim.cmd.packadd(package)
					end
					callback()
				end
			end,
		})
	end,

	gh = function(x, tbl)
		return vim.tbl_deep_extend('keep', { src = 'https://github.com/' .. x }, tbl or {})
	end,
	cb = function(x, tbl)
		return vim.tbl_deep_extend('keep', { src = 'https://codeberg.org/' .. x }, tbl or {})
	end,

	icons = {

		lspkind = {
			Text = '',
			Method = '',
			Function = '',
			Constructor = '',
			Field = '',
			Variable = '',
			Class = 'ﴯ',
			Interface = '',
			Module = '',
			Property = 'ﰠ',
			Unit = '',
			Value = '',
			Enum = '',
			Keyword = '',
			Snippet = '',
			Color = '',
			File = '',
			Reference = '',
			Folder = '',
			EnumMember = '',
			Constant = '',
			Struct = '',
			Event = '',
			Operator = '',
			TypeParameter = '',
		},

		codicons = {
			Text = '  ',
			Method = '  ',
			Function = '  ',
			Constructor = '  ',
			Field = '  ',
			Variable = '  ',
			Class = '  ',
			Interface = '  ',
			Module = '  ',
			Property = '  ',
			Unit = '  ',
			Value = '  ',
			Enum = '  ',
			Keyword = '  ',
			Snippet = '  ',
			Color = '  ',
			File = '  ',
			Reference = '  ',
			Folder = '  ',
			EnumMember = '  ',
			Constant = '  ',
			Struct = '  ',
			Event = '  ',
			Operator = '  ',
			TypeParameter = '  ',
		},

		lazy = {
			dap = {
				Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
				Breakpoint = ' ',
				BreakpointCondition = ' ',
				BreakpointRejected = { ' ', 'DiagnosticError' },
				LogPoint = '.>',
			},
			test = {
				failed = '',
				passed = '',
				running = '',
				skipped = '',
				unknown = '?',
			},
			diagnostics = {
				Error = ' ',
				Warn = ' ',
				Hint = ' ',
				Info = ' ',
			},
			git = {
				added = ' ',
				modified = ' ',
				removed = ' ',
			},
			kinds = {
				Array = ' ',
				Boolean = ' ',
				Class = ' ',
				Color = ' ',
				Constant = ' ',
				Constructor = ' ',
				Copilot = ' ',
				Enum = ' ',
				EnumMember = ' ',
				Event = ' ',
				Field = ' ',
				File = ' ',
				Folder = ' ',
				Function = ' ',
				Interface = ' ',
				Key = ' ',
				Keyword = ' ',
				Method = ' ',
				Module = ' ',
				Namespace = ' ',
				Null = ' ',
				Number = ' ',
				Object = ' ',
				Operator = ' ',
				Package = ' ',
				Property = ' ',
				Reference = ' ',
				Snippet = ' ',
				String = ' ',
				Struct = ' ',
				Text = ' ',
				TypeParameter = ' ',
				Unit = ' ',
				Value = ' ',
				Variable = ' ',
			},
		},
	},
}
