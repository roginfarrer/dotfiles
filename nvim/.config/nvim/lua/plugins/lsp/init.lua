return {

  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    cmd = 'LazyDev',
    dependencies = {
      { 'Bilal2453/luvit-meta', lazy = true },
      { 'gonstoll/wezterm-types', lazy = true },
    },
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        -- Needs `justinsgithub/wezterm-types` to be installed
        { path = 'wezterm-types', mods = { 'wezterm' } },
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
  --   opts = function(_, opts)
  --     return {
  --       sources = {
  --         -- add lazydev to your completion providers
  --         default = vim.fn.tbl_extend('keep', opts.sources.default or {}, 'lazydev'),
  --         providers = {
  --           lazydev = {
  --             name = 'LazyDev',
  --             module = 'lazydev.integrations.blink',
  --             -- make lazydev completions top priority (see `:h blink.cmp`)
  --             score_offset = 100,
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },

  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'folke/lazydev.nvim',
      -- 'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim',
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { 'Bilal2453/luvit-meta', lazy = true },
      -- 'davidosomething/format-ts-errors.nvim',
      { 'dnlhc/glance.nvim', enabled = false, opts = { list = { position = 'left' } } },
      { 'williamboman/mason.nvim', cmd = 'Mason' },
      {
        'pmizio/typescript-tools.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        enabled = true,
      },
    },
    cmd = 'Mason',
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
        capabilities = blinkCmp.get_lsp_capabilities()
      end

      local servers = {
        mdx_analyzer = { filetypes = { 'markdown.mdx', 'mdx' } },
        lua_ls = require 'plugins.lsp.lua_ls',
        -- css_variables = {},
        -- vtsls = require 'plugins.lsp.vtsls',
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
        intelephense = require 'plugins.lsp.intelephense',
      }
      local server_names = {}
      for name in pairs(servers) do
        table.insert(server_names, name)
      end

      require('mason').setup()

      require('plugins.lsp.typescript-tools').setup()

      require('mason-lspconfig').setup {
        automatic_enable = {
          exclude = { 'vtsls' },
        },
        ensure_installed = server_names,
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name]
            if not server then
              return
            end
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            -- server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            server.capabilities = blinkCmp.get_lsp_capabilities(server.capabilities)
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      require('mason-tool-installer').setup {
        run_on_start = true,
        ensure_installed = { 'stylua', 'shfmt', 'prettier', 'prettierd' },
      }

      if require('util').has 'mason-nvim-dap' then
        require('mason-nvim-dap').setup {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = false,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- 'js-debug-adapter',
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        }
      end
    end,
  },
}
