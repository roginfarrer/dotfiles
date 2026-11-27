vim.pack.add {
	'https://github.com/tjgao/quickbuf.nvim',
}
Util.keymap { '<leader>;', '<cmd>QuickBuf<CR>', desc = 'QuickBuf' }
Util.keymap { ';', '<cmd>QuickBufPinToggle<CR>', desc = 'Pin toggle' }
