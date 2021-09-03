local work_github_url = _G.work_github_url or 'shim'

require('gitlinker').setup({
	opts = {
		mappings = nil,
		-- adds current line nr in the url for normal mode
		add_current_line_on_normal_mode = false,
	},
	callbacks = {
		[work_github_url] = require('gitlinker.hosts').get_github_type_url,
	},
})
