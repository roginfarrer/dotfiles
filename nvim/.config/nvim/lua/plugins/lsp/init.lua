return {
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh' },
    opts = function()
      if require('util').has 'ibhagwan/fzf-lua' then
        local config = require 'fzf-lua.config'
        local actions = require('trouble.sources.fzf').actions
        config.defaults.actions.files['ctrl-t'] = actions.open
      end
      return { use_diagnostic_signs = true }
    end,
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)' },
      { '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
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
  { -- optional cmp completion source for require statements and module annotations
    'hrsh7th/nvim-cmp',
    optional = true,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = 'lazydev',
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  -- { -- optional blink completion source for require statements and module annotations
  --   'saghen/blink.cmp',
  --   optional = true,
  --   opts = {
  --     sources = {
  --       -- add lazydev to your completion providers
  --       default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
  --       providers = {
  --         lazydev = {
  --           name = 'LazyDev',
  --           module = 'lazydev.integrations.blink',
  --           -- make lazydev completions top priority (see `:h blink.cmp`)
  --           score_offset = 100,
  --         },
  --       },
  --     },
  --   },
  -- },

  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'folke/lazydev.nvim',
      -- 'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'Bilal2453/luvit-meta', lazy = true },
      -- { 'pmizio/typescript-tools.nvim', enabled = true },
      -- 'davidosomething/format-ts-errors.nvim',
      { 'dnlhc/glance.nvim', enabled = false, opts = { list = { position = 'left' } } },
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
      local hasBlink, blinkCmp = pcall(require, 'blink.cmp')
      if hasBlink then
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
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

      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        automatic_installation = false,
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

      require('mason-tool-installer').setup {
        run_on_start = false,
        ensure_installed = { 'stylua', 'shfmt', 'prettier', 'prettierd' },
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
