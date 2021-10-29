local present, packer = pcall(require, 'packer')

if not present then
  local packer_path = vim.fn.stdpath 'data'
    .. '/site/pack/packer/opt/packer.nvim'

  print 'Cloning packer..'
  -- remove the dir before cloning
  vim.fn.delete(packer_path, 'rf')
  vim.fn.system {
    'git',
    'clone',
    'https://github.com/wbthomason/packer.nvim',
    '--depth',
    '20',
    packer_path,
  }

  present, packer = pcall(require, 'packer')

  if present then
    print 'Packer cloned successfully.'
  else
    error("Couldn't clone packer !\nPacker path: " .. packer_path)
  end
end

vim.cmd [[autocmd BufWritePost nvim/* source <afile> | PackerCompile]]

-- If your Neovim install doesn't include mpack, e.g. if installed via
-- Homebrew, then you need to also install mpack from luarocks.
-- There is an existing issue with luarocks on macOS where `luarocks install` is using a different version of lua.
-- @see: https://github.com/wbthomason/packer.nvim/issues/180
-- Make sure to add this on top of your plugins.lua to resolve this
vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')

return packer.startup(function(use)
  for _, plugin in ipairs(require 'rf.pluginList') do
    use(plugin)
  end
end)
