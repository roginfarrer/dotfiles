local Terminal = require('toggleterm.terminal').Terminal

require('toggleterm').setup {
  shell = 'fish',
  open_mapping = [[<C-t>]],
  direction = 'vertical',
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
  hidden = true,
  direction = 'window',
  shell = 'bash',
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
