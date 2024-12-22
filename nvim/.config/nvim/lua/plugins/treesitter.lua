return {
  { 'sheerun/vim-polyglot', cond = vim.g.disable_treesitter },
  {
    'nvim-treesitter/nvim-treesitter',
    cond = not vim.g.disable_treesitter,
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    version = false, -- last release is way too old and doesn't work on Windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      -- { 'nvim-treesitter/nvim-treesitter-context', opts = {} },
      { 'JoosepAlviste/nvim-ts-context-commentstring', opts = { enable_autocmd = false } },
      { 'windwp/nvim-ts-autotag', opts = {} },
      { 'yorickpeterse/nvim-tree-pairs', opts = {} },
    },
    opts = {
      ensure_installed = {
        'markdown',
        'markdown_inline',
        -- 'javascript',
        -- 'typescript',
        -- 'tsx',
        -- 'css',
        -- 'bash',
        -- 'yaml',
        -- 'json',
        -- 'lua',
        -- 'toml',
        -- 'regex',
        -- 'php',
        -- 'graphql',
        -- 'vim',
        -- 'svelte',
        -- 'vue',
        -- 'scss',
        -- 'fish',
        -- 'astro',
        -- 'org',
        'diff',
        'git_config',
        'gitignore',
        'html',
      },
      query_linter = {
        enable = true,
        lint_events = { 'BufWrite', 'CursorHold' },
      },
      indent = { enable = true },
      highlight = {
        enable = true,
        -- use_languagetree = true,
        additional_vim_regex_highlighting = { 'org' },
      },
      autopairs = {
        enable = true,
      },
      autotag = {
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
      textobjects = {
        -- swap = {
        --   enable = true,
        --   swap_next = {
        --     ['<leader>fa'] = '@parameter.inner',
        --   },
        --   swap_previous = {
        --     ['<leader>fA'] = '@parameter.inner',
        --   },
        -- },
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['ab'] = '@block.outer',
            ['af'] = '@function.outer',
            ['aC'] = '@conditional.outer',
            ['ac'] = '@comment.outer',
            ['as'] = '@statement.outer',
            ['am'] = '@call.outer',
            ['aP'] = '@parameter.outer',

            ['ib'] = '@block.inner',
            ['if'] = '@function.inner',
            ['iC'] = '@conditional.inner',
            ['ic'] = '@comment.inner',
            ['is'] = '@statement.inner',
            ['im'] = '@call.inner',
            ['iP'] = '@parameter.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
      },
    },
    config = function(_, opts)
      vim.treesitter.language.register('markdown', { 'mdx' })
      -- require'nvim-treesitter.install'.compilers = { '/home/rfarrer/projects/gcc-14.2.0/bin/x86_64-pc-linux-gnu-gcc', '/home/rfarrer/projects/gcc-14.2.0/bin/gcc', '/home/rfarrer/projects/gcc-14.2.0/bin/c++'}

      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
