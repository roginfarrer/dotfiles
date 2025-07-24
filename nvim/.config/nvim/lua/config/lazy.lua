local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
	defaults = {
		version = false,
		lazy = true,
	},
	spec = {
		-- { dir = '~/projects/LazyVim', import = 'lazyvim.plugins' },
		-- { 'LazyVim/LazyVim' },
		{ import = 'plugins' },
	},
	dev = {
		path = '~/projects',
		fallback = true,
	},
	install = {
		colorscheme = { 'rose-pine', 'catppuccin' },
	},
	-- checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = {
				'2html_plugin',
				'getscript',
				'getscriptPlugin',
				'gzip',
				'logipat',
				'netrw',
				'netrwPlugin',
				'netrwSettings',
				'netrwFileHandlers',
				'matchit',
				'tar',
				'tarPlugin',
				'rrhelper',
				'spellfile_plugin',
				'vimball',
				'vimballPlugin',
				'zip',
				'zipPlugin',
				-- "python3_provider",
				-- "python_provider",
				-- "node_provider",
				'ruby_provider',
				'perl_provider',
				'tutor',
				'rplugin',
				'syntax',
				'synmenu',
				'optwin',
				'compiler',
				'bugreport',
				-- 'ftplugin',
			},
		},
	},
}
