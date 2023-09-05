return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  version = false, -- last release is way too old and doesn't work on Windows
  dependencies = {
    -- { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
    'JoosepAlviste/nvim-ts-context-commentstring',
    { 'windwp/nvim-ts-autotag', config = true },
  },
  opts = {
    ensure_installed = {
      'markdown',
      'javascript',
      'tsx',
      'typescript',
      'tsx',
      'css',
      'bash',
      'yaml',
      'json',
      'lua',
      'toml',
      'regex',
      'php',
      'graphql',
      'vim',
      'svelte',
      'vue',
      'scss',
      'fish',
      'astro',
      'org',
    },
    indent = { enable = true },
    highlight = {
      enable = true,
      -- use_languagetree = true,
      additional_vim_regex_highlighting = { 'org' },
    },
    context_commentstring = { enable = true, enable_autocmd = false },
    autopairs = {
      enable = true,
    },
    autotag = {
      enable = true,
      filetypes = {
        'astro',
        'html',
        'javascript',
        'javascriptreact',
        'typescriptreact',
        'svelte',
        'vue',
        'markdown',
        'telekasten',
        'mdx',
      },
    },
    context = {
      enable = false,
    },
    -- textobjects = {
    --   -- swap = {
    --   --   enable = true,
    --   --   swap_next = {
    --   --     ['<leader>fa'] = '@parameter.inner',
    --   --   },
    --   --   swap_previous = {
    --   --     ['<leader>fA'] = '@parameter.inner',
    --   --   },
    --   -- },
    --   select = {
    --     enable = true,
    --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    --     keymaps = {
    --       -- You can use the capture groups defined in textobjects.scm
    --       ['ab'] = '@block.outer',
    --       ['af'] = '@function.outer',
    --       ['aC'] = '@conditional.outer',
    --       ['ac'] = '@comment.outer',
    --       ['as'] = '@statement.outer',
    --       ['am'] = '@call.outer',
    --       ['aP'] = '@parameter.outer',

    --       ['ib'] = '@block.inner',
    --       ['if'] = '@function.inner',
    --       ['iC'] = '@conditional.inner',
    --       ['ic'] = '@comment.inner',
    --       ['is'] = '@statement.inner',
    --       ['im'] = '@call.inner',
    --       ['iP'] = '@parameter.inner',
    --     },
    --   },
    --   move = {
    --     enable = true,
    --     set_jumps = true, -- whether to set jumps in the jumplist
    --     goto_next_start = {
    --       [']m'] = '@function.outer',
    --       [']]'] = '@class.outer',
    --     },
    --     goto_next_end = {
    --       [']M'] = '@function.outer',
    --       [']['] = '@class.outer',
    --     },
    --     goto_previous_start = {
    --       ['[m'] = '@function.outer',
    --       ['[['] = '@class.outer',
    --     },
    --     goto_previous_end = {
    --       ['[M'] = '@function.outer',
    --       ['[]'] = '@class.outer',
    --     },
    --   },
    -- },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
