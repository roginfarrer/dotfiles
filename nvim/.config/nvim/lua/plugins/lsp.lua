local methods = vim.lsp.protocol.Methods

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
  ---@param v KeymapUtil
  local function map(v)
    require('util').keymap(vim.tbl_deep_extend('force', v, { buffer = bufnr }))
  end

  map {
    'K',
    function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        if vim.bo.filetype == 'vim' or vim.bo.filetype == 'help' then
          vim.fn.execute('h ' .. vim.fn.expand '<cword>')
        else
          vim.lsp.buf.hover()
        end
      end
    end,
    desc = 'Hover Docs',
  }
  map {
    'gK',
    function()
      if vim.bo.filetype == 'lua' or vim.bo.filetype == 'help' or vim.bo.filetype == 'lua' then
        vim.fn.execute('h ' .. vim.fn.expand '<cword>')
      end
    end,
    desc = 'Neovim Docs',
  }

  vim.lsp.document_color.enable(true, bufnr)

  if client:supports_method(methods.textDocument_documentHighlight) then
    local under_cursor_highlights_group = vim.api.nvim_create_augroup('rfarrer/cursor_highlights', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
      group = under_cursor_highlights_group,
      desc = 'Highlight references under the cursor',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
      group = under_cursor_highlights_group,
      desc = 'Clear highlight references',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

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

  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'folke/lazydev.nvim',
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { 'Bilal2453/luvit-meta', lazy = true },
      { 'williamboman/mason.nvim', cmd = 'Mason' },
    },
    cmd = 'Mason',
    config = function()
      require('util').autocmd('LspAttach', {
        group = 'lsp-attach',
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local bufnr = event.buf

          if not client then
            return
          end

          on_attach(client, bufnr)
        end,
      })

      require('mason').setup()

      -- require('plugins.lsp.typescript-tools').setup()
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      -- Read all files in lsp-configs directory and assign the filename to vim.lsp.config with the table returned by that file.
      -- The configs defined in lspconfig lua/ overrides the confings defined in my lsp/ directory
      -- If the configs are defined here with vim.lsp.config, mine will override lspconfig
      local configs = vim.fn.glob(vim.fn.stdpath 'config' .. '/lua/lsp-configs/*.lua', true, true)
      for _, file in ipairs(configs) do
        local module_name = vim.fn.fnamemodify(file, ':t:r')
        vim.lsp.config(module_name, require('lsp-configs.' .. module_name))
      end

      vim.lsp.enable {
        -- 'mdx_analyzer',
        'lua_ls',
        'vtsls',
        'eslint',
        'bashls',
        'cssls',
        'astro',
        'marksman',
        'html',
        'jsonls',
        'stylelint_lsp',
        'rust_analyzer',
        'intelephense',
      }

      require('mason-tool-installer').setup {
        run_on_start = true,
        ensure_installed = { 'stylua', 'shfmt', 'prettier', 'prettierd' },
      }

      if require('util').has 'mason-nvim-dap' then
        require('mason-nvim-dap').setup {
          automatic_installation = false,
          handlers = {},
          ensure_installed = {},
        }
      end

      -- Update mappings when registering dynamic capabilities.
      local register_capability = vim.lsp.handlers[methods.client_registerCapability]
      vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        if not client then
          return
        end

        on_attach(client, vim.api.nvim_get_current_buf())

        return register_capability(err, res, ctx)
      end
    end,
  },

  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    enabled = false,
    opts = {
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
      settings = {
        separate_diagnostic_server = true,
        expose_as_code_action = 'all',
        tsserver_max_memory = 8192,
        tsserver_file_preferences = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          importModuleSpecifierPreference = 'non-relative',
        },
      },
    },
  },
}
