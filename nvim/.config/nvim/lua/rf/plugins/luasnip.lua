local ls = require('luasnip')
-- local types = ls.types

-- ls.config.setup({
-- 	ext_opts = {
-- 		[types.choiceNode] = {
-- 			active = {
-- 				virt_text = { { '●', 'Identifier' } },
-- 			},
-- 		},
-- 		[types.insertNode] = {
-- 			active = {
-- 				virt_text = { { '●', 'Float' } },
-- 			},
-- 		},
-- 	},
-- })

local text = ls.text_node
local insert = ls.insert_node
local snip = ls.snippet

local jsAutoSnips = {
	snip('clog', {
		text('console.log('),
		insert(0),
		text(');'),
	}),
}

local jsSnips = {
	snip('clog', {
		text('console.log('),
		insert(0),
		text(');'),
	}),
	snip('cfn', {
		text('const '),
		insert(1, 'functionName'),
		text(' = ('),
		insert(2, 'args'),
		text({ ') => {', '\t' }),
		insert(0),
		text({ '', '}' }),
	}),
	snip('fn', {
		text('function '),
		insert(1),
		text('('),
		insert(2),
		text({ ') {', '\t' }),
		insert(0),
		text({ '', '}' }),
	}),
}

ls.snippets = {
	javascript = jsSnips,
	javascriptreact = jsSnips,
	typescriptreact = jsSnips,
	typescript = jsSnips,
}

ls.autosnippets = {
	javascript = jsAutoSnips,
	javascriptreact = jsAutoSnips,
	typescriptreact = jsAutoSnips,
	typescript = jsAutoSnips,
}
