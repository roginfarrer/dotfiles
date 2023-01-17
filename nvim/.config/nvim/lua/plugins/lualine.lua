local M = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  -- lazy = true,
}

vim.cmd 'au User LspProgressUpdate let &ro = &ro'

local function lsp_client_names()
  local msg = 'no active lsp'

  if #vim.lsp.buf_get_clients() then
    local clients = {}
    for _, client in pairs(vim.lsp.buf_get_clients()) do
      table.insert(clients, client.name)
    end

    if next(clients) == nil then
      return msg
    end

    return ' LSP: ' .. table.concat(clients, ',')
  end

  return msg
end

local separators = {
  angled = { right = '', left = '' },
  round = { left = '', right = '' },
}

local config = {
  options = {
    theme = 'auto',
    section_separators = separators.angled,
    component_separators = { left = '', right = '' },
    icons_enabled = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'diff',
    },
    lualine_c = { { 'filename', file_status = true } },
    lualine_x = {
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_y = { 'filetype' },
    lualine_z = { lsp_client_names },
  },
}

-- M.loaded = false

-- Used in an autocmd so that lualine doesn't appear
-- on the Alpha dashboard
M.config = function()
  require('lualine').setup(config)
  -- M.loaded = true
end

return M
