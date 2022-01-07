local function lsp_progress(_, is_active)
  if not is_active then
    return
  end
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ''
  end
  -- dump(messages)
  local status = {}
  for _, msg in pairs(messages) do
    local title = ''
    if msg.title then
      title = msg.title
    end
    -- if msg.message then
    --   title = title .. " " .. msg.message
    -- end
    table.insert(status, (msg.percentage or 0) .. '%% ' .. title)
  end
  local spinners = {
    '⠋',
    '⠙',
    '⠹',
    '⠸',
    '⠼',
    '⠴',
    '⠦',
    '⠧',
    '⠇',
    '⠏',
  }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, '  ') .. ' ' .. spinners[frame + 1]
end

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

local config = {
  options = {
    theme = 'auto',
    section_separators = { left = '', right = '' },
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
      lsp_progress,
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_y = { 'filetype' },
    lualine_z = { lsp_client_names },
  },
  extensions = { 'fugitive' },
}

require('lualine').setup(config)
