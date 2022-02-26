local temp_dir = vim.loop.os_getenv 'TEMP' or '/tmp'

local function join_paths(...)
  local path_sep = '/'
  local result = table.concat({ ... }, path_sep)
  return result
end

vim.cmd [[set runtimepath=$VIMRUNTIME]]
vim.cmd('set packpath=' .. join_paths(temp_dir, 'nvim', 'site'))

local package_root = join_paths(temp_dir, 'nvim', 'site', 'pack')
local install_path = join_paths(package_root, 'packer', 'start', 'packer.nvim')
local compile_path = join_paths(install_path, 'plugin', 'packer_compiled.lua')

local function load_plugins()
  local is_ok, packer = pcall(require, 'packer')
  if not is_ok then
    print 'Packer not found'
    return
  end
  packer.startup {
    {
      'wbthomason/packer.nvim',
      'neovim/nvim-lspconfig',
    },
    config = {
      package_root = package_root,
      compile_path = compile_path,
    },
  }
end

_G.load_config = function()
  local lsp = vim.lsp
  local handlers = lsp.handlers

  _G.mergetable = function(tableA, tableB)
    local tbl = tableA
    for k, v in pairs(tableB) do
      tbl[k] = v
    end
    return tbl
  end

  local opts = { border = 'rounded' }
  handlers['textDocument/hover'] = lsp.with(handlers.hover, opts)
  handlers['textDocument/signatureHelp'] = lsp.with(
    handlers.signature_help,
    opts
  )
  vim.diagnostic.config {
    virtual_text = false,
    float = {
      format = function(diagnostic)
        if diagnostic.source == 'eslint' then
          return string.format(
            '%s [%s]',
            diagnostic.message,
            -- shows the name of the rule
            diagnostic.user_data.lsp.code
          )
        end
        return string.format('%s [%s]', diagnostic.message, diagnostic.source)
      end,
      severity_sort = true,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
    },
  }

  vim.lsp.set_log_level 'trace'
  if vim.fn.has 'nvim-0.5.1' == 1 then
    require('vim.lsp.log').set_format_func(vim.inspect)
  end
  local nvim_lsp = require 'lspconfig'
  local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap(
      'n',
      '<C-k>',
      '<cmd>lua vim.lsp.buf.signature_help()<CR>',
      opts
    )
    buf_set_keymap(
      'n',
      '<space>wa',
      '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',
      opts
    )
    buf_set_keymap(
      'n',
      '<space>wr',
      '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
      opts
    )
    buf_set_keymap(
      'n',
      '<space>wl',
      '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
      opts
    )
    buf_set_keymap(
      'n',
      '<space>D',
      '<cmd>lua vim.lsp.buf.type_definition()<CR>',
      opts
    )
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap(
      'n',
      '<space>e',
      '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
      opts
    )
    buf_set_keymap(
      'n',
      '[d',
      '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
      opts
    )
    buf_set_keymap(
      'n',
      ']d',
      '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
      opts
    )
    buf_set_keymap(
      'n',
      '<space>q',
      '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',
      opts
    )
  end

  -- Add the server that troubles you here
  nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    cmd = { 'typescript-language-server', '--stdio' },
  }
  nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = { 'lua-language-server' },
  }

  print [[You can find your log at $HOME/.cache/nvim/lsp.log. Please paste in a github issue under a details tag as described in the issue template.]]
end

if vim.fn.isdirectory(install_path) == 0 then
  vim.fn.system {
    'git',
    'clone',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  -- Use a protected call so we don't error out on first use
  -- vim.cmd [[packadd packer.nvim]]
  load_plugins()
  require('packer').sync()
  vim.cmd [[autocmd User PackerComplete ++once lua load_config()]]
else
  load_plugins()
  -- require('packer').sync()
  _G.load_config()
end
