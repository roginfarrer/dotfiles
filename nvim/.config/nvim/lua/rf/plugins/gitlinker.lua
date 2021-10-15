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

function _G.gitCopyToClipboard(range)
  local mode = range > 0 and 'v' or 'n'
  require('gitlinker').get_buf_range_url(
    mode,
    { action_callback = require('gitlinker.actions').copy_to_clipboard }
  )
end
function _G.gitOpenInBrowser(range)
  local mode = range > 0 and 'v' or 'n'
  require('gitlinker').get_buf_range_url(
    mode,
    { action_callback = require('gitlinker.actions').open_in_browser }
  )
end

vim.cmd([[
  command! -nargs=0 -range GitCopyToClipboard call v:lua.gitCopyToClipboard(<range>)
]])
vim.cmd([[
  command! -nargs=0 -range GitOpenInBrowser call v:lua.gitOpenInBrowser(<range>)
]])
