-- ignore default config and plugins
vim.opt.runtimepath:remove(vim.fn.expand '~/.config/nvim')
vim.opt.packpath:remove(vim.fn.expand '~/.local/share/nvim/site')
vim.opt.termguicolors = true

-- append test directory
local test_dir = '/tmp/nvim-config'
vim.opt.runtimepath:append(vim.fn.expand(test_dir))
vim.opt.packpath:append(vim.fn.expand(test_dir))

-- install packer
local install_path = test_dir .. '/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd 'packadd packer.nvim'
  install_plugins = true
end

local packer = require 'packer'

packer.init {
  package_root = test_dir .. '/pack',
  compile_path = test_dir .. '/plugin/packer_compiled.lua',
}

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-neotest/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'haydenmeade/neotest-jest',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-jest' {
            cwd = function(path)
              local cwd = require('neotest-jest.util').find_package_json_ancestor(path)
              return cwd
            end,
          },
        },
      }
    end,
  }

  if install_plugins then
    packer.sync()
  end
end)

vim.cmd [[
command! NeotestSummary lua require("neotest").summary.toggle()
command! NeotestFile lua require("neotest").run.run(vim.fn.expand("%"))
command! Neotest lua require("neotest").run.run(vim.fn.getcwd())
command! NeotestNearest lua require("neotest").run.run()
command! NeotestDebug lua require("neotest").run.run({ strategy = "dap" })
command! NeotestAttach lua require("neotest").run.attach()
command! NeotestOutput lua require("neotest").output.open()
]]
