return {
	{
		'stevearc/overseer.nvim',
		opts = {},
		cmd = { 'OverseerRun', 'OverseerToggle', 'OverseerShell' },
		keys = {
			{ '<leader>oo', '<cmd>OverseerToggle<cr>', desc = 'Toggle Overseer' },
			{ '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Run Overseer Task' },
		},
	},
}
