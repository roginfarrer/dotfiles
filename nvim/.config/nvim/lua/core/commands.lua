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
      reloaded_id = vim.notify('Reloaded ' .. mod, vim.log.levels.INFO, { title = 'nvim', replace = reloaded_id })
    end
  end,
})

autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- go to last loc when opening a buffer
autocmd('BufReadPost', {
  group = 'last_loc',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- wrap and check for spell in text filetypes
autocmd('FileType', {
  group = 'wrap_spell',
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd('BufReadPost', {
  group = 'rc_ft',
  pattern = '*rc',
  callback = function()
    if vim.bo.filetype == '' then
      vim.bo.filetype = 'json'
    end
  end,
})

autocmd('FileType', {
  group = 'astro_server',
  pattern = 'astro',
  callback = function(event)
    if _G.astro_server then
      return
    end

    local util = require 'lspconfig.util'
    local file = util.path.join(vim.fn.getcwd(), event.file)
    local gitAncestor = util.find_git_ancestor(file)

    local function seek(startpath)
      local rootPath = util.find_node_modules_ancestor(startpath)
      local maybeFile = util.path.join(rootPath, 'node_modules/typescript/lib/tsserverlibrary.js')
      if util.path.exists(maybeFile) then
        return maybeFile
      end

      if rootPath ~= gitAncestor then
        return seek(util.path.dirname(rootPath))
      end
    end

    local foundFile = seek(util.path.dirname(file))
    _G.astro_server = foundFile
    print(foundFile)
  end,
})

vim.api.nvim_create_user_command('Dupe', function()
  local filepath = vim.fn.expand '%'
  local buffer_content = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, false)
  local name = vim.fn.input('New name: ', filepath, 'file')
  vim.fn.execute(string.format('edit %s', name))

  local newBufNum = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(newBufNum, 0, -1, false, buffer_content)
  vim.fn.execute 'write'

  vim.fn.execute(string.format('echomsg "Created and editing %s"', name))
end, {})
