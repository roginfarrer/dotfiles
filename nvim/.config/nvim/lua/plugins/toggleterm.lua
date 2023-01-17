local M = { 'akinsho/toggleterm.nvim', version = 'v2.*', keys = { [[<C-\>]] } }

function M.config()
  local Terminal = require('toggleterm.terminal').Terminal

  require('toggleterm').setup {
    shell = 'fish',
    open_mapping = [[<C-\>]],
    direction = 'float',
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
  }

  local lazygit = Terminal:new {
    cmd = 'lazygit',
    direction = 'float',
  }

  local function toggleLazyGit()
    if vim.fn.executable 'lazygit' == 1 then
      lazygit:toggle()
    else
      print 'Please install lazygit (brew install lazygit)'
    end
  end

  require('which-key').register {
    ['<leader>gt'] = { toggleLazyGit, 'lazygit' },
  }
end

return M
