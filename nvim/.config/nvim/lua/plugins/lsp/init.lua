return {

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
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    cmd = 'LazyDev',
    dependencies = {
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'folke/lazydev.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'Bilal2453/luvit-meta', lazy = true },
      -- { 'pmizio/typescript-tools.nvim', enabled = true },
      -- 'davidosomething/format-ts-errors.nvim',
      { 'dnlhc/glance.nvim', opts = { list = { position = 'left' } } },
      'williamboman/mason.nvim',
    },
    config = function()
      require('util').autocmd('LspAttach', {
        group = 'lsp-attach',
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local bufnr = event.buf
          require('plugins.lsp.mappings').setup(client, bufnr)
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local hasCmp, cmpLsp = pcall(require, 'cmp_nvim_lsp')
      if hasCmp then
        capabilities = vim.tbl_deep_extend('force', capabilities, cmpLsp.default_capabilities())
      end

      local servers = {
        mdx_analyzer = { filetypes = { 'markdown.mdx', 'mdx' } },
        lua_ls = require 'plugins.lsp.lua_ls',
        -- css_variables = {},
        vtsls = require 'plugins.lsp.vtsls',
        -- ts_ls = require'plugins.lsp.tsserver',
        eslint = require 'plugins.lsp.eslint',
        bashls = { settings = { includeAllWorkspaceSymbols = true } },
        cssls = {},
        astro = {},
        marksman = {},
        html = {},
        jsonls = require 'plugins.lsp.json',
        stylelint_lsp = { filetypes = { 'css', 'less', 'scss' } },
        rust_analyzer = {},
        -- emmet_language_server = {},
        -- efm = { filetypes = { 'php' } },
        intelephense = require 'plugins.lsp.intelephense',
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'shfmt',
        'prettier',
      })

      require('mason-tool-installer').setup {
        run_on_start = false,
        ensure_installed = ensure_installed,
      }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name]
            if not server then
              return
            end
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- require('typescript-tools').setup {
      --   on_attach = function(client, bufnr)
      --     on_attach(client, bufnr)
      --     client.server_capabilities.documentFormattingProvider = false
      --     client.server_capabilities.documentRangeFormattingProvider = false
      --   end,
      --   settings = {
      --     expose_as_code_action = { 'fix_all', 'add_missing_imports', 'remove_unused' },
      --     tsserver_plugins = { 'styled-components' },
      --     complete_function_calls = true,
      --     tsserver_file_preferences = {
      --       includeInlayEnumMemberValueHints = true,
      --       includeInlayFunctionLikeReturnTypeHints = true,
      --       includeInlayFunctionParameterTypeHints = true,
      --       includeInlayParameterNameHints = 'all',
      --       includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      --       includeInlayPropertyDeclarationTypeHints = true,
      --       includeInlayVariableTypeHints = true,
      --     },
      --   },
      --   handlers = {
      --     ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
      --       if result.diagnostics == nil then
      --         return
      --       end

      --       -- ignore some tsserver diagnostics
      --       local idx = 1
      --       while idx <= #result.diagnostics do
      --         local entry = result.diagnostics[idx]

      --         local formatter = require('format-ts-errors')[entry.code]
      --         entry.message = formatter and formatter(entry.message) or entry.message

      --         -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
      --         if entry.code == 80001 then
      --           -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
      --           table.remove(result.diagnostics, idx)
      --         else
      --           idx = idx + 1
      --         end
      --       end

      --       vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
      --     end,
      --   },
      -- }
    end,
  },
}
