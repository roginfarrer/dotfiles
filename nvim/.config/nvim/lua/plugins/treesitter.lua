return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-context', config = true },
    { 'lewis6991/spellsitter.nvim', config = true },
    'JoosepAlviste/nvim-ts-context-commentstring',
    'p00f/nvim-ts-rainbow',
    { 'windwp/nvim-ts-autotag', config = true },
  },
  opts = {
    ensure_installed = {
      'markdown',
      'javascript',
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
      'norg',
      'astro',
    },
    indent = { enable = true },
    highlight = {
      enable = true,
      -- use_languagetree = true,
      -- additional_vim_regex_highlighting = {
      --   'markdown',
      -- },
    },
    context_commentstring = { enable = true, enable_autocmd = false },
    autopairs = {
      enable = true,
    },
    rainbow = {
      enable = false,
      -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      -- colors = {}, -- table of hex strings
      -- termcolors = {} -- table of colour name strings
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
      enable = true,
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
    spellsitter = {
      enable = true,
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
