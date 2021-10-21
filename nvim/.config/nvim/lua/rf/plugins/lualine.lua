local function lsp_status()
  if #vim.lsp.buf_get_clients() then
    return require('lsp-status').status_progress()
  end
  return ''
end

-- https://vi.stackexchange.com/a/12294
local function getHighlightTerm(group, term)
  local output = vim.fn.execute('hi ' .. group)
  return vim.fn.matchstr(output, term .. '=\\zs\\S*')
end

local diffAddFg = getHighlightTerm('LspSagaRenameBorder', 'guifg')
local diffChangeFg = getHighlightTerm('LspDiagnosticsHint', 'guifg')
local diffDeleteFg = getHighlightTerm('LspDiagnosticsError', 'guifg')

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

local config = {
  options = {
    theme = vim.g.colors_name,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      {
        'diff',
        diff_color = {
          added = { fg = diffAddFg },
          removed = { fg = diffDeleteFg },
          modified = { fg = diffChangeFg },
        },
      },
    },
    lualine_c = { { 'filename', file_status = true } },
    lualine_x = {
      -- lsp_status,
      { 'diagnostics', sources = { 'nvim_lsp' } },
    },
    lualine_y = { 'filetype' },
    lualine_z = { lsp_client_names },
  },
}

require('lualine').setup(config)
