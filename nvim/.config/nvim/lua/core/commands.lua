-- Disable statusline in dashboard
-- autocmd('FileType', {
--   pattern = 'alpha',
--   callback = function()
--     vim.opt.laststatus = 0
--   end,
-- })
-- autocmd('BufUnload', {
--   buffer = 0,
--   callback = function()
--     vim.opt.laststatus = 3
--   end,
-- })

local reloaded_id = nil
autocmd('BufWritePost', {
  pattern = '*.lua',
  callback = function(event)
    ---@type string
    local file = event.match
    local mod = file:match '/lua/(.*)%.lua'
    if mod then
      mod = mod:gsub('/', '.')
    end
    if mod then
      package.loaded[mod] = nil
      reloaded_id = vim.notify(
        'Reloaded ' .. mod,
        vim.log.levels.INFO,
        { title = 'nvim', replace = reloaded_id }
      )
    end
  end,
})

autocmd('InsertEnter', {
  pattern = '*',
  callback = function()
    vim.o.cul = true
  end,
})
autocmd('InsertLeave', {
  pattern = '*',
  callback = function()
    vim.o.cul = false
  end,
})

autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {--[[  higroup = 'Substitute', timeout = 250  ]]
    }
  end,
})

autocmd('VimResized', {
  pattern = '*',
  callback = function()
    vim.cmd [[:wincmd =]]
  end,
})

autocmd('BufReadPost', {
  pattern = '*rc',
  callback = function()
    if vim.bo.filetype == '' then
      vim.bo.filetype = 'json'
    end
  end,
})

-- go to last loc when opening a buffer
autocmd('BufReadPre', {
  pattern = '*',
  callback = function()
    autocmd('FileType', {
      pattern = '<buffer>',
      once = true,
      callback = function()
        vim.cmd [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
      end,
    })
  end,
})

vim.api.nvim_create_user_command('Dupe', function()
  local filepath = vim.fn.expand '%'
  local buffer_content =
    vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, false)
  local name = vim.fn.input('New name: ', filepath, 'file')
  vim.fn.execute(string.format('edit %s', name))

  local newBufNum = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(newBufNum, 0, -1, false, buffer_content)
  vim.fn.execute 'write'

  vim.fn.execute(string.format('echomsg "Created and editing %s"', name))
end, {})
