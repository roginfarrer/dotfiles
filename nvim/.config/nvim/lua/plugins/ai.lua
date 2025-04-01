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
}
