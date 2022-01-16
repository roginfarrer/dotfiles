local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg = {
  install_info = {
    url = 'https://github.com/nvim-neorg/tree-sitter-norg',
    files = { 'src/parser.c', 'src/scanner.cc' },
    branch = 'main',
  },
}

parser_configs.norg_meta = {
  install_info = {
    url = 'https://github.com/nvim-neorg/tree-sitter-norg-meta',
    files = { 'src/parser.c' },
    branch = 'main',
  },
}

parser_configs.norg_table = {
  install_info = {
    url = 'https://github.com/nvim-neorg/tree-sitter-norg-table',
    files = { 'src/parser.c' },
    branch = 'main',
  },
}

require('nvim-treesitter.configs').setup {
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
    'swift',
    'kotlin',
    'svelte',
    'vue',
    'scss',
    'fish',
  },
  indent = { enable = true },
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = {
      'markdown',
    },
  },
  context_commentstring = { enable = true, enable_autocmd = false },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
    filetypes = {
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
}

local autoTagPresent, autotag = pcall(require, 'nvim-ts-autotag')
if autoTagPresent then
  autotag.setup()
end
