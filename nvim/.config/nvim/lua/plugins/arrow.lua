return {
	{
		'otavioschwanck/arrow.nvim',
		enabled = false,
		commit = '6e0f726f55f99332dd726a53effd6813786b6d49',
		keys = { ';' },
		opts = {
			show_icons = true,
			leader_key = ';', -- Recommended to be a single key
			buffer_leader_key = 'm', -- Per Buffer Mappings
		},
	},

	{
		'tjgao/quickbuf.nvim',
		keys = {
			{ '<leader>;', '<cmd>QuickBuf<CR>', desc = 'QuickBuf' },
			{ ';', '<cmd>QuickBufPinToggle<CR>', desc = 'Pin toggle' },
		},
	},
}
