local function formatter(name)
  return require('efmls-configs.formatters.' .. name)
end
local function linter(name)
  return require('efmls-configs.linters.' .. name)
end

local languages = {
  javascript = { formatter 'prettier_d' },
  javascriptreact = { formatter 'prettier_d' },
  typescript = { formatter 'prettier_d' },
  typescriptreact = { formatter 'prettier_d' },
  css = { formatter 'prettier_d', linter 'stylelint' },
  html = { formatter 'prettier_d' },
  markdown = { formatter 'prettier_d' },
  mdx = { formatter 'prettier_d' },
  astro = { formatter 'prettier_d' },
  scss = { formatter 'prettier_d', linter 'stylelint' },
  yaml = { formatter 'prettier_d' },
  json = { formatter 'prettier_d' },
  lua = {
    linter 'luacheck',
    formatter 'stylua',
  },
  -- zsh = { formatter 'zsh' },
  vim = { linter 'vint' },
  bash = { linter 'shellcheck' },
  sh = { linter 'shellcheck' },
  fish = { linter 'fish' },
}

local filetypes = {}
for filetype in ipairs(languages) do
  table.insert(filetypes, filetype)
end

return {
  filetypes = filetypes,
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { '.git/', 'package.json' },
    languages = languages,
  },
}
