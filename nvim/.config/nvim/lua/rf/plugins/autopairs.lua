local npairs = require('nvim-autopairs')
local u = require('rf.utils')

if isPackageLoaded('nvim-cmp') then
  npairs.setup({
    check_ts = true,
    ts_config = {
      lua = { 'string' }, -- it will not add pair on that treesitter node
      javascript = { 'template_string' },
      java = false, -- don't check treesitter on java
    },
  })
end

if isPackageLoaded('coq_nvim') then
  npairs.setup({ map_bs = false })

  local function enter()
    if vim.fn.pumvisible() ~= 0 then
      if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
        return npairs.esc('<c-y>')
      else
        -- you can change <c-g><c-g> to <c-e> if you don't use other i_CTRL-X modes
        return npairs.esc('<c-g><c-g>') .. npairs.autopairs_cr()
      end
    else
      return npairs.autopairs_cr()
    end
  end
  u.inoremap('<cr>', enter, { expr = true })

  local function backspace()
    if
      vim.fn.pumvisible() ~= 0
      and vim.fn.complete_info({ 'mode' }).mode == 'eval'
    then
      return npairs.esc('<c-e>') .. npairs.autopairs_bs()
    else
      return npairs.autopairs_bs()
    end
  end
  u.inoremap('<bs>', backspace, { expr = true })
end

if isPackageLoaded('coc.nvim') then
  print('this loaded')
  npairs.setup({ map_bs = false })

  local function enter()
    if vim.fn.pumvisible() ~= 0 then
      if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
        return npairs.esc('<c-y>')
      else
        -- you can change <c-g><c-g> to <c-e> if you don't use other i_CTRL-X modes
        return npairs.esc('<c-g><c-g>') .. npairs.autopairs_cr()
      end
    else
      return npairs.autopairs_cr()
    end
  end
  u.inoremap('<cr>', enter, { expr = true })

  local function backspace()
    if
      vim.fn.pumvisible() ~= 0
      and vim.fn.complete_info({ 'mode' }).mode == 'eval'
    then
      return npairs.esc('<c-e>') .. npairs.autopairs_bs()
    else
      return npairs.autopairs_bs()
    end
  end
  u.inoremap('<bs>', backspace, { expr = true })
end
