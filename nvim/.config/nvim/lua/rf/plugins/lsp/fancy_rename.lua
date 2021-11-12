-- https://www.reddit.com/r/neovim/comments/ql4iuj/rename_hover_including_window_title_and/

local M = {}

M.setup = function()
  vim.lsp.handlers['textDocument/rename'] = function(err, result)
    if err then
      vim.notify(
        ("Error running lsp query 'rename': " .. err),
        vim.log.levels.ERROR
      )
    end
    if result and result.changes then
      local msg = ''
      for f, c in pairs(result.changes) do
        local new = c[1].newText
        msg = msg
          .. ('%d changes -> %s'):format(
            #c,
            f:gsub('file://', ''):gsub(vim.fn.getcwd(), '.')
          )
          .. '\n'
        msg = msg:sub(1, #msg - 1)
        vim.notify(
          msg,
          vim.log.levels.INFO,
          { title = ('Rename: %s -> %s'):format(vim.fn.expand '<cword>', new) }
        )
      end
    end
    vim.lsp.util.apply_workspace_edit(result)
  end

  vim.lsp.buf.rename = {
    float = function()
      local currName = vim.fn.expand '<cword>'
      local tshl =
        require('nvim-treesitter-playground.hl-info').get_treesitter_hl()
      if tshl and #tshl > 0 then
        local ind = tshl[#tshl]:match '^.*()%*%*.*%*%*'
        tshl = tshl[#tshl]:sub(ind + 2, -3)
      end

      local win = require('plenary.popup').create(currName, {
        title = 'New Name',
        style = 'minimal',
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        relative = 'cursor',
        borderhighlight = 'FloatBorder',
        titlehighlight = 'Title',
        highlight = tshl,
        focusable = true,
        width = 25,
        height = 1,
        line = 'cursor+2',
        col = 'cursor-1',
      })

      local map_opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(
        0,
        'i',
        '<Esc>',
        '<cmd>stopinsert | q!<CR>',
        map_opts
      )
      vim.api.nvim_buf_set_keymap(
        0,
        'n',
        '<Esc>',
        '<cmd>stopinsert | q!<CR>',
        map_opts
      )
      vim.api.nvim_buf_set_keymap(
        0,
        'i',
        '<CR>',
        "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('"
          .. currName
          .. ','
          .. win
          .. "')<CR>",
        map_opts
      )
      vim.api.nvim_buf_set_keymap(
        0,
        'n',
        '<CR>',
        "<cmd>stopinsert | lua vim.lsp.buf.rename.apply('"
          .. currName
          .. ','
          .. win
          .. "')<CR>",
        map_opts
      )
    end,
    apply = function(curr, win)
      local newName = vim.trim(vim.fn.getline '.')
      vim.api.nvim_win_close(win, true)
      if #newName > 0 and newName ~= curr then
        local params = vim.lsp.util.make_position_params()
        params.newName = newName
        vim.lsp.buf_request(0, 'textDocument/rename', params)
      end
    end,
  }
end

return M
