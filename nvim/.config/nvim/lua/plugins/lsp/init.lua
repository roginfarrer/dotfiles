return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      opts = {
        automatic_installation = true,
        ensure_installed = {
          -- language servers
          'typescript-language-server',
          'lua-language-server',
          'json-lsp',
          'eslint-lsp',
          'bash-language-server',
          'css-lsp',
          'stylelint-lsp',
          'marksman',
          'yaml-language-server',
          -- Formatters
          'prettierd',
          'stylua',
          'shfmt',
          -- Linters
          'vint',
        },
      },
    },
    config = true,
  },

  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'folke/which-key.nvim',
      -- 'glepnir/lspsaga.nvim',
      'folke/neodev.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'jose-elias-alvarez/typescript.nvim',
    },
    config = function()
      vim.diagnostic.config {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = false,
        float = {
          border = 'rounded',
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
          max_width = 80,
        },
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local function on_attach(client, bufnr)
        require('plugins.lsp.formatting').setup(client, bufnr)
        require('plugins.lsp.mappings').setup(client, bufnr)
      end

      local options = { on_attach = on_attach, capabilities = capabilities }

      -- replace the default lsp diagnostic symbols
      local function lspSymbol(name, icon)
        vim.fn.sign_define('DiagnosticSign' .. name, { text = icon, numhl = 'DiagnosticDefault' .. name })
      end

      lspSymbol('Error', '')
      lspSymbol('Information', '')
      lspSymbol('Hint', '')
      lspSymbol('Info', '')
      lspSymbol('Warn', '')

      -- vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
      -- print('_G.astro_server is ' .. _G.astro_server)

      local util = require 'lspconfig.util'

      local function get_typescript_server_path(root_dir)
        local git_root = util.find_git_ancestor(root_dir)

        local function seek(start)
          local project_root = util.find_node_modules_ancestor(start)
          local maybeFound = util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')

          if maybeFound then
            return maybeFound
          end

          if git_root ~= project_root then
            seek(util.path.basename(project_root))
          end
        end

        return seek(root_dir) or ''
      end

      local servers = {
        lua_ls = {},
        tsserver = {},
        eslint = {},
        bashls = {},
        cssls = {},
        astro = {
          root_dir = util.root_pattern '.git',
          -- on_new_config = function(new_config, new_root_dir)
          --   if
          --     new_config.init_options
          --     and new_config.init_options.typescript
          --     and new_config.init_options.typescript.serverPath == ''
          --   then
          --     new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
          --   end
          -- end,
        },
        marksman = {},
        html = {},
        jsonls = require 'plugins.lsp.json',
        stylelint_lsp = {
          filetypes = { 'css', 'less', 'scss' },
        },
      }

      require('neodev').setup {
        library = { plugins = { 'neotest' }, types = true },
      }

      for server, opts in pairs(servers) do
        opts = vim.tbl_deep_extend('force', {}, options, opts or {})
        if server == 'tsserver' then
          require('typescript').setup { server = opts }
        else
          require('lspconfig')[server].setup(opts)
        end
      end

      require('plugins.lsp.null-ls').setup(on_attach)
    end,
  },
}
