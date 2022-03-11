local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- If your Neovim install doesn't include mpack, e.g. if installed via
-- Homebrew, then you need to also install mpack from luarocks.
-- There is an existing issue with luarocks on macOS where `luarocks install` is using a different version of lua.
-- @see: https://github.com/wbthomason/packer.nvim/issues/180
-- Make sure to add this on top of your plugins.lua to resolve this
vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')

packer.init { max_jobs = 16 }

return packer.startup(function(use)
  for _, plugin in ipairs(require 'user.plugins') do
    use(plugin)
  end

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
