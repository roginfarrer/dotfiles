local autocmd = require('util').autocmd

-- Check if we need to reload the file when it changed
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = 'checktime',
  command = 'checktime',
})

-- resize splits if window got resized
autocmd({ 'VimResized' }, {
  group = 'resize_splits',
  callback = function()
    vim.cmd 'tabdo wincmd ='
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

-- close some filetypes with <q>
autocmd('FileType', {
  group = 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
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

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ 'BufWritePre' }, {
  group = 'auto_create_dir',
  callback = function(event)
    if event.match:match '^%w%w+://' then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

autocmd('TextYankPost', {
  group = 'highlight_yank',
  callback = function()
    vim.highlight.on_yank()
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
  group = 'node_gf',
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  callback = function()
    _G.includeexpr = function(fname)
      local basePath = vim.fn.finddir('node_modules', vim.fn.expand '%:p:h' .. ';' .. vim.fn.getcwd()) .. '/' .. fname
      local indexFileJs = basePath .. '/index.js'
      local indexFileTs = basePath .. '/index.ts'
      local packageFile = basePath .. '/package.json'

      if vim.fn.filereadable(packageFile) then
        local package = vim.fn.json_decode(vim.fn.join(vim.fn.readfile(packageFile)))

        if vim.fn.has_key(package, 'module') then
          return basePath .. '/' .. package.module
        end

        if vim.fn.has_key(package, 'main') then
          return basePath .. '/' .. package.main
        end
      end

      if vim.fn.filereadable(indexFileTs) then
        return indexFileTs
      end

      if vim.fn.filereadable(indexFileJs) then
        return indexFileJs
      end

      return basePath
    end

    vim.cmd [[setlocal isfname+=@-@]]
    vim.bo.suffixesadd = vim.bo.suffixesadd .. '.js,.jsx,.ts,.tsx'
    vim.bo.includeexpr = 'v:lua._G.includeexpr(v:fname)'
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

vim.api.nvim_create_user_command('CopyPath', function()
  local options = {
    vim.fn.expand '%',
    vim.fn.expand '%:.',
    vim.fn.expand '%:h',
    vim.fn.expand '%:t',
  }

  vim.ui.select(options, {
    prompt = 'Which format?',
  }, function(choice)
    if choice then
      vim.fn.execute('let @* = "' .. choice .. '"')
      vim.notify('Put in your clipboard: ' .. choice)
    end
  end)
end, {})

if require('util').has 'conform' then
  -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#format-command
  vim.api.nvim_create_user_command('Format', function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = { args.line1, 0 },
        ['end'] = { args.line2, end_line:len() },
      }
    end
    require('conform').format { async = true, lsp_fallback = true, range = range }
  end, { range = true })
end

autocmd('BufWritePost', {
  pattern = 'kitty.conf',
  callback = function()
    if vim.fn.executable 'kitty' then
      vim.cmd [[!kill -SIGUSR1 $(pgrep -a kitty)]]
    end
  end,
})

autocmd('BufWritePost', {
  pattern = 'aerospace.toml',
  callback = function()
    if vim.fn.executable 'aerospace' then
      vim.system { 'aerospace', 'reload-config' }
    end
  end,
})
