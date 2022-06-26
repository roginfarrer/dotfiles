local M = {}

M.bootstrap = function()
  local fn = vim.fn
  local install_path = fn.stdpath 'data'
    .. '/site/pack/packer/start/packer.nvim'

  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1e222a' })

  if fn.empty(fn.glob(install_path)) > 0 then
    print 'Cloning packer ..'
    fn.system {
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    }

    -- install plugins + compile their configs
    vim.cmd 'packadd packer.nvim'
    require 'plugins'
    vim.cmd 'PackerSync'
  end
end

-- If your Neovim install doesn't include mpack, e.g. if installed via
-- Homebrew, then you need to also install mpack from luarocks.
-- There is an existing issue with luarocks on macOS where `luarocks install` is using a different version of lua.
-- @see: https://github.com/wbthomason/packer.nvim/issues/180
-- Make sure to add this on top of your plugins.lua to resolve this
vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '10.15')

M.options = {
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  max_jobs = 16,
  display = {
    working_sym = 'ﲊ',
    error_sym = '✗ ',
    done_sym = ' ',
    removed_sym = ' ',
    moved_sym = '',
    open_fn = function()
      return require('packer.util').float { border = 'single' }
    end,
  },
}

M.run = function(plugins)
  local present, packer = pcall(require, 'packer')

  if not present then
    return
  end

  packer.init(M.options)

  local final_table = {}

  for key, _ in pairs(plugins) do
    plugins[key][1] = key
    final_table[#final_table + 1] = plugins[key]
  end

  -- print(vim.inspect(final_table))

  packer.startup(function(use)
    for _, v in pairs(final_table) do
      use(v)
    end
  end)
end

return M
