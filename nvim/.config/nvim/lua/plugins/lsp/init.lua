return {

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
      {
        'nvimdev/lspsaga.nvim',
        commit = '2198c07',
        opts = function()
          local opts = {
            lightbulb = {
              enable = false,
            },
          }
          local colors = vim.g.colors_name
          if string.match(colors, 'catppuccin') then
            opts.ui = {
              kind = require('catppuccin.groups.integrations.lsp_saga').custom_kind(),
            }
          end
          return opts
        end,
        event = 'LspAttach',
      },
      'hrsh7th/cmp-nvim-lsp',
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        cmd = 'LazyDev',
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            { path = 'lazy.nvim', words = { 'LazyVim' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
      { 'pmizio/typescript-tools.nvim', enabled = true },
      'davidosomething/format-ts-errors.nvim',
      { 'dnlhc/glance.nvim', opts = { list = { position = 'left' } } },
      {
        'williamboman/mason.nvim',
        lazy = false,
        cmd = { 'Mason' },
        opts = {},
        dependencies = {

          'WhoIsSethDaniel/mason-tool-installer.nvim',
          lazy = false,
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
              'vtsls',
              'html-lsp',
              'astro-language-server',
              'intelephense',
              -- Formatters
              'stylua',
              'shfmt',
              'prettier',
              -- DAP
              'chrome-debug-adapter',
              -- 'node-debug2-adapter',
            },
          },
        },
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
          filetype = 'markdown',
          focusable = true,
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
        -- require('plugins.lsp.formatting').setup(client, bufnr)
        require('plugins.lsp.mappings').setup(client, bufnr)
      end

      local options = { on_attach = on_attach, capabilities = capabilities }

      -- replace the default lsp diagnostic symbols
      for name, icon in pairs(require('ui.icons').lazy.diagnostics) do
        name = 'DiagnosticSign' .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
      end

      -- vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'
      -- print('_G.astro_server is ' .. _G.astro_server)

      local util = require 'lspconfig.util'

      -- local configs = require 'lspconfig.configs'
      -- configs.css_variables = {
      --   default_config = {
      --     cmd = {
      --       '/Users/rfarrer/projects/vscode-css-variables/packages/css-variables-language-server/bin/index.js',
      --       '--stdio',
      --     },
      --     filetypes = { 'css', 'scss', 'sass', 'less' },
      --     root_dir = function(fname)
      --       return require('lspconfig').util.find_git_ancestor(fname)
      --     end,
      --     settings = {
      --       cssVariables = {
      --         lookupFiles = { '**/*.less', '**/*.scss', '**/*.sass', '**/*.css' },
      --         blacklistFolders = {
      --           '**/.cache',
      --           '**/.DS_Store',
      --           '**/.git',
      --           '**/.hg',
      --           '**/.next',
      --           '**/.svn',
      --           '**/bower_components',
      --           '**/CVS',
      --           '**/dist',
      --           '**/node_modules',
      --           '**/tests',
      --           '**/tmp',
      --         },
      --       },
      --     },
      --   },
      -- }

      local servers = {
        -- efm = require 'plugins.lsp.efm',
        mdx_analyzer = { filetypes = { 'markdown.mdx', 'mdx' } },
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              codeLens = { enable = true },
              telemetry = { enable = false },
              hint = { enable = true },
            },
          },
        },
        css_variables = {},
        vtsls = {
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
            },
            typescript = {
              suggest = {
                completeFunctionCalls = true,
              },
              tsserver = {
                maxTsServerMemory = 8192,
              },
            },
          },
        },
        -- tsserver = {
        --   settings = {
        --     maxTsServerMemory = 8192,
        --     completions = {
        --       completeFunctionCalls = true,
        --     },
        --   },
        -- },
        eslint = {
          settings = {
            workingDirectories = { mode = 'auto' },
          },
        },
        bashls = { settings = { includeAllWorkspaceSymbols = true } },
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
        emmet_language_server = {},
        -- tailwindcss = {},
        intelephense = {
          settings = {
            intelephense = {
              files = {
                exclude = {
                  '**/.git/**',
                  '**/.svn/**',
                  '**/.hg/**',
                  '**/CVS/**',
                  '**/.DS_Store/**',
                  '**/node_modules/**',
                  '**/bower_components/**',
                  '**/htdocs_customshops/**',
                  '**/htdocs_gearman/**',
                  '**/htdocs/assets/dist/**',
                  '**/tmp/**',
                  '**vendor/*/{!(phpunit)/**}',
                  'translations/**',
                  '**/.phan/**',
                  '**/cron.d/**',
                  '**/generated/**',
                  '**/Generated/**',
                  '**/modules/css/**',
                  '**/__modules__*__src__/**',
                  'vendor/etsy/module-*/**',
                },
              },
            },
          },
        },
      }

      for server, opts in pairs(servers) do
        opts = vim.tbl_deep_extend('force', {}, options, opts or {})
        require('lspconfig')[server].setup(opts)
      end

      local function prefix_bun(cmd)
        return vim.list_extend({
          'bun',
          'run',
          '--bun',
        }, cmd)
      end
      local node_servers = { 'tsserver', 'jsonls', 'cssls', 'html', 'eslint', 'vtsls' }
      util.on_setup = util.add_hook_before(util.on_setup, function(config, user_config)
        if config.cmd and node_servers[config.name] then
          config.cmd = prefix_bun(config.cmd)
        end
      end)

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
