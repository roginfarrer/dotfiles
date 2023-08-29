return {

  { 'tomiis4/Hypersonic.nvim', cmd = 'Hypersonic' },
  {
    'bennypowers/nvim-regexplainer',
    lazy = true,
    opts = {},
    cmd = { 'RegexplainerShowSplit', 'RegexplainerShowPopup', 'RegexplainerHide', 'RegexplainerToggle' },
  },

  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh' },
    opts = { use_diagnostic_signs = true },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>', desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>xL', '<cmd>TroubleToggle loclist<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>TroubleToggle quickfix<cr>', desc = 'Quickfix List (Trouble)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').previous { skip_groups = true, jump = true }
          else
            vim.cmd.cprev()
          end
        end,
        desc = 'Previous trouble/quickfix item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next { skip_groups = true, jump = true }
          else
            vim.cmd.cnext()
          end
        end,
        desc = 'Next trouble/quickfix item',
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      -- 'folke/which-key.nvim',
      'folke/neodev.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      -- 'jose-elias-alvarez/typescript.nvim',
      -- 'yioneko/nvim-vtsls',
      'pmizio/typescript-tools.nvim',
      -- { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', opts = {} },
      { 'dnlhc/glance.nvim', opts = { list = { position = 'left' } } },
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
              -- 'prettierd',
              'stylua',
              'shfmt',
              -- Linters
              'vint',
              -- DAP
              'chrome-debug-adapter',
              'node-debug2-adapter',
            },
          },
        },
        config = true,
      },
    },
    config = function()
      vim.diagnostic.config {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = false,
        -- For lsp_lines
        virtual_lines = false,
        float = {
          border = { '🭽', '▔', '🭾', '▕', '🭿', '▁', '🭼', '▏' },
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

      local servers = {
        lua_ls = {},
        -- vtsls = {},
        -- tsserver = {},
        eslint = {},
        bashls = {},
        cssls = {},
        astro = {
          -- root_dir = util.root_pattern '.git',
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
        rust_analyzer = {},
      }

      require('neodev').setup {
        library = { plugins = { 'neotest' }, types = true },
      }

      if pcall(require, 'vtsls') then
        require('lspconfig.configs').vtsls = require('vtsls').lspconfig
      end

      for server, opts in pairs(servers) do
        opts = vim.tbl_deep_extend('force', {}, options, opts or {})
        require('lspconfig')[server].setup(opts)
        -- if server == 'tsserver' then
        --   require('typescript').setup { server = opts }
        -- else
        --   require('lspconfig')[server].setup(opts)
        -- end
      end

      local function prefix_bun(cmd)
        return vim.list_extend({
          'bun',
          'run',
          '--bun',
        }, cmd)
      end
      local node_servers = { 'tsserver', 'jsonls', 'cssls', 'html', 'eslint', 'astro', 'vtsls' }
      util.on_setup = util.add_hook_before(util.on_setup, function(config, user_config)
        if config.cmd and node_servers[config.name] then
          config.cmd = prefix_bun(config.cmd)
        end
      end)

      require('typescript-tools').setup {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          expose_as_code_action = { 'fix_all', 'add_missing_imports', 'remove_unused' },
          tsserver_plugins = { 'styled-components' },
          complete_function_calls = true,
        },
      }

      require('plugins.lsp.null-ls').setup(on_attach)
    end,
  },
}
