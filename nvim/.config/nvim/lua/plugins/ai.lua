return {
  {
    'zbirenbaum/copilot.lua',
    enabled = false,
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = true,
        keymap = {
          accept = '<C-y>',
          accept_word = false,
          accept_line = false,
          next = '<leader>]',
          prev = '<leader>[',
          dismiss = '<C-]>',
        },
      },
      copilot_node_command = vim.env.FNM_DIR .. '/node-versions/v22.14.0/installation/bin/node' or 'node',
    },
  },
  {
    'olimorris/codecompanion.nvim',
    enabled = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      strategies = {
        chat = {
          adapter = 'anthropic',
        },
        inline = {
          adapter = 'anthropic',
        },
      },
    },
  },
  {
    'Exafunction/windsurf.nvim',
    enabled = false,
    event = 'InsertEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      virtual_text = { enabled = true },
      enable_cmp_source = false,
    },
    config = function(_, opts)
      require('codeium').setup(opts)
    end,
  },
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   dependencies = {
  --     { 'nvim-lua/plenary.nvim' }, -- for curl, log and async functions
  --   },
  --   build = 'make tiktoken', -- Only on MacOS or Linux
  --   cmd = {
  --     'CopilotChatPrompts',
  --     'CopilotChatReview',
  --     'CopilotChatExplain',
  --     'CopilotChatFix',
  --     'CopilotChatOptimize',
  --     'CopilotChatDocs',
  --     'CopilotChatTests',
  --     'CopilotChatCommit',
  --     'CopilotChatModels',
  --   },
  --   opts = {
  --     -- See Configuration section for options
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = 'claude',
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
  },
  {
    'saghen/blink.cmp',
    optional = true,
    opts = function(_, opts)
      opts = opts or {}
      opts.sources = opts.sources or {}
      table.insert(opts.sources.default or {}, 1, 'avante')
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.avante = {
        module = 'blink-cmp-avante',
        name = 'Avante',
        opts = {
          -- options for blink-cmp-avante
        },
      }
      return opts
    end,
  },
}
