local present, installer = pcall(require, 'nvim-lsp-installer')

if not present then
  return
end

function _G.update_installed_lsps()
  local names = {}
  for _, lsp in pairs(installer.get_installed_servers()) do
    table.insert(names, lsp.name)
  end
  names = vim.fn.join(names, ' ')
  vim.fn.execute('LspInstall ' .. names)
end

vim.cmd [[command! LspUpdateAll call v:lua.update_installed_lsps()]]
